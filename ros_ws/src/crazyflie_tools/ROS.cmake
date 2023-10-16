cmake_minimum_required(VERSION 2.8.3)
project(crazyflie_tools)

# Enable C++11 and warnings
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)
add_compile_options(-Wall -Wextra -Werror)

## System dependencies are found with CMake's conventions
find_package(Boost REQUIRED COMPONENTS program_options REQUIRED)
add_subdirectory(crazyflie_cpp)

###################################
## catkin specific configuration ##
###################################
## The catkin_package macro generates cmake config files for your package
## Declare things to be passed to dependent projects
## INCLUDE_DIRS: uncomment this if you package contains header files
## LIBRARIES: libraries you create in this project that dependent projects also need
## CATKIN_DEPENDS: catkin_packages dependent projects also need
## DEPENDS: system dependencies of this project that dependent projects also need
catkin_package(
#  INCLUDE_DIRS include
#  LIBRARIES crazyflie
#  CATKIN_DEPENDS
#    crazyflie_cpp
  DEPENDS 
    crazyflie_cpp
    ${Boost_LIBRARIES}
)

###########
## Build ##
###########

include_directories(
  crazyflie_cpp/include
  ${catkin_INCLUDE_DIRS}
)

## Declare a cpp executable
add_executable(scan
  src/scan.cpp
)

## Specify libraries to link a library or executable target against
target_link_libraries(scan
  crazyflie_cpp
  ${catkin_LIBRARIES}
  ${Boost_LIBRARIES}
)

### listParams
add_executable(listParams
  src/listParams.cpp
)
target_link_libraries(listParams
  crazyflie_cpp
  ${catkin_LIBRARIES}
  ${Boost_LIBRARIES}
)

### listLogVariables
add_executable(listLogVariables
  src/listLogVariables.cpp
)
target_link_libraries(listLogVariables
  crazyflie_cpp
  ${catkin_LIBRARIES}
  ${Boost_LIBRARIES}
)

### listMemories
add_executable(listMemories
  src/listMemories.cpp
)
target_link_libraries(listMemories
  crazyflie_cpp
  ${catkin_LIBRARIES}
  ${Boost_LIBRARIES}
)

### reboot
add_executable(reboot
  src/reboot.cpp
)
target_link_libraries(reboot
  crazyflie_cpp
  ${catkin_LIBRARIES}
  ${Boost_LIBRARIES}
)

### battery

add_executable(battery
  src/battery.cpp
)
target_link_libraries(battery
  crazyflie_cpp
  ${catkin_LIBRARIES}
  ${Boost_LIBRARIES}
)

### version

add_executable(version
  src/version.cpp
)
target_link_libraries(version
  crazyflie_cpp
  ${catkin_LIBRARIES}
  ${Boost_LIBRARIES}
)

### console

add_executable(console
  src/console.cpp
)
target_link_libraries(console
  crazyflie_cpp
  ${catkin_LIBRARIES}
  ${Boost_LIBRARIES}
)

### flash

add_executable(flash
  src/flash.cpp
)
target_link_libraries(flash
  crazyflie_cpp
  ${catkin_LIBRARIES}
  ${Boost_LIBRARIES}
)

### comCheck
add_executable(comCheck
  src/comCheck.cpp
)
target_link_libraries(comCheck
  crazyflie_cpp
  ${catkin_LIBRARIES}
  ${Boost_LIBRARIES}
)

### log
add_executable(log
  src/log.cpp
)
target_link_libraries(log
  crazyflie_cpp
  ${catkin_LIBRARIES}
  ${Boost_LIBRARIES}
)

# downloadUSDLogfile
add_executable(downloadUSDLogfile
  src/downloadUSDLogfile.cpp
)
target_link_libraries(downloadUSDLogfile
  crazyflie_cpp
  ${catkin_LIBRARIES}
  ${Boost_LIBRARIES}
)

# setParam
add_executable(setParam
  src/setParam.cpp
)
target_link_libraries(setParam
  crazyflie_cpp
  ${catkin_LIBRARIES}
  ${Boost_LIBRARIES}
)

#############
## Install ##
#############

# all install targets should use catkin DESTINATION variables
# See http://ros.org/doc/api/catkin/html/adv_user_guide/variables.html

## Mark executable scripts (Python etc.) for installation
## in contrast to setup.py, you can choose the destination
# install(PROGRAMS
#   scripts/my_python_script
#   DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
# )

## Mark executables and/or libraries for installation
# install(TARGETS crazyflie crazyflie_node
#   ARCHIVE DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}
#   LIBRARY DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}
#   RUNTIME DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
# )

## Mark cpp header files for installation
# install(DIRECTORY include/${PROJECT_NAME}/
#   DESTINATION ${CATKIN_PACKAGE_INCLUDE_DESTINATION}
#   FILES_MATCHING PATTERN "*.h"
#   PATTERN ".svn" EXCLUDE
# )

## Mark other files for installation (e.g. launch and bag files, etc.)
# install(FILES
#   # myfile1
#   # myfile2
#   DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION}
# )

#############
## Testing ##
#############

## Add gtest based cpp test target and link libraries
# catkin_add_gtest(${PROJECT_NAME}-test test/test_crazyflie.cpp)
# if(TARGET ${PROJECT_NAME}-test)
#   target_link_libraries(${PROJECT_NAME}-test ${PROJECT_NAME})
# endif()

## Add folders to be run by python nosetests
# catkin_add_nosetests(test)
