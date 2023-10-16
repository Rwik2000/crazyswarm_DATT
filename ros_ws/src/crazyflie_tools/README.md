[![Build Status](https://travis-ci.org/whoenig/crazyflie_tools.svg?branch=master)](https://travis-ci.org/whoenig/crazyflie_tools)

# Crazyflie_tools

Standalone tools to use with the Crazyflie quadrotor.
This is also used as submodule in crazyflie_ros.

## Prerequisites

### Ubuntu 16.04, 18.04

```
sudo apt install libboost-program-options-dev libusb-1.0-0-dev
```

## Build

```
git submodule init
git submodule update
mkdir build
cd build
cmake ..
make
```
