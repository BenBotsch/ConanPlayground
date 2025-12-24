cmake_minimum_required(VERSION 3.15)
project(test_package LANGUAGES CXX)

find_package(hello CONFIG REQUIRED)

add_executable(test_package src/main.cpp)
target_compile_features(test_package PRIVATE cxx_std_17)
target_link_libraries(test_package PRIVATE hello::hello)

enable_testing()
add_test(NAME run_test_package COMMAND test_package)
