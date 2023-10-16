import time
import numpy as np
import matplotlib.pyplot as plt

import os
from argparse import ArgumentParser

from quadsim.learning.train_policy import DroneTask, RLAlgo, SAVED_POLICY_DIR, import_config, CONFIG_DIR, TrajectoryRef
from quadsim.visualizer import Vis
from quadsim.learning.BC_experts.expert_pid_controller import PIDController
from quadsim.learning.BC_experts.expert_pid_controller_trajectory import PIDController as PIDControllerTrajectory

from quadsim.models import IdentityModel
from quadsim.rigid_body import State

from python_utils.plotu import subplot
from scipy.spatial.transform import Rotation as R
from python_utils.plotu import set_3daxes_equal

from stable_baselines3.common.evaluation import evaluate_policy
from stable_baselines3.common.vec_env.base_vec_env import VecEnv


def parse_args():
    parser = ArgumentParser()
    parser.add_argument("--runtime", type=float, default=10)
    parser.add_argument("-ht", "--hovertime",type=float,default=0)
    parser.add_argument("--height",type=float,default=1.0)
    parser.add_argument('-lp', '--logpath', type=str)

    parser.add_argument(
        '-t', '--task', dest='task',
        type=DroneTask, default=DroneTask.HOVER
        )
    parser.add_argument('-n', '--name', dest='name',
        default=None)
    parser.add_argument('-a', '--algo', dest='algo',
        type=RLAlgo, default=RLAlgo.PPO)
    parser.add_argument('-s', '--steps', dest='eval_steps',
        type=int, default=1000)
    parser.add_argument('-c', '--config', dest='config',
        default='default_hover.py',
        help='Name of the configuration .py file. Default: default_hover.py'
    )
    parser.add_argument('-v', '--viz', dest='viz',
        type=bool, default=False,
        help='Whether to ')
    parser.add_argument('-r', '--rate', dest='rate',
        default=100, type=float,
        help='Rate (Hz) of visualization. Sleeps for 1 / rate between states. Set to negative for uncapped.'
    )
    parser.add_argument('--ref', dest='ref',
        default=TrajectoryRef.LINE_REF, type=TrajectoryRef,
        help='Rate (Hz) of visualization. Sleeps for 1 / rate between states. Set to negative for uncapped.'
    )
    parser.add_argument('--ymax', dest='ymax', type=float, default=0.0)
    parser.add_argument('--pid', dest='pid', default=False, type=bool, help='whether to use PID')
    parser.add_argument('--bc-policy', dest='bc_policy', default=None, type=str)
    parser.add_argument('--relative', dest='relative', type=bool, default=False)
    parser.add_argument('--seed', dest='seed', type=int, default=None)
    parser.add_argument('--frozen-hover', dest='frozen_hover', type=str, default=None)
    parser.add_argument('--body-frame', dest='body_frame', type=bool, default=False)
    parser.add_argument('--log-scale', dest='log_scale', type=bool, default=False)
    parser.add_argument('--u-struct', dest='u_struct', type=bool, default=False)
    args = parser.parse_args()

    return args

def read_real_data(args):
    LOG_PATH = os.path.dirname(os.path.abspath(__file__)) +'/' + args.logpath # "/../../../../../logs/CORL/may_31/real/"
    data = {}
    saved_data = dict(np.load(LOG_PATH))
    t_mask = (saved_data['ts'] > 5 + args.hovertime) * (saved_data['ts'] < args.runtime + 5 + args.hovertime)
    data['ts'] = saved_data['ts'][t_mask]
    data['ts'] -= data['ts'][0]
    data['pose_positions'] = saved_data['pose_positions'][t_mask] 
    data['pose_positions'][:, :2] -= data["pose_positions"][0, :2]
    data['pose_positions'][:, 2] -= args.height

    data['pose_orientations'] = saved_data['pose_orientations'][t_mask]
    # data['cf_positions'] = saved_data['cf_positions'][t_mask] - saved_data['cf_positions'][st]
    data['ref_positions'] = saved_data['ref_positions'][t_mask] 
    data['ref_positions'] -= data['ref_positions'][0]

    data['ref_orientation'] = saved_data['ref_orientation'][t_mask]
    data['thrust_cmds'] = saved_data['thrust_cmds'][t_mask]
    data['ang_vel_cmds'] = saved_data['ang_vel_cmds'][t_mask]
    
    return data

def sim_expert_rollout(policy, evalenv, obs, rollout_steps=100):
    obs_ = []
    ts = []
    refs = [evalenv.ref.pos(evalenv.t + i * evalenv.dt) for i in range(rollout_steps)]

    for i in range(rollout_steps):
        action, _states = policy.predict(obs, deterministic=True)
        obs, rewards, dones, info = evalenv.step(action, return_motor_info=True)
        rotobj = R.from_quat(obs[6:10])
        obs[0:3] = rotobj.as_matrix() @ obs[0:3]
        obs[3:6] = rotobj.as_matrix() @ obs[3:6]


        obs_.append(obs[:10])
        ts.append(evalenv.t)
    
    return np.array(obs_), np.array(ts), np.array(refs)

def eval():
    args = parse_args()

    real_run_data = read_real_data(args)

    task: DroneTask = args.task
    policy_name = args.name
    algo = args.algo
    eval_steps = args.eval_steps
    config_filename = args.config
    viz = args.viz
    pid = args.pid
    bc_policy_name = args.bc_policy
    ref = args.ref
    ymax = args.ymax
    seed = args.seed
    relative = args.relative
    frozen_hover = args.frozen_hover
    body_frame = args.body_frame
    log_scale = args.log_scale
    u_struct = args.u_struct

    if not os.path.exists(SAVED_POLICY_DIR / f'{policy_name}.zip'):
        raise ValueError(f'policy not found: {policy_name}')
    if not os.path.exists(CONFIG_DIR / config_filename):
        raise FileNotFoundError(f'{config_filename} is not a valid config file')

    algo_class = algo.algo_class()

    config = import_config(config_filename)

    if task.is_trajectory():
        if task == DroneTask.TRAJFBFF:
            if seed is None:
                seed = np.random.randint(0, 100000)
                fixed_seed = False
            else:
                fixed_seed = True
            print(seed)
            evalenv = task.env()(config=config, log_scale=log_scale, ref=ref, seed=seed, fixed_seed=fixed_seed, y_max=ymax, relative=relative, body_frame=body_frame, init_ref = 0, u_struct = u_struct)
        else:
            evalenv = task.env()(log_scale=log_scale, config=config, ref=ref)
    else:
        evalenv = task.env()(log_scale=log_scale, config=config)

    policy = algo_class.load(SAVED_POLICY_DIR / f'{policy_name}.zip')

    if frozen_hover is not None:
        if not (SAVED_POLICY_DIR / f'{frozen_hover}.zip').exists():
            print(f'hover policy {frozen_hover} does not exist')
            return
        
        hover_env = DroneTask.HOVER.env()(config=config)
        frozen_hover_policy = algo_class.load(SAVED_POLICY_DIR / f'{frozen_hover}.zip', hover_env).policy
        policy.policy.features_extractor.hover_policy = frozen_hover_policy

    try:
        print('scaling', policy.policy.action_net.scale, policy.policy.action_net.bias)
    except AttributeError:
        pass

    control_error_avg = 0
    control_errors = []
    count = 0
    vis = Vis()
    ct = 0
    try:
        # while True:
        total_r = 0
        obs = evalenv.reset()

        for i in range(eval_steps):

            new_state = State()
            new_state.pos = real_run_data['pose_positions'][i]
            new_state.rot = R.from_euler('zyx', real_run_data["pose_orientations"][i], degrees=True)
            
            evalenv.quadsim.setstate(new_state)
            evalenv.t = real_run_data['ts'][i]
            
            state = evalenv.getstate()
            obs = evalenv.obs(state)

            sim_expert_obs, sim_ts, sim_refs = sim_expert_rollout(policy, evalenv, obs)
            plt.figure()
            plt.plot(sim_ts, sim_expert_obs[:, 0])
            plt.plot(real_run_data['ts'], real_run_data['pose_positions'][:, 0])
            plt.plot(real_run_data['ts'], real_run_data['ref_positions'][:, 0])
            plt.plot(sim_ts, sim_refs[:, 0])
            plt.show()
            # import pdb;pdb.set_trace()

            # # import pdb;pdb.set_trace()

            # all_actions.append(action)
            # all_rewards.append(rewards)
            # all_states.append(np.r_[state.pos, state.vel, obs[6:10]])
            # if not isinstance(evalenv, VecEnv):
            #     all_ang_vel_actual.append(info['motor'][3])
            #     all_ang_vel_desired.append(info['motor'][1])

            # try:
            #     des_traj.append(evalenv.ref.pos(evalenv.t))
            # except:
            #     pass

            # total_r += rewards

            # control_error = np.linalg.norm(state.pos)
            # if eval_steps > 500:
            #     control_errors.append(control_error)

            # vis.set_state(state.pos.copy(), state.rot)
            # if args.rate > 0:
            #     time.sleep(1.0 / args.rate)

        # all_states = np.array(all_states)
        # all_actions = np.array(all_actions)
        # all_rewards = np.array(all_rewards)
        # all_bc_actions = np.array(all_bc_actions)
        # all_ang_vel_desired = np.array(all_ang_vel_desired)
        # all_ang_vel_actual =  np.array(all_ang_vel_actual)
        # des_traj = np.array(des_traj)
        
        # if viz:
        #     plt.figure()
        #     ax = plt.subplot(3, 1, 1)
        #     plt.plot(range(eval_steps), all_states[:, 0])
        #     if des_traj.size > 0:
        #         plt.plot(range(eval_steps), des_traj[:, 0])
        #     plt.subplot(3, 1, 2)
        #     plt.plot(range(eval_steps), all_states[:, 1])
        #     if des_traj.size > 0:
        #         plt.plot(range(eval_steps), des_traj[:, 1])
        #     plt.subplot(3, 1, 3)
        #     plt.plot(range(eval_steps), all_states[:, 2])
        #     if des_traj.size > 0:
        #         plt.plot(range(eval_steps), des_traj[:, 2])
        #     plt.suptitle('PPO (sim) des vs. actual pos mass : {}'.format(evalenv.model.mass))
        #     # plt.suptitle('Positions')

        #     eulers = np.array([R.from_quat(rot).as_euler('ZYX')[::-1] for rot in all_states[:, 6:10]])

        #     plt.savefig("rwik_{}_pos.png".format(str(count).zfill(3)))
        #     plt.show()
        # print(total_r)
        # control_error_avg += np.mean(control_errors)
        # print('control error', np.mean(control_errors))
        # count += 1

    except KeyboardInterrupt:
        print('Control Error: ', control_error_avg / count)

if __name__ == "__main__":
    eval()
