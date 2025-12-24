cmake_minimum_required(VERSION 3.15)
project(adder LANGUAGES CXX)

add_library(adder src/adder.cpp)
add_library(adder::adder ALIAS adder)

target_include_directories(adder
    PUBLIC
      $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
      $<INSTALL_INTERFACE:include>
)
target_compile_features(adder PUBLIC cxx_std_17)

include(GNUInstallDirs)

install(TARGETS adder
  EXPORT adderTargets
  ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
  LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
  RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
install(DIRECTORY include/ DESTINATION ${CMAKE_INSTALL_INCLUDEDIR})

install(EXPORT adderTargets
  NAMESPACE adder::
  DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/adder
)
