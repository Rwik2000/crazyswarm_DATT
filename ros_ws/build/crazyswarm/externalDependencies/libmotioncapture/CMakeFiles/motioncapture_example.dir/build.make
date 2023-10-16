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
include crazyswarm/externalDependencies/libmotioncapture/CMakeFiles/motioncapture_example.dir/depend.make

# Include the progress variables for this target.
include crazyswarm/externalDependencies/libmotioncapture/CMakeFiles/motioncapture_example.dir/progress.make

# Include the compile flags for this target's objects.
include crazyswarm/externalDependencies/libmotioncapture/CMakeFiles/motioncapture_example.dir/flags.make

crazyswarm/externalDependencies/libmotioncapture/CMakeFiles/motioncapture_example.dir/examples/main.cpp.o: crazyswarm/externalDependencies/libmotioncapture/CMakeFiles/motioncapture_example.dir/flags.make
crazyswarm/externalDependencies/libmotioncapture/CMakeFiles/motioncapture_example.dir/examples/main.cpp.o: /home/rwik/proj/Drones/crazyswarm/ros_ws/src/crazyswarm/externalDependencies/libmotioncapture/examples/main.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/rwik/proj/Drones/crazyswarm/ros_ws/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object crazyswarm/externalDependencies/libmotioncapture/CMakeFiles/motioncapture_example.dir/examples/main.cpp.o"
	cd /home/rwik/proj/Drones/crazyswarm/ros_ws/build/crazyswarm/externalDependencies/libmotioncapture && /usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/motioncapture_example.dir/examples/main.cpp.o -c /home/rwik/proj/Drones/crazyswarm/ros_ws/src/crazyswarm/externalDependencies/libmotioncapture/examples/main.cpp

crazyswarm/externalDependencies/libmotioncapture/CMakeFiles/motioncapture_example.dir/examples/main.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/motioncapture_example.dir/examples/main.cpp.i"
	cd /home/rwik/proj/Drones/crazyswarm/ros_ws/build/crazyswarm/externalDependencies/libmotioncapture && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/rwik/proj/Drones/crazyswarm/ros_ws/src/crazyswarm/externalDependencies/libmotioncapture/examples/main.cpp > CMakeFiles/motioncapture_example.dir/examples/main.cpp.i

crazyswarm/externalDependencies/libmotioncapture/CMakeFiles/motioncapture_example.dir/examples/main.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/motioncapture_example.dir/examples/main.cpp.s"
	cd /home/rwik/proj/Drones/crazyswarm/ros_ws/build/crazyswarm/externalDependencies/libmotioncapture && /usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/rwik/proj/Drones/crazyswarm/ros_ws/src/crazyswarm/externalDependencies/libmotioncapture/examples/main.cpp -o CMakeFiles/motioncapture_example.dir/examples/main.cpp.s

# Object files for target motioncapture_example
motioncapture_example_OBJECTS = \
"CMakeFiles/motioncapture_example.dir/examples/main.cpp.o"

# External object files for target motioncapture_example
motioncapture_example_EXTERNAL_OBJECTS =

crazyswarm/externalDependencies/libmotioncapture/motioncapture_example: crazyswarm/externalDependencies/libmotioncapture/CMakeFiles/motioncapture_example.dir/examples/main.cpp.o
crazyswarm/externalDependencies/libmotioncapture/motioncapture_example: crazyswarm/externalDependencies/libmotioncapture/CMakeFiles/motioncapture_example.dir/build.make
crazyswarm/externalDependencies/libmotioncapture/motioncapture_example: /home/rwik/proj/Drones/crazyswarm/ros_ws/devel/lib/liblibmotioncapture.so
crazyswarm/externalDependencies/libmotioncapture/motioncapture_example: /home/rwik/proj/Drones/crazyswarm/ros_ws/devel/lib/libViconDataStreamSDK_CPP.a
crazyswarm/externalDependencies/libmotioncapture/motioncapture_example: /usr/lib/x86_64-linux-gnu/libboost_system.so.1.71.0
crazyswarm/externalDependencies/libmotioncapture/motioncapture_example: /usr/lib/x86_64-linux-gnu/libboost_thread.so.1.71.0
crazyswarm/externalDependencies/libmotioncapture/motioncapture_example: /usr/lib/x86_64-linux-gnu/libboost_atomic.so.1.71.0
crazyswarm/externalDependencies/libmotioncapture/motioncapture_example: /home/rwik/proj/Drones/crazyswarm/ros_ws/devel/lib/libqualisys_cpp_sdk.so
crazyswarm/externalDependencies/libmotioncapture/motioncapture_example: /home/rwik/proj/Drones/crazyswarm/ros_ws/devel/lib/libvrpn.so.0
crazyswarm/externalDependencies/libmotioncapture/motioncapture_example: /home/rwik/proj/Drones/crazyswarm/ros_ws/devel/lib/libquat.so
crazyswarm/externalDependencies/libmotioncapture/motioncapture_example: crazyswarm/externalDependencies/libmotioncapture/CMakeFiles/motioncapture_example.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/rwik/proj/Drones/crazyswarm/ros_ws/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable motioncapture_example"
	cd /home/rwik/proj/Drones/crazyswarm/ros_ws/build/crazyswarm/externalDependencies/libmotioncapture && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/motioncapture_example.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
crazyswarm/externalDependencies/libmotioncapture/CMakeFiles/motioncapture_example.dir/build: crazyswarm/externalDependencies/libmotioncapture/motioncapture_example

.PHONY : crazyswarm/externalDependencies/libmotioncapture/CMakeFiles/motioncapture_example.dir/build

crazyswarm/externalDependencies/libmotioncapture/CMakeFiles/motioncapture_example.dir/clean:
	cd /home/rwik/proj/Drones/crazyswarm/ros_ws/build/crazyswarm/externalDependencies/libmotioncapture && $(CMAKE_COMMAND) -P CMakeFiles/motioncapture_example.dir/cmake_clean.cmake
.PHONY : crazyswarm/externalDependencies/libmotioncapture/CMakeFiles/motioncapture_example.dir/clean

crazyswarm/externalDependencies/libmotioncapture/CMakeFiles/motioncapture_example.dir/depend:
	cd /home/rwik/proj/Drones/crazyswarm/ros_ws/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/rwik/proj/Drones/crazyswarm/ros_ws/src /home/rwik/proj/Drones/crazyswarm/ros_ws/src/crazyswarm/externalDependencies/libmotioncapture /home/rwik/proj/Drones/crazyswarm/ros_ws/build /home/rwik/proj/Drones/crazyswarm/ros_ws/build/crazyswarm/externalDependencies/libmotioncapture /home/rwik/proj/Drones/crazyswarm/ros_ws/build/crazyswarm/externalDependencies/libmotioncapture/CMakeFiles/motioncapture_example.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : crazyswarm/externalDependencies/libmotioncapture/CMakeFiles/motioncapture_example.dir/depend

