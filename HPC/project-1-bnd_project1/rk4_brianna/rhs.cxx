using namespace std;
#include "kdv_param.h"

/*
TITLE:	rhs
DESC. : converts RHS of KdV PDE into solvable ODE in the form of dt* du / dt;
		handles boundaries of differentiation by creating a "padded" array 
INPUT :
		un	; u(x) values
		kn	; kstep array to fill
		dx	; cellstep size
		dt	; timestep size

		OUTPUT :

		kn array for all values of du(x) / dt for[x0, N] where n = 1,2,3,4

*/

void rhs(vector<double>& un, vector<double>& kn, double dx)
{
	// padding parameters					//
	int offset = 3;							// padding offset
	const int N = un.size();				// get vector size 
	vector<double> up(N + (2. * offset));	// array with padding
	
	// solution parameters					// 
	double rhs;								// output dt*du(x)/dt (rhs) at each 
	double* uval;							// pointer to hold adjusted u(x)
	int adj;								// adjustment index for correct u(x)

	// padding values for left/right side
	for (int i = 0; i < offset; i++) 
	{

		double* setn = &un[(N - 1) + offset]; // *
		double* setp = &up[(N - 1) - offset]; // *

		setp[i] = un[i];					// R boundary padding values from [0, offset]
		up[i] = setn[i];					// L boundary padding values from [N-offset, N-1]

	}

	// middle values
	for (int i = 0; i < N; i++)
	{
		up[i + offset] = un[i];
	}

	//up[N-1+offset] = 0; // **

	// integrating with new padded array
	for (int i = 0; i < N; i++)
	{
		// set initial element offset
		adj = i + offset;
		uval = &up[adj];

		//uval[N - 1] = uval[0];

		// test 
		// assert(uval[0] == un[i]);

		rhs = dudt(uval[-2], uval[-1], uval[0], uval[1], uval[2], dx);

		kn[i] = rhs; // dt* rhs;
	}
	return;
}

// finite difference method for derivstive approximation 
// (convert PDE (u(x,t),t) -> ODE (u(x),t)
double dudt(double un2, double un1, double u0, double up1, double up2, double dx)
{
	double dudt;	// du(x)/dt = -u'''(x) - 6*u(x)*u'(x)
	double du1;		// u'(x)
	double du2;		// u''(x)
	double du3;		// u'''(x)

	du1 = (up1 - un1) / (2. * dx);
	du3 = (up2 - (2. * up1) + (2. * un1) - un2) / (2. * dx * dx * dx);
	dudt = -6. * u0 * du1 - du3;

	return dudt;
}
