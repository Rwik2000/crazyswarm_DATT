import numpy as np
from Controllers.ctrl_backbone import ControllerBackbone

from scipy.spatial.transform import Rotation as R
from quadsim.learning.train_policy import DroneTask, RLAlgo, SAVED_POLICY_DIR, import_config, CONFIG_DIR
from quadsim.visualizer import Vis
import torch
from torch.autograd.functional import jacobian
from stable_baselines3.common.env_util import make_vec_env
import time

class PPOController_trajectory_adaptive_L1(ControllerBackbone):
  def __init__(self, **kwargs):
    super().__init__(**kwargs)

    self.set_policy()

    self.history = np.zeros((1, 14, 5))
    
  def _response(self, fl = 1, **response_inputs):

    t = response_inputs.get('t')
    state = response_inputs.get('state')
    ref_func = response_inputs.get('ref_func')

    if self.prev_t is None:
      dt = 0.02
    else:
      dt = t - self.prev_t
    
    if fl:
      self.prev_t = t
    
    # States
    pos = state.pos - self.offset_pos
    vel = state.vel
    rot = state.rot

    # Acceleration Estimation
    v_t = state.vel
    if self.count > 2:
      v_t = state.vel
      a_t = (v_t - self.v_prev) / dt
    else:
      a_t = np.array([0, 0, 0]) 

    # Previous thrust action. f_t is in m / s**2
    unity_mass = 1
    f_t = rot.apply(np.array([0, 0, self.history[0, 10, 0]])) * unity_mass

    quat = rot.as_quat() 

    obs_bf = np.hstack((pos, vel, quat))

    if self.body_frame:
      pos = rot.inv().apply(pos)
      vel = rot.inv().apply(vel)

    obs = np.hstack((pos, vel, quat))
    
    if self.pseudo_adapt== False and fl!=0.0:
      if self.count > 2:
        v_t = state.vel
        a_t = (v_t - self.v_prev) / dt
      else:
        a_t = np.array([0, 0, 0])        
      
      if self.runL1:
        # L1 adaptation update
        self.L1_adaptation(dt, v_t, f_t)
      else:
        self.naive_adaptation(a_t, f_t)
      
      self.adaptation_terms[1: ] = self.wind_adapt_term
      obs_ = np.hstack((obs, self.wind_adapt_term))
    else:
      pseudo_adapt_term =  np.zeros(self.e_dims)
      self.adaptation_terms[1: ] = pseudo_adapt_term
      obs_ = np.hstack((obs, pseudo_adapt_term))

    if fl==0:
        obs_ = np.zeros((self.time_horizon+1) * 3 + 10 + self.e_dims)
    else:

        if self.relative:
          obs_ = np.hstack([obs_, obs_[0:3] - rot.inv().apply(ref_func(t)[0].pos)] + [obs_[0:3] - rot.inv().apply(ref_func(t + 3 * i * dt)[0].pos) for i in range(self.time_horizon)])

        else:
          ff_terms = [ref_func(t + 3 * i * dt)[0].pos for i in range(self.time_horizon)]
          obs_ = np.hstack([obs_, obs_[0:3] - ref_func(t)[0].pos] + ff_terms)

    action, _ = self.policy.predict(obs_, deterministic=True)

    action[0] += self.g
    
    adaptation_input = np.concatenate((obs_bf, action), axis=0)
    if fl!=0.0:
      self.history = np.concatenate((adaptation_input[None, :, None], self.history[:, :, :-1]), axis=2)

    self.count += 1
    self.v_prev = state.vel

    return action[0], action[1:]
