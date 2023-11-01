# Hardware Implementation of DATT : Deep Adaptive Trajectory Tracking for Quadrotor control

## Code Base under progress

## Training code : [https://github.com/KevinHuang8/DATT](https://github.com/KevinHuang8/DATT)

## Installation

Follow the steps given in [https://crazyswarm.readthedocs.io/en/latest/installation.html](https://crazyswarm.readthedocs.io/en/latest/installation.html)

In step 6, replace the github repository they provided with the current repository i.e. 

```bash
# STEP 6 : 
git clone https://github.com/Rwik2000/crazyswarm_DATT

```

## Drone Learning

- DATT -> [https://github.com/Rwik2000/crazyswarm_DATT/tree/main/ros_ws/src/crazyswarm/scripts/run_DATT](https://github.com/Rwik2000/crazyswarm_DATT/tree/main/ros_ws/src/crazyswarm/scripts/run_DATT)

#### Connecting with Quadsim
Add quadsim to PYTHONPATH to run Learning based controllers and add MPPI folder within quadsim to the PYTHONPATH run MPPI  baseline.

```bash
export PYTHONPATH="<path to quadsim>:<path to quadsim>/learning/BC_experts/MPPI:$PYTHONPATH"
```
##### Symlinks
```bash
cd <path to `run_DATT`>
ln -s <path to quadsim>/learning/saved_policies
ln -s <path to quadsim>/learning/test_policies
ln -s <path to quadsim>/learning/configuration
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
