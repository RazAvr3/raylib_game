cmake_minimum_required(VERSION 3.10)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

option(USE_CLANG "Use Clang as the compiler" OFF)
option(USE_GCC "Use GCC as the compiler" OFF)
option(DEBUG_BUILD "Enable debug build" OFF)

# flags
set(DEFAULT_CXX_FLAGS "-Wall -Wextra -Werror")

# compiler type
if (USE_CLANG AND USE_GCC)
    message(FATAL_ERROR "Cannot specify both USE_CLANG and USE_GCC.")
elseif (USE_CLANG)
    set(CMAKE_C_COMPILER "/usr/bin/clang")
    set(CMAKE_CXX_COMPILER "/usr/bin/clang++")
    message(STATUS "Using Clang compiler")
elseif (USE_GCC)
    set(CMAKE_C_COMPILER "/usr/bin/gcc")
    set(CMAKE_CXX_COMPILER "/usr/bin/g++")
    message(STATUS "Using GCC compiler")
endif()

# release/debug mode
if (DEBUG_BUILD)
    set(CMAKE_BUILD_TYPE Debug)
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -g3 -ggdb")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -g3 -ggdb")
    message(STATUS "Debug build")
else()
    set(CMAKE_BUILD_TYPE Release)
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -O3")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -O3")
    message(STATUS "Release build")
endif()

# Add default compiler flags
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${DEFAULT_CXX_FLAGS}")

project(MyRaylibProject)

add_subdirectory(raylib)
add_subdirectory(src)



