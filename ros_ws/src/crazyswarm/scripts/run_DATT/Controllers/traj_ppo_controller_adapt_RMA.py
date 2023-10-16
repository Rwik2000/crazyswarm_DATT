import numpy as np
from Controllers.ctrl_backbone import ControllerBackbone

from scipy.spatial.transform import Rotation as R
from quadsim.learning.train_policy import DroneTask, RLAlgo, SAVED_POLICY_DIR, import_config, CONFIG_DIR
from quadsim.visualizer import Vis
import torch
from torch.autograd.functional import jacobian
from stable_baselines3.common.env_util import make_vec_env

class PPOController_trajectory_adaptive_RMA(ControllerBackbone):
  def __init__(self, **kwargs):
    super().__init__(**kwargs)
    # self.e_dims = e_dims
    self.set_policy()

    self.history = torch.zeros((1, 14, 50)).to("cuda:0")

    self.adaptation_history = np.zeros((1, 4))
    self.adaptation_history_len = 100

  def _response(self, fl=1, **response_inputs):
    
    t = response_inputs.get('t')
    state = response_inputs.get('state')
    ref = response_inputs.get('ref')
    ref_func = response_inputs.get('ref_func')
    ref_func_obj = response_inputs.get('ref_func_obj')
                                       
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


    if self.body_frame:
      pos = rot.inv().apply(pos)
      vel = rot.inv().apply(vel)

    obs = np.hstack((pos, vel, quat))
    
    if self.pseudo_adapt==False and fl!=0.0:

      adaptation_term = self.adaptive_policy(self.history).detach().cpu().numpy()[0]

      self.adaptation_terms[1:] = adaptation_term
      obs_ = np.hstack((obs, adaptation_term))

    else:
      pseudo_adapt_term =  np.ones(self.e_dims) * 0.0
      obs_ = np.hstack((obs, pseudo_adapt_term))

    if fl==0:
        obs_ = np.zeros((self.time_horizon+1) * 3 + 10 + self.e_dims)
    else:

        if self.relative:
          obs_ = np.hstack([obs_, obs_[0:3] - rot.inv().apply(ref_func(t)[0].pos)] + [obs_[0:3] - rot.inv().apply(ref_func(t + 3 * i * dt)[0].pos) for i in range(self.time_horizon)])

        else:
          ff_terms = [ref_func(t + 3 * i * dt)[0].pos for i in range(self.time_horizon)]
          obs_ = np.hstack([obs_, obs_[0:3] - ref_func(t)[0].pos] + ff_terms)

    # import pdb;pdb.set_trace()

    action, _states = self.policy.predict(obs_, deterministic=True)

    adaptation_input = np.concatenate((obs, action), axis=0)
    adaptation_input = torch.from_numpy(adaptation_input).to("cuda:0").float()

    if fl!=0.0:
      self.history = torch.cat((adaptation_input[None, :, None], self.history[:, :, :-1].clone()), dim=2)
      # import pdb;pdb.set_trace()

    action[0] += self.g

    return action[0], action[1:]
