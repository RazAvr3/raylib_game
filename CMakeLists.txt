cmake_minimum_required(VERSION 3.10)
project(MyRaylibProject)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

add_subdirectory(raylib)

include_directories(raylib/src)

add_executable(my_program main.cpp)

target_link_libraries(my_program raylib)

# target_link_libraries(my_program m dl pthread GL X11)
