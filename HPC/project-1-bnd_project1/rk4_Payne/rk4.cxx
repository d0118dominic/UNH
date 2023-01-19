#include "kdv.h"

#include <iostream>
#include <cmath>

// initiailize variables



// initialize timestep



// allocate arrays


void rk4(double u[], double u_next[], double dt, double dx){
  int i;
  int N = sizeof(u);
  
  double k1[N];
  double k2[N];
  double k3[N];
  double k4[N];
  //double u_next[N];

  kdv(u, k1, dt, dx);  // Gets values of rhs with U as input.  Puts results into k1[]
  
  for(i = 0; i<N; i++){
    u_next[i] = u[i] + 0.5 * k1[i] * dt;

  }
   

  kdv(u_next, k2, dt, dx);
  
  for(i = 0; i<N; i++){
    u_next[i] = u[i] + 0.5 * k2[i] * dt;

  }
   

  kdv(u_next, k3, dt, dx);
  
  for(i = 0; i<N; i++){
    u_next[i] = u[i] + k3[i] * dt;

  }
   

  kdv(u_next, k4, dt, dx);
  
  for(i = 0; i<N; i++){
    u_next[i] = u[i] + (k1[i] + 2*k2[i] + 2*k3[i] + k4[i])*(dt/6.);

  }
}
