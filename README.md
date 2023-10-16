## Drone Learning

- DATT -> [https://github.com/Rwik2000/crazyswarm/tree/exp/ros_ws/src/crazyswarm/scripts/run_DATT](https://github.com/Rwik2000/crazyswarm/tree/exp/ros_ws/src/crazyswarm/scripts/run_DATT)

#### Connecting with Quadsim
##### DATT
```bash
cd <path to `run_DATT`>
ln -s <path to quadsim>/learning/saved_policies
ln -s <path to quadsim>/learning/test_policies
ln -s <path to quadsim>/learning/configuration
```

##### DMPO
```bash
cd <path to `run_DMPO`>
ln -s <path to quadsim>/learning/BC_experts/MPPI/lmpc_configs
ln -s <path to quadsim>/learning/BC_experts/MPPI/lmpc_models
ln -s <path to quadsim>/learning/BC_experts/MPPI/lmpc_samples
```

#### Sample run code
##### DATT
```bash
cd <path to `run_DATT`>

# Sim
python3 uw_cf.py --config experiments/DATT/<fname>.yaml --quadsim -v true 

# Real
python3 uw_cf.py --config experiments/DATT/<fname>.yaml
```