#ifndef KDV_PARAM_H
#define KDV_PARAM_H

#define BOUNDS_CHECK

#include <cassert>
#include <vector>
#include <string>
#include <ostream>
#include <iostream>
#include <iomanip>
#include <fstream>  
#include <cmath>
#include <typeinfo> //rm when done



// declare functions 

// kdv_func.cxx
double u_sol(double x, double t, int c, int a);
void bump(vector<double>& un, double dx);
string setstr(int num, int clen);
void savedat(vector<vector<double>>& udat, double x[], int c, int a, string floc, string ftype);
void savevars(int N, int M, int c, int a, double L0, double LN, double dx, double t0, double tn, double dt, string floc);

// rhs.cxx
double dudt(double un2, double un1, double u0, double up1, double up2, double dx);
void rhs(vector<double>& un, vector<double>& kn, double dx);

// rk4.cxx
void rk4(vector<vector<double>>& udat, vector<double>& tdat, vector<double>& ux, double dx, double t0, double tn, double dt);

// rk2.cxx
void rk2(vector<vector<double>>& udat, vector<double>& tdat, vector<double>& ux, double dx, double t0, double tn, double dt);

// Timing

#include <sys/time.h>
#include <stdlib.h>

static inline double Wtime(void)
{
	struct timeval tv;
	gettimeofday(&tv, NULL);
	return tv.tv_sec + tv.tv_usec / 1e6;
}

// ----------------------------------------------------------------------

#include <stdio.h>
#define HERE                                                                   \
  fprintf(stderr, "HERE at %s:%d (%s)\n", __FILE__, __LINE__, __FUNCTION__)

#endif

// notes:
// ----------------------------------------------------------------------
// Arrays are indexed starting at 0, as opposed to starting at 1. 
// The first element of the array arr[0]. 
// The index to the last value in the array is the array size minus one.
// arr = [row, col]
// other useful stuff
