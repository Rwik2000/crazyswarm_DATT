[![CI](https://github.com/IMRCLab/libmotioncapture/actions/workflows/CI.yml/badge.svg)](https://github.com/IMRCLab/libmotioncapture/actions/workflows/CI.yml)

# libmotioncapture
Interface Abstraction for Motion Capture System APIs such as VICON, OptiTrack, Qualisys, or VRPN.

This can be used as C++ library or Python package. For Python, use

```
pip install motioncapture
```

For C++, follow the instructions below.

This is a fork of https://github.com/USC-ACTLab/libmotioncapture/ with the following changes:

- Python bindings
- Factory method
- Refactored API
- Support for VRPN by default

## Compile options
By default, `libmotioncapture` supports the following hardware:

- VICON - SDK git submodule
- Qualisys - SDK git submodule
- OptiTrack - binary parsing over network (no dependency)
- VRPN - SDK git submodule

CMake flags can be used to disable individual systems in `CMakeLists.txt`.

## Prerequisites

```
sudo apt install libboost-system-dev libboost-thread-dev libeigen3-dev ninja-build
```

## C++

```
git submodule init
git submodule update
mkdir build
cd build
cmake ..
```

An example application is in `examples/main.cpp`. Run it using

```
./motioncapture_example <mocap type> <ip address>
```

## Python (Development)

```
git submodule init
git submodule update
python3 setup.py develop --user
python3 examples/python.py
```