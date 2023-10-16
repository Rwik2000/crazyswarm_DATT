clang++ -g -Wall -std=c++11 \
-I/usr/local/Cellar/pcl/1.7.2/include/pcl-1.7 -I/usr/local/Cellar/eigen/3.2.2/include/eigen3 -I../include/ \
-L/usr/local/Cellar/pcl/1.7.2/lib -L/usr/local/Cellar/flann/1.8.4/lib -L/usr/local/Cellar/pcl/1.7.2/lib \
-DSTANDALONE \
object_tracker.cpp \
-lpcl_registration -lpcl_features -lpcl_filters -lpcl_sample_consensus \
-lpcl_search -lpcl_kdtree -lflann_cpp -lpcl_octree -lpcl_common 
