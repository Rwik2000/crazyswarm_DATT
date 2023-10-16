cmake_minimum_required(VERSION 2.8.3)
project(crazyflie_tools)

# Enable C++11 and warnings
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

add_compile_options(-Wall -Wextra -Werror)

find_package(Boost REQUIRED COMPONENTS program_options REQUIRED)
add_subdirectory(crazyflie_cpp)

include_directories(
  crazyflie_cpp/include
)

# scan
add_executable(scan
  src/scan.cpp
)
target_link_libraries(scan
  crazyflie_cpp
  ${Boost_LIBRARIES}
)

# listParams
add_executable(listParams
  src/listParams.cpp
)
target_link_libraries(listParams
  crazyflie_cpp
  ${Boost_LIBRARIES}
)

# listLogVariables
add_executable(listLogVariables
  src/listLogVariables.cpp
)
target_link_libraries(listLogVariables
  crazyflie_cpp
  ${Boost_LIBRARIES}
)

# listMemories
add_executable(listMemories
  src/listMemories.cpp
)
target_link_libraries(listMemories
  crazyflie_cpp
  ${Boost_LIBRARIES}
)

# reboot
add_executable(reboot
  src/reboot.cpp
)
target_link_libraries(reboot
  crazyflie_cpp
  ${Boost_LIBRARIES}
)

# battery
add_executable(battery
  src/battery.cpp
)
target_link_libraries(battery
  crazyflie_cpp
  ${Boost_LIBRARIES}
)

# version
add_executable(version
  src/version.cpp
)
target_link_libraries(version
  crazyflie_cpp
  ${Boost_LIBRARIES}
)

# console
add_executable(console
  src/console.cpp
)
target_link_libraries(console
  crazyflie_cpp
  ${Boost_LIBRARIES}
)

# flash
add_executable(flash
  src/flash.cpp
)
target_link_libraries(flash
  crazyflie_cpp
  ${Boost_LIBRARIES}
)

# comCheck
add_executable(comCheck
  src/comCheck.cpp
)
target_link_libraries(comCheck
  crazyflie_cpp
  ${Boost_LIBRARIES}
)

# log
add_executable(log
  src/log.cpp
)
target_link_libraries(log
  crazyflie_cpp
  ${Boost_LIBRARIES}
)

# downloadUSDLogfile
add_executable(downloadUSDLogfile
  src/downloadUSDLogfile.cpp
)
target_link_libraries(downloadUSDLogfile
  crazyflie_cpp
  ${Boost_LIBRARIES}
)

# setParam
add_executable(setParam
  src/setParam.cpp
)
target_link_libraries(setParam
  crazyflie_cpp
  ${Boost_LIBRARIES}
)