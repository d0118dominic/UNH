using namespace std;
#include "param.h"
/*

COMPILE EXAMPLE:

g++ dydt_solver.cxx rk4_dydt.cxx dydt.cxx ode_math.cxx -o dydt_solver.exe
./dydt_solver.exe

*/

// define pararmeters
 double yx = 1.0; 		// inital value for y(t) at t = t0
 double t0 = 0.0;		// intial (start) time
 double tn = 1.0;		// stop time
 double dt = 0.1;		// stepsize 

 string fname = "main_outs";

int main ()
{
	rk4_dydt(yx, t0, tn, dt, fname);

	return 0;
}