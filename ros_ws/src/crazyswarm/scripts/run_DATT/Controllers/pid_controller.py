import numpy as np
from Controllers.ctrl_backbone import ControllerBackbone
from scipy.spatial.transform import Rotation as R
from cf_utils.rigid_body import State_struct
import torch
import time

class PIDController(ControllerBackbone):
  def __init__(self, **kwargs):
    super().__init__(**kwargs)

    self.kp_pos = 6.0
    self.kd_pos = 4.0
    self.ki_pos = 1.2 # 0 for sim
    self.kp_rot =   150.0/16
    self.yaw_gain = 220.0/16
    self.kp_ang =   16

    self.pos_err_int = np.zeros(3)
    self.count = 0
    self.lamb = 0.2
    self.v_prev = np.zeros(3)

    self.history = np.zeros((1, 14, 50))
    

    # self.mppi_controller = self.set_MPPI_cnotroller()
    # self.runL1 = False

  def _response(self, fl=1, **response_inputs ):
    
    t = response_inputs.get('t')
    state = response_inputs.get('state')
    ref = response_inputs.get('ref')


    self.updateDt(t)
    # if fl:
    if self.prev_t != None:
      dt = t - self.prev_t
    else:
      dt = 0.02
    #   self.prev_t = t

    # PID
    pos = state.pos
    vel = state.vel
    rot = state.rot
    p_err = pos - ref.pos
    v_err = vel - ref.vel
    quat = rot.as_quat() 

    v_t = state.vel
    if self.count > 2:
      v_t = state.vel
      a_t = (v_t - self.v_prev) / dt
    else:
      a_t = np.array([0, 0, 0])

    unity_mass = 1
    f_t = rot.apply(np.array([0, 0, self.history[0, 10, 0]])) * unity_mass

    if not self.pseudo_adapt:
      if self.runL1:
          # L1 adaptation update
        self.L1_adaptation(self.dt, v_t, f_t)
      else:
        self.naive_adaptation(a_t, f_t)

    obs = np.hstack((pos, vel, quat))
    # Updating error for integral term.
    self.pos_err_int += p_err * self.dt

    acc_des = (np.array([0, 0, self.g]) 
              - self.kp_pos * (p_err) 
              - self.kd_pos * (v_err) 
              - self.ki_pos * self.pos_err_int 
              + 0.5 * ref.acc
              + 1 * self.wind_adapt_term)
    

    u_des = rot.as_matrix().T.dot(acc_des)

    acc_des = np.linalg.norm(u_des)

    rot_err = np.cross(u_des / acc_des, np.array([0, 0, 1]))

    eulers = rot.as_euler("ZYX")
    yaw = eulers[0]
    omega_des = - self.kp_rot * rot_err
    omega_des[2] += - self.yaw_gain * (yaw - 0.0)
      

    self.adaptation_terms[1:] = self.wind_adapt_term

    adaptation_input = np.r_[obs, acc_des, omega_des]
    if fl!=0.0:
      self.history = np.concatenate((adaptation_input[None, :, None], self.history[:, :, :-1]), axis=2)

    self.count += 1
    self.v_prev = state.vel
    return acc_des, omega_des