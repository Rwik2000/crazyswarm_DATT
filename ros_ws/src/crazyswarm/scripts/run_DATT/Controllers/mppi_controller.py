import numpy as np
from Controllers.ctrl_backbone import ControllerBackbone

from scipy.spatial.transform import Rotation as R
from quadsim.learning.train_policy import DroneTask, RLAlgo, SAVED_POLICY_DIR, import_config, CONFIG_DIR
from quadsim.visualizer import Vis
import torch
from torch.autograd.functional import jacobian
from stable_baselines3.common.env_util import make_vec_env
import time

class MPPIController(ControllerBackbone):
  def __init__(self, **kwargs):
    super().__init__(**kwargs)

    self.mppi_controller = self.set_MPPI_controller()
    self.f_t = np.zeros(3)
    self.runL1 = True

  def ref_func_t(self, t):
    # import pdb;pdb.set_trace()
    ref_pos = self.ref_func_obj.pos(t).T
    ref_vel = self.ref_func_obj.vel(t).T
    ref_quat = self.ref_func_obj.quat(t).T
    ref_angvel = self.ref_func_obj.angvel(t).T

    ref = np.hstack((ref_pos, ref_vel, ref_quat, ref_angvel))

    return ref
  
  def _response(self, fl=1, **response_inputs):
    t = response_inputs.get('t')
    state = response_inputs.get('state')
    ref_func_obj = response_inputs.get('ref_func_obj')

    self.updateDt(t)
    if fl:
      self.prev_t = t
    pos = state.pos - self.offset_pos
    vel = state.vel
    rot = state.rot
    ang = state.ang

    self.ref_func_obj = ref_func_obj

    quat = rot.as_quat()
    # (x,y,z,w) -> (w,x,y,z)
    quat = np.roll(quat, 1)

    obs = np.hstack((pos, vel, quat))
    noise = np.random.normal(scale=self.param_MPPI.noise_measurement_std)
    noisystate = obs + noise
    noisystate[6:10] /= np.linalg.norm(noisystate[6:10])

    state_torch = torch.as_tensor(noisystate, dtype=torch.float32)
    L1_adapt = torch.zeros(3)
    if self.runL1 and not self.pseudo_adapt and fl!=0:
      self.L1_adaptation(self.dt, state.vel, self.f_t)
      self.adaptation_terms[1:] = self.wind_adapt_term
      L1_adapt = torch.as_tensor(self.wind_adapt_term, dtype=torch.float32)
      print(self.wind_adapt_term)
    # action = self.mppi_controller.policy_cf(state=state_torch, time=t).cpu().numpy()
    # start = time.time()

    if self.pseudo_adapt:
      action = self.mppi_controller.policy_with_ref_func(state=state_torch, time=t, new_ref_func=self.ref_func_t).cpu().numpy()
    else:
      action = self.mppi_controller.policy_with_ref_func(state=state_torch, time=t, new_ref_func=self.ref_func_t, L1_adapt=L1_adapt).cpu().numpy()
    # print(time.time() - start)
    # MPPI controller designed for output in world frame
    # World Frame -> Body Frame
    
    # st = time.time()
    action[1:] = (rot.as_matrix().T).dot(action[1:])

    self.f_t = rot.apply(np.array([0, 0, action[0]]))
    # print(time.time() - st)
    # print("-------")
    return action[0], action[1:]
