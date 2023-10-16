cmake_minimum_required(VERSION 3.5)
project(libobjecttracker)

set (CMAKE_CXX_STANDARD 11)
set (CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(PCL REQUIRED)
# find_package(Eigen3 REQUIRED)

###########
## Build ##
###########

## Additional include folders
include_directories(
  include
  ${PCL_INCLUDE_DIRS}
  /usr/include/eigen3/
  # ${EIGEN3_INCLUDE_DIR}
)

## Declare a cpp library
add_library(libobjecttracker
  src/object_tracker.cpp
)

## Specify libraries to link a library or executable target against
target_link_libraries(libobjecttracker
  ${PCL_LIBRARIES}
)
