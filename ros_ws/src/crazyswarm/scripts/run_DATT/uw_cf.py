#!/usr/bin/env python
import signal
import sys
import time
import os
sys.path.append('..')

import argparse
from easydict import EasyDict
import numpy as np
from scipy.spatial.transform import Rotation as R
import yaml
import copy
import matplotlib.pyplot as plt

from cf_utils.rigid_body import State_struct
# from ref_traj import Trajectories
from DATT.quadsim.dist import WindField, ConstantForce

from collections import deque
from Controllers import *
from DATT.refs import TrajectoryRef, takeofflanding_ref


from DATT.refs.gen_trajectory import Trajectory

# Actual Drone
import rospy
from geometry_msgs.msg import PoseStamped
from pycrazyswarm import Crazyswarm

# Quadsim simulator
from DATT.quadsim.sim import QuadSim
from DATT.quadsim.models import IdentityModel, crazyflieModel

from pathlib import Path

from DATT.refs.random_zigzag import RandomZigzag

from DATT.configuration.configuration import AllConfig
from DATT.controllers.cntrl_config import PIDConfig
from DATT.controllers  import cntrl_config_presets
from DATT.configuration.cf import datt_config


np.set_printoptions(linewidth=np.inf)

sleepRate = 50

class ctrlCF():
    
    def __init__(self,
                 run_args,
                 cfName='cf0'):
        
        self.cfName = cfName
        self.isSim = run_args.quadsim
        self.logfile = run_args.logfile
        self.debug = run_args.debug
        self.gui = run_args.gui
        self.viz_sim = run_args.viz
        self.adaptation_warmup_value = np.zeros(4)

        self.initialized = False

        self.state = State_struct()
        self.prev_state = State_struct()
        # self.ref = State_struct()
        # self.ref_func = None
        # self._ref_func_obj = RandomZigzag()

        self.def_seed = run_args.seed

        with open(run_args.config,"r") as f:
            self.exp_config = yaml.full_load(f)
        
        # if "def_cntrl" in self.exp_config :
        #     self.default_controller = (globals()[self.exp_config["def_cntrl"][0]["cntrl"]])(isSim = self.isSim, 
        #                                                                                 policy_config = self.exp_config["def_cntrl"][0]["policy_config"],
        #                                                                                 adaptive = self.exp_config["def_cntrl"][0]["adaptive"])
        # else:
        self.default_controller = PIDController(datt_config, cntrl_config_presets.pid_config)
        self.ref_func = RandomZigzag()
        self.default_controller.ref_func = self.ref_func
        
        warmup_inputs = {
            't' : 0.1, 
            'state' : self.state, 
        }
        self.default_controller.response(**warmup_inputs)

        self.curr_controller = self.default_controller



        # Reusing controllers if tasks require the exact same controller with same the same policy. 
        # keys of the dict are saved as cntrl+"_"+policy_config
        self.controllers = { }        
        
        print(self.exp_config["tasks"])
        for i in range(len(self.exp_config["tasks"])):
            ctrl_policy = self.exp_config["tasks"][i]["cntrl"] + "_" + self.exp_config["tasks"][i]["config"]
            # Checking if controller is already initialized
            if ctrl_policy in self.controllers.keys():
                pass
            else:
                
                cntrl_config = getattr(cntrl_config_presets, self.exp_config["tasks"][i]["config"])
                self.controllers[ctrl_policy] = (globals()[self.exp_config["tasks"][i]["cntrl"]])(datt_config, cntrl_config)
                # Warming up controller

                self.controllers[ctrl_policy].response(**warmup_inputs)
                # self.controller.trajectories = Trajectories
        

        if not self.isSim:
            self.swarm = Crazyswarm(crazyflies_yaml='../../launch/custom_crazyflies.yaml')
            rospy.Subscriber("/"+self.cfName+"/pose", PoseStamped, self.state_callback)
            rospy.on_shutdown(self.shutdown_callback)
            self.emergency_signal = 0
            self.cf = self.swarm.allcfs.crazyflies[0]

        else:
            # model = crazyflieModel()
            model = IdentityModel()
            self.cf = QuadSim(model, vis=self.viz_sim)
            eu = np.array([0., 0., 0.])
            rot = R.from_euler('xyz', eu)
            init_state = State_struct(rot = rot)
            self.cf.setstate(init_state)
            self.dt = 0.02

        self.set_logging_arrays()
        self.set_tasks()
        self.motrack_offset = np.array([0.,0.,0.])
        self.cf_orientation_offset = np.array([0.,0.,0.])


    ######### E STOPS ################
    def shutdown_callback(self,):
        print("Shutting down ROS!")

    def emergency_handler(self,signum,frame):
        '''
        Intercepts Ctrl+C from the User and stops the motor of the drone.
        '''
        print("User Emergency Stop!")
        self.swarm.allcfs.emergency()
        self.write_to_log()
        exit()
    
    def BB_failsafe(self,):
        '''
        Bounding Box Fail Safe

        If the drone goes outside the bounding box dimensions(as provided in the config file),
        The motors are stopped. The Bounding box is made by taking the `self.init_pos` as the center
        of the bounding box.
        '''
        pos = self.state.pos
        w_bound = self.exp_config["E_BB_width"]
        h_bound = self.exp_config["E_BB_height"]
        if abs(pos[0] - self.init_pos[0]) > w_bound / 2 or abs(pos[1] - self.init_pos[1]) > w_bound / 2 or pos[2]>h_bound:
            print('Out of Bounding Box EMERGENCY STOP!!')
            self.swarm.allcfs.emergency()
            self.write_to_log()
            exit()
    ##################################

    ##### MAIN LOOP Init functions ########
    def set_logging_arrays(self,):
        self.pose_positions = []
        self.cf_positions = []
        self.pose_orientations = []
        self.ref_positions = []
        self.ref_orientation = []
        self.ts = []
        self.thrust_cmds = []
        self.ang_vel_cmds = []
        self.adaptation_terms = []
        # self.ref_vel = []

        self.pose_orient_mocap=[]

        self.ppo_acc = []
        self.ppo_ang = []

    def set_tasks(self,):
        self.tasks = []
        if self.exp_config["tasks"] is not None:
            self.tasks = self.exp_config["tasks"]

        self.flag= {
                    "takeoff": 0,
                    "land": 0,
                    "warmup": 0,
                    "tasks":[0] * len(self.tasks)}

        self.task_num = -1

    def init_loop_params(self,):
        '''
        Initializing all the parameters required in the loop.

        self.trajs -> instance of Trajectory class which has multiple trajectory functions. 
        
        self.warmup_time -> Wierd issue about kalman filter taking almost 10 secs to warm up. 
                            Setting an offset time to make sure the pose data to the drone 
                            is without any major lag

        self.land_buffer -> Basically stores the last 5 Z positions while landing. When mean 
                            of the Z position is less than a threshold, landing is complete 
                            and drone stops
        '''
        # All tasks are done taking the offset position (point after takeoff) as the origin
        # self.trajs = Trajectories(self.init_pos, self.gui)x
        # self.ref_func = getattr(self.trajs, self.tasks[self.task_num]["ref"])

        # Making a landing position buffer
        self.land_buffer = deque([0.]*5)
        
        self.takeoff_time = self.exp_config["takeoff_height"]/self.exp_config["takeoff_rate"]
        self.warmup_time = self.exp_config["kalman_warmup"]
        
        if self.debug:
            self.takeoff_time = 100000

        self.land_start_timer = 0. # for landing
        self.tasks_time = 0.  # setting time limit for each task
        self.prev_task_time = 0. # elapsed time just before the task, so tha the task can start with 0. sec 
    #####################################

    ##### State estimation ###########
    def state_callback(self, data):
        '''
        A ros subscriber to `/cfX/pose` message. 
        Numerically calculates the translational velocity of the drone
        '''
        pos = data.pose.position
        rot = data.pose.orientation

        self.state.t = rospy.get_time()
        self.pose_pos = np.array([pos.x, pos.y, pos.z])
        self.pos_pos = self.cf.position()
        # self.motrack_orientation = self.cf.orientation()
        # self.motrack_orientation = R.from_quat(self.motrack_orientation)

        motrack_orientation_quat = self.cf.orientation()
        motrack_orientation = R.from_quat(motrack_orientation_quat)
        motrack_orientation_euler = motrack_orientation.as_euler("ZYX") - self.motrack_offset
        self.motrack_orientation = R.from_euler("ZYX", motrack_orientation_euler)

        if self.initialized == False:
            self.motrack_offset = np.copy(motrack_orientation_euler)

        rot = np.array([rot.x, rot.y, rot.z, rot.w])
        # self.cf_orientation = R>from_quat()

        # Adding ROS subscribed data to state
        self.state.pos = self.pose_pos
        self.state.vel = (self.state.pos - self.prev_state.pos) / (0.02) 
        self.state.rot = R.from_quat(rot)
        self.prev_state = copy.deepcopy(self.state)
        self.initialized = True
    #####################################


    def _send2cfClient(self, cf, z_acc, ang_vel):
        '''
        Hacky Way!
        Takes the Z accelerations and angular velocities from the controllers and sends
        these values to the firmware via crazyswarm's `cmdFullState`

        Note: self.ref.pos is sent not for any controls purpose. It is a hacky way of 
              sending reference positions to the firmware for logging.
        '''
        pos = self.ref.pos 
        vel = [0, 0, 0]
        acc = [0, 0, z_acc]
        yaw = 0
        omega = ang_vel.tolist()
        cf.cmdFullState(pos, vel, acc, yaw,omega)

    def land(self,):
        pass

    
    ####### Log all the data at the end #########
    def write_to_log(self):

        if not self.isSim:
            # Rwik :
            # LOG_DIR = Path().home() / 'rwik_hdd/drones' / 'crazyswarm' / 'logs'
            LOG_DIR = os.path.dirname(os.path.abspath(__file__)) + "/../../../../../logs/CORL/aug_11/real/"

            # Guanya :
            # LOG_DIR = Path().home() / 'rwik_hdd/drones' / 'crazyswarm' / 'logs/'

            
            # Kevin : 
            # LOG_DIR = Path().home() / 'Drones' / 'crazyswarm_new' / 'logs'
    
            self.pose_positions = np.array(self.pose_positions)
            self.pose_orientations = np.array(self.pose_orientations)
            self.cf_positions = np.array(self.cf_positions)
            self.ref_orientation = np.array(self.ref_orientation)
            self.ref_positions = np.array(self.ref_positions)
            self.ts = np.array(self.ts)
            self.thrust_cmds = np.array(self.thrust_cmds)
            self.ang_vel_cmds = np.array(self.ang_vel_cmds)
            # self.ref_vel = np.array(self.ref_vel)

            self.pose_orient_mocap = np.array(self.pose_orient_mocap)
            self.adaptation_terms = np.array(self.adaptation_terms)
    
            # self.ppo_acc = np.array(self.ppo_acc)
            # self.ppo_ang = np.array(self.ppo_ang)
    
            np.savez(LOG_DIR + self.logfile, 
                pose_positions=self.pose_positions,
                pose_orientations=self.pose_orientations,
                motrack_orientation = self.pose_orient_mocap,
                cf_positions=self.cf_positions,
                ref_positions = self.ref_positions,
                ref_orientation = self.ref_orientation,
                ang_vel_cmds=self.ang_vel_cmds,
                ts=self.ts,
                thrust_cmds=self.thrust_cmds,
                adaptation_terms = self.adaptation_terms
                # ppo_ang = self.ppo_ang,
                # ppo_acc = self.ppo_acc,
            )
        else:

            # Rwik :
            # LOG_DIR = Path().home() / 'rwik_hdd/drones' / 'crazyswarm' / 'sim_logs'
            
            # Guanya :
            # LOG_DIR = Path().home() / 'rwik/drones' / 'crazyswarm' / 'sim_logs'
            LOG_DIR = os.path.dirname(os.path.abspath(__file__)) + "/../../../../../logs/CORL/aug_11/sim/"
            # LOG_DIR = os.path.dirname(os.path.abspath(__file__)) + "/../../../../../sim_logs/"

            # Kevin : 
            # LOG_DIR = Path().home() / 'Drones' / 'crazyswarm_new' / 'logs'
        
            self.pose_positions = np.array(self.pose_positions)
            self.pose_orientations = np.array(self.pose_orientations)
            self.ref_orientation = np.array(self.ref_orientation)
            self.ref_positions = np.array(self.ref_positions)
            self.ts = np.array(self.ts)
            self.thrust_cmds = np.array(self.thrust_cmds)
            self.ang_vel_cmds = np.array(self.ang_vel_cmds)
            # self.adaptation_terms = np.array(self.adaptation_terms)

            # self.ref_vel = np.array(self.ref_vel)
            print(LOG_DIR + self.logfile)
            np.savez(LOG_DIR + self.logfile, 
                    pose_positions=self.pose_positions,
                    pose_orientations=self.pose_orientations,
                    ref_positions = self.ref_positions,
                    ref_orientation = self.ref_orientation,
                    ang_vel_cmds=self.ang_vel_cmds,
                    ts=self.ts,
                    thrust_cmds=self.thrust_cmds,
                    )
    
    def switch_controller(self,offset_pos):
        ###### Setting the controller for the particular task
        if self.task_num>=0 and self.task_num<len(self.tasks):
            controller_key = self.exp_config["tasks"][self.task_num]["cntrl"] + "_" + self.exp_config["tasks"][self.task_num]["config"]
            self.curr_controller = self.controllers[controller_key]
            # self.curr_controller.offset_pos = np.copy(offset_pos)
            self.curr_controller.ref_func = self.ref_func
        else:
            # PID controller for takeoff and landing
            self.curr_controller = self.default_controller
            # self.curr_controller.offset_pos = np.copy(offset_pos)
            self.curr_controller.ref_func = self.ref_func

    def set_refs_from_tasks(self,t,offset_pos):
        '''
        Iterates over the tasks by keeping tabs on the timer. 

        self.tasks is intialized in the `set_tasks()` function. It is basically an array
        of tasks mentioned in the configuration file.

        self.task_num is the index of self.tasks currently being completed by the drone.
        NOTE: take off and landing are not considered in this task
        '''
        # self.trajs.curr_state = copy.deepcopy(self.state)

        if t >= self.takeoff_time+self.tasks_time+self.warmup_time:
            self.task_num+=1
            self.switch_controller(offset_pos)

        ###########################################################################
        if t<self.warmup_time:
            if self.warmup_time-t<3 and self.flag["warmup"]==0:
                self.flag["warmup"]=1
                print("Taking off in 10 seconds ..... ")

        ###### Take off Function
        elif t<self.takeoff_time + self.warmup_time:
            if self.flag["takeoff"]==0:
                print("********* TAKEOFF **********")
                self.flag["takeoff"] = 1
                final_pt = np.array([0., 0., self.exp_config["takeoff_height"],])
                self.ref_func = takeofflanding_ref(final_pt, self.exp_config['takeoff_rate'], self.state, offset_pos=np.zeros(3))
                self.curr_controller.ref_func = self.ref_func

        ###### Tasks
        # Switching to the tasks and getting the reference trajectory positions
        
        elif self.task_num < len(self.tasks):
            if self.flag["tasks"][self.task_num] == 0:
                self.prev_task_time = t
                print( "*****" + self.tasks[self.task_num]["description"] + "*****")

                self.flag["tasks"][self.task_num] = 1 
                self.tasks_time += self.tasks[self.task_num]["time"]

                ref_kwargs = {}

                if 'maxes' in self.tasks[self.task_num].keys(): 
                    ref_kwargs['y_max'] = self.tasks[self.task_num]["maxes"][1]
                    ref_kwargs['z_max'] = self.tasks[self.task_num]["maxes"][2]

                if self.def_seed is None:
                    if 'seed' in self.tasks[self.task_num].keys(): 
                        ref_kwargs['seed'] = self.tasks[self.task_num]["seed"]
                    else:
                        ref_kwargs['seed'] = 0
                else:
                    ref_kwargs['seed'] = self.def_seed

                ref_func = TrajectoryRef.get_by_value(self.tasks[self.task_num]["ref"])
                self.ref_func = ref_func.ref_cf(**ref_kwargs)

                self.curr_controller.ref_func = self.ref_func
                self.curr_controller.start_pos = self.state.pos

            virtual_time = t - self.prev_task_time
            # if t < self.takeoff_time + self.warmup_time + self.tasks_time:
            #     self.trajs.curr_state.pos -= offset_pos
            #     self.ref, _, self._ref_func_obj = self.ref_func(t-self.prev_task_time)
            #     self.ref.pos += offset_pos           

        ###### Landing
        else:
            if self.flag["land"]==0:
                # self.trajs.last_state = copy.deepcopy(self.state)
                # self.trajs.land = True
                final_pt = np.array([self.state.pos[0], self.state.pos[1], self.exp_config["landing_height"],])
                self.ref_func = takeofflanding_ref(final_pt, self.exp_config['landing_rate'], self.state, offset_pos=np.zeros(3))

                print("********* LAND **********")
                self.flag["land"] = 1

                self.curr_controller.ref_func = self.ref_func

                
            # self.ref,_ ,self._ref_func_obj= self.trajs.set_landing_ref(t - self.land_start_timer, 
            #                                         self.exp_config["landing_height"],
            #                                         self.exp_config["landing_rate"])  
                 
            # self.ref_func = self.trajs.set_landing_ref
            
            if self.state.pos[-1] < self.exp_config["landing_height"] + 0.05:
                print("***** Flight done! ******")
                self.flag['land'] = 2

        # Iterating over the tasks
        # if t >= self.takeoff_time+self.tasks_time+self.warmup_time:
            # self.switch_controller(offset_pos)
        
        virtual_time = t - self.prev_task_time
        ref_pos = self.ref_func.pos(virtual_time)
        ref_vel = self.ref_func.vel(virtual_time)
        self.ref = State_struct(ref_pos, ref_vel)

        self.ref_func.curr_pose = self.state

        # if self.task_num < len(self.tasks):
            # print(ref_pos)

        

    def main_loop_cf(self,):
        timeHelper = self.swarm.timeHelper
        signal.signal(signal.SIGINT, self.emergency_handler)  # Handling Ctrl+C

        try:
            while not self.initialized:
                pass
        except KeyboardInterrupt:
            exit()
        print('Initialized!')
        
        # All tasks are done taking the offset position (point after takeoff) as the origin
        self.init_pos = np.copy(self.state.pos)
        self.init_loop_params()
        offset_pos = self.init_pos+np.array([0., 0., self.exp_config["takeoff_height"]])
        
        t = 0.0
        startTime = timeHelper.time()
        while not rospy.is_shutdown():
            t = timeHelper.time() - startTime
            if not self.debug:
                self.BB_failsafe() # Bounding Box Failsafe

            
                # Setting the refernce trajectory points from the tasks stated in the configuration file
        
                self.set_refs_from_tasks(t, offset_pos)
                
                # Sending state data to the controller
                z_acc,ang_vel = 0.,np.array([0.,0.,0.])      
                if t>self.warmup_time:
                    z_acc,ang_vel = self.curr_controller.response(t = t - self.prev_task_time, 
                                                                state = self.state, 
                                                                )

                # self.adaptation_terms.append(np.copy(self.curr_controller.adaptation_terms))

                self.pose_positions.append(np.copy(self.pose_pos))
                self.pose_orientations.append(self.state.rot.as_euler('ZYX', degrees=True))
                self.pose_orient_mocap.append(self.motrack_orientation.as_euler("ZYX",degrees=True))
                self.cf_positions.append(self.cf.position())
                self.ref_positions.append(np.copy(self.ref.pos))
                self.ref_orientation.append(self.ref.rot.as_euler('ZYX',degrees=True))
                self.ts.append(t)
                self.thrust_cmds.append(z_acc)
                self.ang_vel_cmds.append(ang_vel * 180 / (2 * np.pi))


            # Setting motors to 0, if landing is complete
            if self.flag["land"] == 2:
                z_acc, ang_vel = 0., np.zeros(3)
            if self.flag["land"] == 0:
                self.land_start_timer = t

            if self.debug:
                z_acc = 0.0
                ang_vel = np.zeros(3)
                # print('MT : ', self.motrack_orientation.as_euler('ZYX', degrees=True), "time",t)
                # print('CF : ', self.state.rot.as_euler('ZYX', degrees=True), "time",t , '\n')
                # print('MT : ', self.motrack_p, "time",t)
                print('CF : ', self.state.pos, "time",t , '\n')
                self.pose_positions.append(np.copy(self.pose_pos))
                self.pose_orientations.append(np.copy(self.state.rot.as_euler('ZYX', degrees=True)))
                self.pose_orient_mocap.append(np.copy(self.motrack_orientation.as_euler("ZYX",degrees=True)))
                self.cf_positions.append(np.copy(self.cf.position()))
                self.ts.append(t)

                self.thrust_cmds.append(z_acc)
                self.ang_vel_cmds.append(ang_vel * 180 / (2 * np.pi))


            self._send2cfClient(self.cf, z_acc, ang_vel)

            timeHelper.sleepForRate(sleepRate)

            if self.flag["land"] == 2:
                break
    
    
    # Simulation
    def update_sim_states(self, quadsim_state):
        # quadsim_state = self.add_observation_noise(quadsim_state)
        # import pdb;pdb.set_trace()
        self.state.pos = quadsim_state.pos
        self.state.rot = quadsim_state.rot
        self.state.vel = quadsim_state.vel
        self.state.ang = quadsim_state.ang

    
    def add_observation_noise(self, state):
        state.pos += np.random.normal(loc=0.0, scale=0.01, size=3)
        return state

    def main_loop_sim(self,):

        # All tasks are done taking the offset position (point after takeoff) as the origin
        self.init_pos = np.array([0., 0., 0.])
        self.init_loop_params()
        offset_pos = self.init_pos + np.array([0., 0., self.exp_config["takeoff_height"]])

        # Initializing States from the Quadsim Environment
        quadsim_state = self.cf.rb.state()
        self.update_sim_states(quadsim_state)

        i = 0.
        t = 0. 
        while True:

            # Setting the refernce trajectory points from the tasks stated in the configuration file
    
            self.set_refs_from_tasks(t, offset_pos)

            # Send controller commands to the simulator and simulate the dynamics
            z_acc, ang_vel = 0., np.array([0., 0., 0.])

            dist = [ConstantForce(scale=np.array([0.0, 0.0, 0]))]
            if t > self.warmup_time:
                # z_acc, ang_vel = self.curr_controller.response(t = t - self.prev_task_time, 
                #                                                state = self.state, 
                #                                                )   
                # self.adaptation_terms.append(np.copy(self.curr_controller.adaptation_terms))
                                                                            
                # obs_state = self.cf.step_angvel_raw(self.dt, z_acc * self.cf.mass, ang_vel, k=0.4, dists=dist)
                obs_state = self.cf._step_angvel(t - self.prev_task_time, self.dt, self.curr_controller, dists=dist)
            # End Flight if landed
            if self.flag["land"] == 2:
                z_acc, ang_vel = 0., np.zeros(3)
            if self.flag["land"] == 0:
                self.land_start_timer = t

            # Quadsim and State update in the simulation and Visualisation
            quadsim_state = self.cf.rb.state()
            if t <= self.warmup_time:
                self.update_sim_states(quadsim_state)
            else:
                self.update_sim_states(obs_state)
            


            # if t > self.warmup_time:
            #     import pdb;pdb.set_trace()
            # import pdb;pdb.set_trace()
            # Logging
            self.pose_positions.append(np.copy(self.state.pos))
            self.pose_orientations.append(self.state.rot.as_euler('ZYX', degrees=True))
            self.ref_positions.append(np.copy(self.ref.pos))
            self.ref_orientation.append(self.ref.rot.as_euler('ZYX', degrees=True))
            self.ts.append(t)
            # self.ref_vel.append()
            self.thrust_cmds.append(z_acc)
            self.ang_vel_cmds.append(ang_vel * 180 / (2 * np.pi))

            # Simulation timer update
            t = i * self.dt
            i += 1 

            if self.flag["land"] == 2:
                break
            
            if self.viz_sim:
                self.cf.vis.set_state(quadsim_state.pos, quadsim_state.rot)
                time.sleep(0.01)

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Process some integers.')
    parser.add_argument('--quadsim', action='store_true')
    parser.add_argument('-v', '--viz', type = bool, default=False)
    parser.add_argument('--config', action='store', type=str, default="experiments/hello_world.yaml")
    parser.add_argument('--logfile', action='store', type=str, default='log.npz')
    parser.add_argument('--debug', action='store', type=bool, default=False)
    parser.add_argument('-gui', type=bool, default=False)
    parser.add_argument('-seed', type=int, default=None, help='try not use this and use the yaml file to send the seeds')
    parser.add_argument('-ps','--pseudo', type=bool, default=False, help='pseudo adapt')



    run_args = EasyDict(vars(parser.parse_args()))

    x = ctrlCF(run_args, cfName="cf3")

    try:
        if run_args.quadsim:
            x.main_loop_sim()
        else:
            x.main_loop_cf()
    except KeyboardInterrupt:
        x.write_to_log()
    else:
        x.write_to_log()
    

