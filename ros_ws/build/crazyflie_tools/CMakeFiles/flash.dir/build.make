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
include crazyflie_tools/CMakeFiles/flash.dir/depend.make

# Include the progress variables for this target.
include crazyflie_tools/CMakeFiles/flash.dir/progress.make

# Include the compile flags for this target's objects.
include crazyflie_tools/CMakeFiles/flash.dir/flags.make

crazyflie_tools/CMakeFiles/flash.dir/src/flash.cpp.o: crazyflie_tools/CMakeFiles/flash.dir/flags.make
crazyflie_tools/CMakeFiles/flash.dir/src/flash.cpp.o: /home/rwik/proj/Drones/crazyswarm/ros_ws/src/crazyflie_tools/src/flash.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/rwik/proj/Drones/crazyswarm/ros_ws/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object crazyflie_tools/CMakeFiles/flash.dir/src/flash.cpp.o"
	cd /home/rwik/proj/Drones/crazyswarm/ros_ws/build/crazyflie_tools && /usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/flash.dir/src/flash.cpp.o -c /home/rwik/proj/Drones/crazyswarm/ros_ws/src/crazyflie_tools/src/flash.cpp

crazyflie_tools/CMakeFiles/flash.dir/src/flash.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/flash.dir/src/flash.cpp.i"
	cd /home/rwik/proj/Drones/crazyswarm/ros_ws/build/crazyflie_tools && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/rwik/proj/Drones/crazyswarm/ros_ws/src/crazyflie_tools/src/flash.cpp > CMakeFiles/flash.dir/src/flash.cpp.i

crazyflie_tools/CMakeFiles/flash.dir/src/flash.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/flash.dir/src/flash.cpp.s"
	cd /home/rwik/proj/Drones/crazyswarm/ros_ws/build/crazyflie_tools && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/rwik/proj/Drones/crazyswarm/ros_ws/src/crazyflie_tools/src/flash.cpp -o CMakeFiles/flash.dir/src/flash.cpp.s

# Object files for target flash
flash_OBJECTS = \
"CMakeFiles/flash.dir/src/flash.cpp.o"

# External object files for target flash
flash_EXTERNAL_OBJECTS =

/home/rwik/proj/Drones/crazyswarm/ros_ws/devel/lib/crazyflie_tools/flash: crazyflie_tools/CMakeFiles/flash.dir/src/flash.cpp.o
/home/rwik/proj/Drones/crazyswarm/ros_ws/devel/lib/crazyflie_tools/flash: crazyflie_tools/CMakeFiles/flash.dir/build.make
/home/rwik/proj/Drones/crazyswarm/ros_ws/devel/lib/crazyflie_tools/flash: /home/rwik/proj/Drones/crazyswarm/ros_ws/devel/lib/libcrazyflie_cpp.so
/home/rwik/proj/Drones/crazyswarm/ros_ws/devel/lib/crazyflie_tools/flash: /usr/lib/x86_64-linux-gnu/libboost_program_options.so.1.71.0
/home/rwik/proj/Drones/crazyswarm/ros_ws/devel/lib/crazyflie_tools/flash: /usr/lib/x86_64-linux-gnu/libusb-1.0.so
/home/rwik/proj/Drones/crazyswarm/ros_ws/devel/lib/crazyflie_tools/flash: crazyflie_tools/CMakeFiles/flash.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/rwik/proj/Drones/crazyswarm/ros_ws/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable /home/rwik/proj/Drones/crazyswarm/ros_ws/devel/lib/crazyflie_tools/flash"
	cd /home/rwik/proj/Drones/crazyswarm/ros_ws/build/crazyflie_tools && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/flash.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
crazyflie_tools/CMakeFiles/flash.dir/build: /home/rwik/proj/Drones/crazyswarm/ros_ws/devel/lib/crazyflie_tools/flash

.PHONY : crazyflie_tools/CMakeFiles/flash.dir/build

crazyflie_tools/CMakeFiles/flash.dir/clean:
	cd /home/rwik/proj/Drones/crazyswarm/ros_ws/build/crazyflie_tools && $(CMAKE_COMMAND) -P CMakeFiles/flash.dir/cmake_clean.cmake
.PHONY : crazyflie_tools/CMakeFiles/flash.dir/clean

crazyflie_tools/CMakeFiles/flash.dir/depend:
	cd /home/rwik/proj/Drones/crazyswarm/ros_ws/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/rwik/proj/Drones/crazyswarm/ros_ws/src /home/rwik/proj/Drones/crazyswarm/ros_ws/src/crazyflie_tools /home/rwik/proj/Drones/crazyswarm/ros_ws/build /home/rwik/proj/Drones/crazyswarm/ros_ws/build/crazyflie_tools /home/rwik/proj/Drones/crazyswarm/ros_ws/build/crazyflie_tools/CMakeFiles/flash.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : crazyflie_tools/CMakeFiles/flash.dir/depend

