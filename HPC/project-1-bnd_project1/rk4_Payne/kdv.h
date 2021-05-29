#ifndef KDV_INTEGRATION_H
#define KDV_INTEGRATION_H


#define BOUNDS_CHECK


#include <cassert>
#include <vector>
#include <ostream>

// Declare vector & matrix types


void kdv(double u[], double k[], double dt, double dx);
void rk4(double u[], double u_next[], double dt, double dx);
void Soln(double u[], double t, double c, double a);  // For exact solution 
//void test_rk4(const double U[], double k[], const double dt, const double dx);

// ----------------------------------------------------------------------
// other useful stuff

#include <sys/time.h>
#include <stdlib.h>
// Timing
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
