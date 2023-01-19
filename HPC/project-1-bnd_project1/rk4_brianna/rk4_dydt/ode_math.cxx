using namespace std;
#include "param.h"

int nsteps(double t0, double tn, double dt)
{	
	int ix = 0;

	for(double i = t0; i <= tn; i = i+dt)
	{
		ix = ix+1;
		
		//cout << " ( i is " << i;
		//cout << " new ix " << ix << ")";

	}
	return ix;
}