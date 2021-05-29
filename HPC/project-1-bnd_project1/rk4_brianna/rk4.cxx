using namespace std;
#include "kdv_param.h"

// TITLE;	rk4
// DESC.;	4th runge-kutta method of integration
//
// INPUT;	udat	; empty vector array output containing all u(x) values at each time
//			tdat	; **currently unsused, output data vector of all time values
//			ux		; inital value of y(t) at t = t0
//			dx		; cellstep size
//			t0		; initial value fot t (start time)
//			tn		; stop time
//			dt		; timestep size
//

void rk4(vector<vector<double>>& udat, vector<double>& tdat, vector<double>& ux, double dx, double t0, double tn, double dt)
{

	const int N =  ux.size();		// x-dimension
	const int M = tdat.size();		// t-dimension 

	vector<double> k1(N);
	vector<double> k2(N);
	vector<double> k3(N);
	vector<double> k4(N);
	vector<double> un(N);

	// define initial loop values	//
	double t = t0;					// initial value for time; t goes from t0 to tn
	int indx = 0;					// index counter for proper array allocation 

	// add initial values at t = t0 to our final data arrays
	tdat[0] = t;								
	for (int i = 0; i < N; i++)
	{
		udat[i][0] = ux[i];						
	}

	// rk4 loop
	while (t < tn)
	{

		// allocate t, u(x,t) and x values to output arrays above t = t0
		if (t > t0)
		{
			tdat[indx] = indx*dt;
			for (int i = 0; i < N; i++)
			{
				ux[i] = un[i];
				udat[i][indx] = ux[i];
			}
		}

		/*
		*	step 1.
		*	u1 = un(x)
		*	k1 = dudt(u1,t)
		*/

		for (int i = 0; i < N; i++)
		{
			un[i] = ux[i];
		}

		rhs(un, k1, dx);

		/*
		*	step 2.
		*	u2 = un + dt * 0.5 * k1
		*	k2 = dudt(u2, t+0.5*dt)
		*/

		for (int i = 0; i < N; i++)
		{
			un[i] = ux[i] + (dt * 0.5 * k1[i]);
		}

		rhs(un, k2, dx);

		/*
		*	step 3.
		*	u3 = un + dt * 0.5 * k2
		*	k3 = dudt(u3, t+0.5*dt)
		*/

		for (int i = 0; i < N; i++)
		{
			un[i] = ux[i] + (dt * 0.5 * k2[i]);
		}

		rhs(un, k3, dx);

		/*
		*	step 4.
		*	u4 = un + dt * k3
		*	k4 = dudt(u4,t+dt)
		*/

		for (int i = 0; i < N; i++)
		{
			un[i] = ux[i] + (dt * k3[i]);
		}
		rhs(un, k4, dx);


		/*
		*	step 5.
		*	updating values for u(x,tn)
		*	u(x,t+1) = u(x,t) + 1/6*(k1 + 2*k2 + 2*k3 + k4)*dt 
		*/

		for (int i = 0; i < N; i++)
		{ 
			un[i] = ux[i] + (dt / 6.) * (k1[i] + (2. * k2[i]) + (2. * k3[i]) + k4[i]);

			// test check if values exceed double memory allocation
			bool nancheck = isnan(un[i]);
			if(nancheck != 0)
			{
				//cout << "(!) double exceeds memory allocation, nx too big \n";
				//assert(nancheck == 0);
			}
		}

	
		// update to next iteration 
		t += dt;
		indx++;


	}

	

cout << t <<" "<< indx << " " << udat[60][M-1];

	return;
	

}


