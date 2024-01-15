# Hardware Implementation of DATT : Deep Adaptive Trajectory Tracking for Quadrotor control

## Training code : [https://github.com/KevinHuang8/DATT](https://github.com/KevinHuang8/DATT)

## Installation

Follow the steps given in [https://crazyswarm.readthedocs.io/en/latest/installation.html](https://crazyswarm.readthedocs.io/en/latest/installation.html)

In step 6, replace the github repository they provided with the current repository i.e. 

```bash
# STEP 6 : 
git clone https://github.com/Rwik2000/crazyswarm_DATT

```

## Crazyflie ID
In `uw_cf.py` on Line 656, make sure you enter the cfname as "cf[id]". The [id] is the id you set for the crazyflie in the config file that is used in the launch file i.e. [custom_crazyflies.yaml](https://github.com/Rwik2000/crazyswarm_DATT/tree/main/ros_ws/src/crazyswarm/launch/custom_crazyflies.yaml)

## Drone Learning

- DATT -> [https://github.com/Rwik2000/crazyswarm_DATT/tree/main/ros_ws/src/crazyswarm/scripts/run_DATT](https://github.com/Rwik2000/crazyswarm_DATT/tree/main/ros_ws/src/crazyswarm/scripts/run_DATT)

#### Connecting with DATT repo
Add the parent folder of [DATT](https://github.com/KevinHuang8/DATT) repo to PYTHONPATH

```bash
export PYTHONPATH="<parent path of DATT>"
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



Things to do
- [ ] Support for RMA
- [ ] Support for L1 adaptive control
- [ ] Code cleanup
