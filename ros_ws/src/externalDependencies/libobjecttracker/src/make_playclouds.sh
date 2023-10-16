#!/bin/sh
if [ `uname` = 'Darwin' ]; then
CC="clang++"
else
CC="g++"
fi

CFLAGS="-g -Wall -std=c++11"

if [ `uname` = "Darwin" ]; then
LIBS="-I../include/ \
-I/usr/local/Cellar/pcl/1.7.2/include/pcl-1.7 \
-I/usr/local/Cellar/eigen/3.2.2/include/eigen3 \
-I/usr/local/Cellar/yaml-cpp/0.5.1/include \
-L/usr/local/Cellar/pcl/1.7.2/lib \
-L/usr/local/Cellar/flann/1.8.4/lib \
-L/usr/local/Cellar/pcl/1.7.2/lib \
-L/usr/local/Cellar/yaml-cpp/0.5.1/lib"
else
LIBS="-I../include/ \
-I/usr/include/pcl-1.7 \
-I/usr/include/eigen3 \
-I/usr/include/yaml-cpp"
fi

$CC $CFLAGS $LIBS playclouds.cpp object_tracker.cpp \
-lpcl_registration -lpcl_features -lpcl_filters -lpcl_sample_consensus \
-lpcl_search -lpcl_kdtree -lflann_cpp -lpcl_octree -lpcl_common \
-lyaml-cpp
