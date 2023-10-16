import numpy as np
from Controllers.ctrl_backbone import ControllerBackbone

from scipy.spatial.transform import Rotation as R
from quadsim.learning.train_policy import DroneTask, RLAlgo, SAVED_POLICY_DIR, import_config, CONFIG_DIR
from quadsim.visualizer import Vis
import torch
from torch.autograd.functional import jacobian
from stable_baselines3.common.env_util import make_vec_env

class BC_Controller(ControllerBackbone):
  def __init__(self, **kwargs):
    super().__init__(**kwargs)

    self.set_BC_policy()

  def _response(self, fl=1, **response_inputs):
    t = response_inputs.get('t')
    state = response_inputs.get('state')
    ref_func = response_inputs.get('ref_func')

    if self.prev_t is None:
      dt = 0
    else:
      dt = t - self.prev_t
    
    if fl:
      self.prev_t = t
    
    pos = state.pos - self.offset_pos
    vel = state.vel
    rot = state.rot

    quat = rot.as_quat() 

    obs_ = np.hstack((pos, vel, quat))


    if fl==0:
        obs_ = np.zeros((self.time_horizon+1) * 3 + 10)
    else:
        # ff_pos = np.array([ref_func(t + 3 * i * dt)[0].pos for i in range(self.time_horizon)])
        # ff_pos_stacked = ff_pos.reshape(-1, 3)
        # ff_vel = np.diff(ff_pos_stacked, axis=0) / (3 * dt)
        # # pad last timestep by repeating previous value
        # ff_vel = np.r_[ff_vel, ff_vel[-1, None]]
        # ff_terms_stacked = np.c_[ff_pos, ff_vel]
        # ff_terms = ff_terms_stacked.flatten()
        # obs_ = np.hstack([obs_, obs_[0:3] - ref_func(t)[0].pos, ff_terms])
        if self.body_frame and self.relative:
            ff_terms = [obs_[0:3] - rot.inv().apply(ref_func(t + 3 * i * dt)[0].pos) for i in range(self.time_horizon)]
            obs_ = np.hstack([obs_, obs_[0:3] - rot.inv().apply(ref_func(t)[0].pos)] + ff_terms)
        else:
            ff_terms = [ref_func(t + 3 * i * dt)[0].pos for i in range(self.time_horizon)]
            obs_ = np.hstack([obs_, obs_[0:3] - ref_func(t)[0].pos] + ff_terms)

    action, _states = self.bc_policy.predict(obs_, deterministic=True)

    action[0] += self.g
    self.prev_pos = pos.copy()
    return action[0], action[1:]
