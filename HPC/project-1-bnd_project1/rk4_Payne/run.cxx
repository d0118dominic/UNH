
#include "kdv.h"
#include <iostream>
#include <cmath>
//Steps:
//  














int main(int argc, char** argv){
  double t0 = 0;
  double tf = 100;
  double dx = 1.0; 		// spatial step
  double dt = 0.001;		// time interval 
  int N = 10000;        // number of grid points
  double L = N*dx;      // length of box
 
  double u[N];
  double u_next[N];
  double t = 0;  
  int i;                 // grid index
  int r;                 // index for writing to file




   //Define initial state here
  Soln(u, t, 4, 1);  // creates u[] with t, c = 4, a = 1

  double t_0 = Wtime();
  while (t < tf){       // Iterate up to a final time tf
    rk4(u, u_next, dt, dx);   // Use rk4 to get values in u at next timestep
     
    if (r%100 == 0){
		printf("%e\n", u_next[i]);  //Put some kind of write to file statement here
	}
    for (i = 0; i < N; i++){
      u[i] = u_next[i];     // Re-define u as u_next to prepare for next iteration
     }
	r++;
    t += dt;                  // Advance time by dt interval
   }
  double t_f = Wtime();
  std::cout << "Run Time: " << t_f - t_0 << "Seconds  \n";
 }
