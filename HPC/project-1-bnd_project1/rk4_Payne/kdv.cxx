#include "kdv.h"

#include <iostream>
#include <cmath>

// Takes an array U, and calculates the rhs of kdv at each element 
void kdv(double u[], double k[], double dt, double dx){
  
  int N = sizeof(u);
  
 

  double f1[N];
  double f2[N];
  double b1[N];
  double b2[N];
  double d1u[N];
  double d3u[N];
  double rhs[N];

  
  
  int i;  
  for(i = 0; i < N-1; i++){
      f1[i] = u[i+1];
  } 
  f1[N-1] = u[0];  // Forward 1 at the last element is the first element
  
  for(i = 0; i < N-2; i++){
      f2[i] = u[i+2];
  } 
  f2[N-1] = u[1]; // Forward 2 at the last element is the second element
  f2[N-2] = u[0]; // Forward 2 at the 2nd to last element is the first element


  for(i = 1; i < N; i++){
      b1[i] = u[i-1];
  } 
  b1[0] = u[N-1];

  for(i = 2; i < N; i++){
      b2[i] = u[i-2];
  } 
  b2[0] = u[N-2];
  b2[1] = u[N-1];



  for(i = 0; i < N; i++){

    d1u[i] = (f1[i] - b1[i]) / (2*dx);
    d3u[i] = (f2[i] + b2[i] - 2*(f1[i] - b1[i])) / (2*pow(dx, 3));

}


// Making the RHS of kdv --> du/dt = - u''' - 6u * u'

  for(i = 0; i < N; i++){
    rhs[i] = -d3u[i] - 6*u[i]*d1u[i];

  for (i = 0; i < N; i++){
    k[i] = rhs[i];
  }
    
  
}

}
