
#include "kdv.h"

#include <iostream>
#include <cmath>



void Soln(double u[], double t, double c, double a) 
{ 
  double c = 4;
  double a = 0;
  double t = 0;

  int N = sizeof(u);
  int i;
  //double arg1[];
  
  for(i=0; i < N; i++){
    //arg1[i] = (0.5*sqrt(c))*(u[i] - c*t - a);
    u[i] = -0.5 * c * 1/(pow(cosh((0.5*sqrt(c))*(u[i] - c*t - a)), 2));

  }
}


//{
 // const int N = 100;
  //double* u1 = {1., 2., 3.};
  //double* u2 = {2., 3., 4.};

//  EXPECT_EQ(dot(x, y), 20.);
//}




