
cmake_minimum_required (VERSION 3.11)

project(Hydrogen_Solver)

set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(MPI REQUIRED)

include_directories(~/../../usr/lib/x86_64-linux-gnu/openmpi/include/)
add_library(hydrocxx
  main_hydrogen.cxx
  functions.cxx
  vecmath.cxx
  polynomials.cxx
  writetofile.cxx)

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


target_link_libraries(hydrocxx PUBLIC xtensor)


add_executable(hsolv main_hydrogen.cxx functions.cxx vecmath.cxx polynomials.cxx writetofile.cxx)


target_link_libraries(hsolv MPI::MPI_CXX)
target_link_libraries(hsolv GTest::GTest GTest::Main)

