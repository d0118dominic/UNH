# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.20

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Disable VCS-based implicit rules.
% : %,v

# Disable VCS-based implicit rules.
% : RCS/%

# Disable VCS-based implicit rules.
% : RCS/%,v

# Disable VCS-based implicit rules.
% : SCCS/s.%

# Disable VCS-based implicit rules.
% : s.%

.SUFFIXES: .hpux_make_needs_suffix_list

# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /home/d0118dominic/.local/lib/python3.8/site-packages/cmake/data/bin/cmake

# The command to remove a file.
RM = /home/d0118dominic/.local/lib/python3.8/site-packages/cmake/data/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/d0118dominic/UNH/HPC/project-2-brianna-dom

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/d0118dominic/UNH/HPC/project-2-brianna-dom/build

# Include any dependencies generated for this target.
include CMakeFiles/hsolv.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include CMakeFiles/hsolv.dir/compiler_depend.make

# Include the progress variables for this target.
include CMakeFiles/hsolv.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/hsolv.dir/flags.make

CMakeFiles/hsolv.dir/main_hydrogen.cxx.o: CMakeFiles/hsolv.dir/flags.make
CMakeFiles/hsolv.dir/main_hydrogen.cxx.o: ../main_hydrogen.cxx
CMakeFiles/hsolv.dir/main_hydrogen.cxx.o: CMakeFiles/hsolv.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/d0118dominic/UNH/HPC/project-2-brianna-dom/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/hsolv.dir/main_hydrogen.cxx.o"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT CMakeFiles/hsolv.dir/main_hydrogen.cxx.o -MF CMakeFiles/hsolv.dir/main_hydrogen.cxx.o.d -o CMakeFiles/hsolv.dir/main_hydrogen.cxx.o -c /home/d0118dominic/UNH/HPC/project-2-brianna-dom/main_hydrogen.cxx

CMakeFiles/hsolv.dir/main_hydrogen.cxx.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/hsolv.dir/main_hydrogen.cxx.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/d0118dominic/UNH/HPC/project-2-brianna-dom/main_hydrogen.cxx > CMakeFiles/hsolv.dir/main_hydrogen.cxx.i

CMakeFiles/hsolv.dir/main_hydrogen.cxx.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/hsolv.dir/main_hydrogen.cxx.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/d0118dominic/UNH/HPC/project-2-brianna-dom/main_hydrogen.cxx -o CMakeFiles/hsolv.dir/main_hydrogen.cxx.s

CMakeFiles/hsolv.dir/functions.cxx.o: CMakeFiles/hsolv.dir/flags.make
CMakeFiles/hsolv.dir/functions.cxx.o: ../functions.cxx
CMakeFiles/hsolv.dir/functions.cxx.o: CMakeFiles/hsolv.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/d0118dominic/UNH/HPC/project-2-brianna-dom/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building CXX object CMakeFiles/hsolv.dir/functions.cxx.o"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT CMakeFiles/hsolv.dir/functions.cxx.o -MF CMakeFiles/hsolv.dir/functions.cxx.o.d -o CMakeFiles/hsolv.dir/functions.cxx.o -c /home/d0118dominic/UNH/HPC/project-2-brianna-dom/functions.cxx

CMakeFiles/hsolv.dir/functions.cxx.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/hsolv.dir/functions.cxx.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/d0118dominic/UNH/HPC/project-2-brianna-dom/functions.cxx > CMakeFiles/hsolv.dir/functions.cxx.i

CMakeFiles/hsolv.dir/functions.cxx.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/hsolv.dir/functions.cxx.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/d0118dominic/UNH/HPC/project-2-brianna-dom/functions.cxx -o CMakeFiles/hsolv.dir/functions.cxx.s

CMakeFiles/hsolv.dir/vecmath.cxx.o: CMakeFiles/hsolv.dir/flags.make
CMakeFiles/hsolv.dir/vecmath.cxx.o: ../vecmath.cxx
CMakeFiles/hsolv.dir/vecmath.cxx.o: CMakeFiles/hsolv.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/d0118dominic/UNH/HPC/project-2-brianna-dom/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Building CXX object CMakeFiles/hsolv.dir/vecmath.cxx.o"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT CMakeFiles/hsolv.dir/vecmath.cxx.o -MF CMakeFiles/hsolv.dir/vecmath.cxx.o.d -o CMakeFiles/hsolv.dir/vecmath.cxx.o -c /home/d0118dominic/UNH/HPC/project-2-brianna-dom/vecmath.cxx

CMakeFiles/hsolv.dir/vecmath.cxx.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/hsolv.dir/vecmath.cxx.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/d0118dominic/UNH/HPC/project-2-brianna-dom/vecmath.cxx > CMakeFiles/hsolv.dir/vecmath.cxx.i

CMakeFiles/hsolv.dir/vecmath.cxx.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/hsolv.dir/vecmath.cxx.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/d0118dominic/UNH/HPC/project-2-brianna-dom/vecmath.cxx -o CMakeFiles/hsolv.dir/vecmath.cxx.s

CMakeFiles/hsolv.dir/polynomials.cxx.o: CMakeFiles/hsolv.dir/flags.make
CMakeFiles/hsolv.dir/polynomials.cxx.o: ../polynomials.cxx
CMakeFiles/hsolv.dir/polynomials.cxx.o: CMakeFiles/hsolv.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/d0118dominic/UNH/HPC/project-2-brianna-dom/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_4) "Building CXX object CMakeFiles/hsolv.dir/polynomials.cxx.o"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT CMakeFiles/hsolv.dir/polynomials.cxx.o -MF CMakeFiles/hsolv.dir/polynomials.cxx.o.d -o CMakeFiles/hsolv.dir/polynomials.cxx.o -c /home/d0118dominic/UNH/HPC/project-2-brianna-dom/polynomials.cxx

CMakeFiles/hsolv.dir/polynomials.cxx.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/hsolv.dir/polynomials.cxx.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/d0118dominic/UNH/HPC/project-2-brianna-dom/polynomials.cxx > CMakeFiles/hsolv.dir/polynomials.cxx.i

CMakeFiles/hsolv.dir/polynomials.cxx.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/hsolv.dir/polynomials.cxx.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/d0118dominic/UNH/HPC/project-2-brianna-dom/polynomials.cxx -o CMakeFiles/hsolv.dir/polynomials.cxx.s

CMakeFiles/hsolv.dir/writetofile.cxx.o: CMakeFiles/hsolv.dir/flags.make
CMakeFiles/hsolv.dir/writetofile.cxx.o: ../writetofile.cxx
CMakeFiles/hsolv.dir/writetofile.cxx.o: CMakeFiles/hsolv.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/d0118dominic/UNH/HPC/project-2-brianna-dom/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_5) "Building CXX object CMakeFiles/hsolv.dir/writetofile.cxx.o"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT CMakeFiles/hsolv.dir/writetofile.cxx.o -MF CMakeFiles/hsolv.dir/writetofile.cxx.o.d -o CMakeFiles/hsolv.dir/writetofile.cxx.o -c /home/d0118dominic/UNH/HPC/project-2-brianna-dom/writetofile.cxx

CMakeFiles/hsolv.dir/writetofile.cxx.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/hsolv.dir/writetofile.cxx.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/d0118dominic/UNH/HPC/project-2-brianna-dom/writetofile.cxx > CMakeFiles/hsolv.dir/writetofile.cxx.i

CMakeFiles/hsolv.dir/writetofile.cxx.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/hsolv.dir/writetofile.cxx.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/d0118dominic/UNH/HPC/project-2-brianna-dom/writetofile.cxx -o CMakeFiles/hsolv.dir/writetofile.cxx.s

# Object files for target hsolv
hsolv_OBJECTS = \
"CMakeFiles/hsolv.dir/main_hydrogen.cxx.o" \
"CMakeFiles/hsolv.dir/functions.cxx.o" \
"CMakeFiles/hsolv.dir/vecmath.cxx.o" \
"CMakeFiles/hsolv.dir/polynomials.cxx.o" \
"CMakeFiles/hsolv.dir/writetofile.cxx.o"

# External object files for target hsolv
hsolv_EXTERNAL_OBJECTS =

hsolv: CMakeFiles/hsolv.dir/main_hydrogen.cxx.o
hsolv: CMakeFiles/hsolv.dir/functions.cxx.o
hsolv: CMakeFiles/hsolv.dir/vecmath.cxx.o
hsolv: CMakeFiles/hsolv.dir/polynomials.cxx.o
hsolv: CMakeFiles/hsolv.dir/writetofile.cxx.o
hsolv: CMakeFiles/hsolv.dir/build.make
hsolv: /usr/lib/x86_64-linux-gnu/openmpi/lib/libmpi_cxx.so
hsolv: /usr/lib/x86_64-linux-gnu/openmpi/lib/libmpi.so
hsolv: lib/libgtest_main.a
hsolv: lib/libgtest.a
hsolv: CMakeFiles/hsolv.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/d0118dominic/UNH/HPC/project-2-brianna-dom/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_6) "Linking CXX executable hsolv"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/hsolv.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/hsolv.dir/build: hsolv
.PHONY : CMakeFiles/hsolv.dir/build

CMakeFiles/hsolv.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/hsolv.dir/cmake_clean.cmake
.PHONY : CMakeFiles/hsolv.dir/clean

CMakeFiles/hsolv.dir/depend:
	cd /home/d0118dominic/UNH/HPC/project-2-brianna-dom/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/d0118dominic/UNH/HPC/project-2-brianna-dom /home/d0118dominic/UNH/HPC/project-2-brianna-dom /home/d0118dominic/UNH/HPC/project-2-brianna-dom/build /home/d0118dominic/UNH/HPC/project-2-brianna-dom/build /home/d0118dominic/UNH/HPC/project-2-brianna-dom/build/CMakeFiles/hsolv.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/hsolv.dir/depend
