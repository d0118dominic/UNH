#ifndef PARAM_H
#define PARAM_H

#define BOUNDS_CHECK

// XTENSOR ---------------------
// #include <xtensor/xtensor.hpp>
// #include <xtensor/xcsv.hpp>

#include <cassert>
#include <vector>
#include <ostream>
#include <iostream>
#include <iomanip>
#include <fstream>  
#include <cmath>


// XTENSOR ---------------------
// Setup for 2D vector to hold rk4 data
// using matrix = xt::zeros<double, 2>;

// declare functions 
int nsteps(double t0, double tn, double dt);
double dydt(double yi, double ti, double yk, double tk );
void rk4_dydt(double yx, double t0, double tn, double dt, string filename);
// rk4_b();



// notes:
// -------------
// Arrays are indexed starting at 0, as opposed to starting at 1. 
// The first element of the array arr[0]. 
// The index to the last value in the array is the array size minus one.

// arr = [row, col]

#endif