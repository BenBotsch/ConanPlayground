cmake_minimum_required(VERSION 3.23)
project(consumer LANGUAGES CXX)

find_package(hello CONFIG REQUIRED)
find_package(adder CONFIG REQUIRED)

add_executable(consumer_app src/main.cpp)
target_compile_features(consumer_app PRIVATE cxx_std_17)
target_link_libraries(consumer_app PRIVATE hello::hello adder::adder)
