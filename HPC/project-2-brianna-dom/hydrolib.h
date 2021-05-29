#ifndef HYDROLIB_H
#define HYDROLIB_H

#define BOUNDS_CHECK

#include <cassert>
#include <vector>
#include <string>
#include <ostream>
#include <iostream>
#include <iomanip>
#include <fstream>  
#include <cmath>
#include <complex>
#include <random>
#include <mpi.h>

// MAIN: main_hydrogen.cxx

// FUNCTION DELCARATIONS

// vecmath.cxx
int factorial(int num);
double Randomize(double a, double b);
double vecAvrg(vector<double> &vec);

// functions.cxx
double radius(double x, double y, double z);
double theta(double x, double y, double z);
double rmag(int dx, int dy, int dz);
double rho(int n, int Z, double a0, double r);
double R_rad(int n, int l, double rho, double r);
double Y_ang(int l, int m, double theta, double phi);
double probability(double rad, double ang);
double get_probMax(double rMax, double thetMax, double a0, int Z, int n, int l, int m);

// polynomials.cxx
double laguerre(int n, int l, double rho);
double leg_rod(int a, double x);
double leg_dPdx(int a, double x);
double leg_aso(int m, int a, double x);

// writetofile.cxx
void writetofile(string floc, int n, int l, int m, int pts, double runtime, vector<double> &xdat, vector<double> &ydat, vector<double> &zdat, vector<double> &rdat, vector<double> &probdat);

// TIMING
#include <sys/time.h>
#include <stdlib.h>

static inline double Wtime(void)
{
	struct timeval tv;
	gettimeofday(&tv, NULL);
	return tv.tv_sec + tv.tv_usec / 1e6;
}

#include <stdio.h>
#define HERE                                                                   \
  fprintf(stderr, "HERE at %s:%d (%s)\n", __FILE__, __LINE__, __FUNCTION__)

#endif



