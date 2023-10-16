import numpy as np
from Controllers.ctrl_backbone import ControllerBackbone
from pathlib import Path
from scipy.spatial.transform import Rotation as R
from quadsim.learning.train_policy import DroneTask, RLAlgo, SAVED_POLICY_DIR, import_config, CONFIG_DIR
from quadsim.visualizer import Vis
import torch
from torch.autograd.functional import jacobian
from stable_baselines3.common.env_util import make_vec_env
from quadsim.learning.utils.adaptation_network import AdaptationNetwork

from quadsim.control import Controller

class PPOController(ControllerBackbone):
  def __init__(self, **kwargs):
    super().__init__(**kwargs)

    self.set_policy()

    # self.adaptive = adaptive
    # if adaptive:
    #   self.init_adaptive_network()

  # def init_adaptive_network(self,):
  #   self.e_dims = 1
  #   self.history = None
  #   self.time_horizon = 50
  #   self.e_pred = np.zeros(self.e_dims)[None, :]

  #   adaptation_network_policy_name = "hover_latency_adaptive_adapt"
  #   self.adaptation_network = AdaptationNetwork(input_dims=14, e_dims=self.e_dims)
  #   adaptation_network_state_dict = torch.load(Path().absolute() / 'saved_policies'/ adaptation_network_policy_name)
  #   self.adaptation_network.load_state_dict(adaptation_network_state_dict)

  def response(self, fl=1, **response_inputs):

    t = response_inputs.get('t')
    state = response_inputs.get('state')
    ref = response_inputs.get('ref')
    ref_func = response_inputs.get('ref_func')

    self.updateDt(t)

    if fl:
      self.prev_t = t

    # the drone always tries to orient to (0,0,0)
    pos = state.pos - ref.pos
    vel = state.vel
    rot = state.rot
    quat = rot.as_quat() 


    if self.adaptive:
      obs = np.r_[obs, self.e_pred[0]]

    if self.body_frame:
      pos = rot.inv().apply(pos)
      vel = rot.inv().apply(vel)

    obs = np.hstack((pos,vel,quat))
    action, _states = self.policy.predict(obs, deterministic=True)

    # if self.adaptive:

    #   if self.history is None:
    #     self.history = np.r_[obs[:-self.e_dims], action][None, :].T
    #   else:
    #     self.history = np.c_[self.history, np.r_[obs[:-self.e_dims], action][None, :].T]
      
    #   if self.history.shape[1] >= self.time_horizon:
    #     self.e_pred = self.adaptation_network(torch.from_numpy(self.history[None, ..., -self.time_horizon :]).type(torch.FloatTensor)).detach().numpy()
    #     print(self.e_pred)
    ################################
    # # Gradient (gain) calculation for hovering
    # th_obs,_ = self.policy.policy.obs_to_tensor(obs)
    # j = jacobian(self.policy.policy._predict,(th_obs))
    # j = j[0,:,0,:].detach().cpu().numpy()
    # print(j)
    # exit()
    ################################
    # 

    # Gain Values for hovering
    # [[  3.67305589   1.38716006  -9.53558922   4.38564968   1.68557179 -10.64670753  -7.13586092  15.51110363 -12.54623222   0.24622881]
    #  [  0.90983611  10.75347614   4.6693573   -0.83937329  10.08096027   2.01146364 -28.32143784  -2.30262518  -6.37237597  -0.67694801]
    #  [ -9.83611393  -4.55986023   3.62569857 -13.52033424  -1.33899236   2.54128242   5.33164978 -43.40154266   1.18937016   0.59184641]
    #  [ -0.34359568  -0.66659546   1.27601814   0.58130348  -1.72741628   1.22041595   4.60577106   1.54117    -16.57507133   0.13079186]]
    # 
    action[0] += self.g
    self.prev_pos = pos.copy()
    return action[0], action[1:]