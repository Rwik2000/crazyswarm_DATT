# Install script for directory: /home/rwik/proj/Drones/crazyswarm/ros_ws/src/crazyswarm

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/home/rwik/proj/Drones/crazyswarm/ros_ws/install")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "RelWithDebInfo")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Install shared libraries without execute permission?
if(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  set(CMAKE_INSTALL_SO_NO_EXE "1")
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "FALSE")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/crazyswarm/srv" TYPE FILE FILES
    "/home/rwik/proj/Drones/crazyswarm/ros_ws/src/crazyswarm/srv/GoTo.srv"
    "/home/rwik/proj/Drones/crazyswarm/ros_ws/src/crazyswarm/srv/Land.srv"
    "/home/rwik/proj/Drones/crazyswarm/ros_ws/src/crazyswarm/srv/NotifySetpointsStop.srv"
    "/home/rwik/proj/Drones/crazyswarm/ros_ws/src/crazyswarm/srv/SetGroupMask.srv"
    "/home/rwik/proj/Drones/crazyswarm/ros_ws/src/crazyswarm/srv/StartTrajectory.srv"
    "/home/rwik/proj/Drones/crazyswarm/ros_ws/src/crazyswarm/srv/Stop.srv"
    "/home/rwik/proj/Drones/crazyswarm/ros_ws/src/crazyswarm/srv/Takeoff.srv"
    "/home/rwik/proj/Drones/crazyswarm/ros_ws/src/crazyswarm/srv/UpdateParams.srv"
    "/home/rwik/proj/Drones/crazyswarm/ros_ws/src/crazyswarm/srv/UploadTrajectory.srv"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/crazyswarm/msg" TYPE FILE FILES
    "/home/rwik/proj/Drones/crazyswarm/ros_ws/src/crazyswarm/msg/LogBlock.msg"
    "/home/rwik/proj/Drones/crazyswarm/ros_ws/src/crazyswarm/msg/GenericLogData.msg"
    "/home/rwik/proj/Drones/crazyswarm/ros_ws/src/crazyswarm/msg/FullState.msg"
    "/home/rwik/proj/Drones/crazyswarm/ros_ws/src/crazyswarm/msg/VelocityWorld.msg"
    "/home/rwik/proj/Drones/crazyswarm/ros_ws/src/crazyswarm/msg/TrajectoryPolynomialPiece.msg"
    "/home/rwik/proj/Drones/crazyswarm/ros_ws/src/crazyswarm/msg/Hover.msg"
    "/home/rwik/proj/Drones/crazyswarm/ros_ws/src/crazyswarm/msg/Position.msg"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/crazyswarm/cmake" TYPE FILE FILES "/home/rwik/proj/Drones/crazyswarm/ros_ws/build/crazyswarm/catkin_generated/installspace/crazyswarm-msg-paths.cmake")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include" TYPE DIRECTORY FILES "/home/rwik/proj/Drones/crazyswarm/ros_ws/devel/include/crazyswarm")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/roseus/ros" TYPE DIRECTORY FILES "/home/rwik/proj/Drones/crazyswarm/ros_ws/devel/share/roseus/ros/crazyswarm")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/common-lisp/ros" TYPE DIRECTORY FILES "/home/rwik/proj/Drones/crazyswarm/ros_ws/devel/share/common-lisp/ros/crazyswarm")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/gennodejs/ros" TYPE DIRECTORY FILES "/home/rwik/proj/Drones/crazyswarm/ros_ws/devel/share/gennodejs/ros/crazyswarm")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  execute_process(COMMAND "/usr/bin/python3" -m compileall "/home/rwik/proj/Drones/crazyswarm/ros_ws/devel/lib/python3/dist-packages/crazyswarm")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/python3/dist-packages" TYPE DIRECTORY FILES "/home/rwik/proj/Drones/crazyswarm/ros_ws/devel/lib/python3/dist-packages/crazyswarm")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/pkgconfig" TYPE FILE FILES "/home/rwik/proj/Drones/crazyswarm/ros_ws/build/crazyswarm/catkin_generated/installspace/crazyswarm.pc")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/crazyswarm/cmake" TYPE FILE FILES "/home/rwik/proj/Drones/crazyswarm/ros_ws/build/crazyswarm/catkin_generated/installspace/crazyswarm-msg-extras.cmake")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/crazyswarm/cmake" TYPE FILE FILES
    "/home/rwik/proj/Drones/crazyswarm/ros_ws/build/crazyswarm/catkin_generated/installspace/crazyswarmConfig.cmake"
    "/home/rwik/proj/Drones/crazyswarm/ros_ws/build/crazyswarm/catkin_generated/installspace/crazyswarmConfig-version.cmake"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/crazyswarm" TYPE FILE FILES "/home/rwik/proj/Drones/crazyswarm/ros_ws/src/crazyswarm/package.xml")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for each subdirectory.

endif()

