include(/home/d0118dominic/UNH/HPC/project-2-brianna-dom/build/cmake/CPM_0.31.1.cmake)
CPMAddPackage(NAME;googletest;GITHUB_REPOSITORY;google/googletest;GIT_TAG;release-1.10.0;VERSION;1.10.0;OPTIONS;INSTALL_GTEST OFF;gtest_force_shared_crt ON)
set(googletest_FOUND TRUE)