cmake_minimum_required(VERSION 3.15)
project(hello LANGUAGES CXX)

add_library(hello src/hello.cpp)
add_library(hello::hello ALIAS hello)

target_include_directories(hello
    PUBLIC
      $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
      $<INSTALL_INTERFACE:include>
)
target_compile_features(hello PUBLIC cxx_std_17)

if (WIN32 AND BUILD_SHARED_LIBS)
  set_target_properties(hello PROPERTIES WINDOWS_EXPORT_ALL_SYMBOLS ON)
endif()

include(GNUInstallDirs)

install(TARGETS hello
  EXPORT helloTargets
  ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
  LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
  RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
install(DIRECTORY include/ DESTINATION ${CMAKE_INSTALL_INCLUDEDIR})

install(EXPORT helloTargets
  NAMESPACE hello::
  DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/hello
)
