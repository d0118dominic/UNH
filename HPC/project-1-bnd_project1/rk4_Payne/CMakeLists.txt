
cmake_minimum_required (VERSION 3.11)

project(KdV_Solver)

set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)


find_package(OpenMP REQUIRED)

add_library(kdvcxx
  kdv.cxx
  rk4.cxx
  test_kdv.cxx
  run.cxx
)

include(cmake/CPM.cmake)
CPMAddPackage(
  NAME googletest
  GITHUB_REPOSITORY google/googletest
  GIT_TAG release-1.10.0
  VERSION 1.10.0
  OPTIONS
      "INSTALL_GTEST OFF"
      "gtest_force_shared_crt ON"
)

if (googletest_ADDED)
  add_library(GTest::GTest INTERFACE IMPORTED)
  target_include_directories(GTest::GTest INTERFACE "${googletest_SOURCE_DIR}/googletest/include")
  target_link_libraries(GTest::GTest INTERFACE gtest)
  
  add_library(GTest::Main INTERFACE IMPORTED)
  target_link_libraries(GTest::Main INTERFACE gtest_main)
endif()

  
enable_testing()


add_executable(kdv kdv.cxx)
target_link_libraries(kdv OpenMP::OpenMP_CXX)
target_link_libraries(kdv GTest::GTest GTest::Main)


add_executable(run run.cxx rk4.cxx kdv.cxx test_kdv)
target_link_libraries(run OpenMP::OpenMP_CXX)
target_link_libraries(run GTest::GTest GTest::Main)


