
cmake_minimum_required (VERSION 3.11)

project(KdV_Sol)

set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(OpenMP REQUIRED)

add_library(kdvcxx
  kdv_func.cxx
  rhs.cxx
  rk4.cxx
  kdv.cxx)

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


target_link_libraries(kdvcxx PUBLIC xtensor)


add_executable(kdv kdv.cxx rhs.cxx rk4.cxx kdv_func.cxx)


target_link_libraries(kdv OpenMP::OpenMP_CXX)
target_link_libraries(kdv GTest::GTest GTest::Main)

target_link_libraries(kdv OpenMP::OpenMP_CXX)
target_link_libraries(kdv GTest::GTest GTest::Main)