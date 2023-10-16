# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.16

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/rwik/proj/Drones/crazyswarm/ros_ws/src

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/rwik/proj/Drones/crazyswarm/ros_ws/build

# Include any dependencies generated for this target.
include crazyflie_tools/CMakeFiles/log.dir/depend.make

# Include the progress variables for this target.
include crazyflie_tools/CMakeFiles/log.dir/progress.make

# Include the compile flags for this target's objects.
include crazyflie_tools/CMakeFiles/log.dir/flags.make

crazyflie_tools/CMakeFiles/log.dir/src/log.cpp.o: crazyflie_tools/CMakeFiles/log.dir/flags.make
crazyflie_tools/CMakeFiles/log.dir/src/log.cpp.o: /home/rwik/proj/Drones/crazyswarm/ros_ws/src/crazyflie_tools/src/log.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/rwik/proj/Drones/crazyswarm/ros_ws/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object crazyflie_tools/CMakeFiles/log.dir/src/log.cpp.o"
	cd /home/rwik/proj/Drones/crazyswarm/ros_ws/build/crazyflie_tools && /usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/log.dir/src/log.cpp.o -c /home/rwik/proj/Drones/crazyswarm/ros_ws/src/crazyflie_tools/src/log.cpp

crazyflie_tools/CMakeFiles/log.dir/src/log.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/log.dir/src/log.cpp.i"
	cd /home/rwik/proj/Drones/crazyswarm/ros_ws/build/crazyflie_tools && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/rwik/proj/Drones/crazyswarm/ros_ws/src/crazyflie_tools/src/log.cpp > CMakeFiles/log.dir/src/log.cpp.i

crazyflie_tools/CMakeFiles/log.dir/src/log.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/log.dir/src/log.cpp.s"
	cd /home/rwik/proj/Drones/crazyswarm/ros_ws/build/crazyflie_tools && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/rwik/proj/Drones/crazyswarm/ros_ws/src/crazyflie_tools/src/log.cpp -o CMakeFiles/log.dir/src/log.cpp.s

# Object files for target log
log_OBJECTS = \
"CMakeFiles/log.dir/src/log.cpp.o"

# External object files for target log
log_EXTERNAL_OBJECTS =

/home/rwik/proj/Drones/crazyswarm/ros_ws/devel/lib/crazyflie_tools/log: crazyflie_tools/CMakeFiles/log.dir/src/log.cpp.o
/home/rwik/proj/Drones/crazyswarm/ros_ws/devel/lib/crazyflie_tools/log: crazyflie_tools/CMakeFiles/log.dir/build.make
/home/rwik/proj/Drones/crazyswarm/ros_ws/devel/lib/crazyflie_tools/log: /home/rwik/proj/Drones/crazyswarm/ros_ws/devel/lib/libcrazyflie_cpp.so
/home/rwik/proj/Drones/crazyswarm/ros_ws/devel/lib/crazyflie_tools/log: /usr/lib/x86_64-linux-gnu/libboost_program_options.so.1.71.0
/home/rwik/proj/Drones/crazyswarm/ros_ws/devel/lib/crazyflie_tools/log: /usr/lib/x86_64-linux-gnu/libusb-1.0.so
/home/rwik/proj/Drones/crazyswarm/ros_ws/devel/lib/crazyflie_tools/log: crazyflie_tools/CMakeFiles/log.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/rwik/proj/Drones/crazyswarm/ros_ws/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable /home/rwik/proj/Drones/crazyswarm/ros_ws/devel/lib/crazyflie_tools/log"
	cd /home/rwik/proj/Drones/crazyswarm/ros_ws/build/crazyflie_tools && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/log.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
crazyflie_tools/CMakeFiles/log.dir/build: /home/rwik/proj/Drones/crazyswarm/ros_ws/devel/lib/crazyflie_tools/log

.PHONY : crazyflie_tools/CMakeFiles/log.dir/build

crazyflie_tools/CMakeFiles/log.dir/clean:
	cd /home/rwik/proj/Drones/crazyswarm/ros_ws/build/crazyflie_tools && $(CMAKE_COMMAND) -P CMakeFiles/log.dir/cmake_clean.cmake
.PHONY : crazyflie_tools/CMakeFiles/log.dir/clean

crazyflie_tools/CMakeFiles/log.dir/depend:
	cd /home/rwik/proj/Drones/crazyswarm/ros_ws/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/rwik/proj/Drones/crazyswarm/ros_ws/src /home/rwik/proj/Drones/crazyswarm/ros_ws/src/crazyflie_tools /home/rwik/proj/Drones/crazyswarm/ros_ws/build /home/rwik/proj/Drones/crazyswarm/ros_ws/build/crazyflie_tools /home/rwik/proj/Drones/crazyswarm/ros_ws/build/crazyflie_tools/CMakeFiles/log.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : crazyflie_tools/CMakeFiles/log.dir/depend
