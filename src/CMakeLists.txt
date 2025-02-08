if (CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
    # set(CMAKE_CXX_CLANG_TIDY "clang-tidy")
endif()

include_directories(raylib/src)

add_executable(my_program main.cpp)

target_link_libraries(my_program raylib)

target_include_directories(my_program PRIVATE ${CMAKE_SOURCE_DIR}/raylib/src)
