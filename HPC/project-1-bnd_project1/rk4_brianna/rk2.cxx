using namespace std;
#include "kdv_param.h"

// TITLE;	rk2


void rk2(vector<vector<double>>& udat, vector<double>& tdat, vector<double>& ux, double dx, double t0, double tn, double dt)
{
	//int cnan = 0;
	//int cnum = 0;

	const int N =  ux.size();					// x-dimension
	const int M = tdat.size();					// t-dimension 

	cout << " M, N " << M << " " << N << " " << udat[N-1][0] << endl;

	// define initial loop values
	double t = t0;								// initial value for time; t goes from t0 to tn
	int indx = 0;								// index counter for proper array allocation 
	
	vector<double> k1(N);
	vector<double> k2(N);
	vector<double> un(N);

	tdat[0] = t;								// allocate initial t

	for (int i = 0; i < N; i++)
	{
		udat[i][0] = ux[i];						// allocate initial u(x,t)
	}


	while (t < tn)
	{
		//cout << t << " ";
		/*
		*	step 1.
		*	u1 = un(x)
		*	k1 = dudt(u1,t)
		*/
		for (int i = 0; i < N; i++)
		{
			un[i] = ux[i];
		}
		// un[0] = un[N-1]; // ****
\

		rhs(un, k1, dx, dt);

		//cout << "un here is " << un[1] << " ";

		/*
		*	step 2.
		*	u2 = un + dt * 0.5 * k1
		*	k2 = dudt(u2, t+0.5*dt)
		*/

		for (int i = 0; i < N; i++)
		{
			un[i] = dt * (ux[i] + (0.5 * k1[i]));
		}

		rhs(un, k2, dx, dt);

		/*
		*	step 3.
		*	updating values for u(x,tn)
		*/
	

		for (int i = 0; i < N; i++)
		{ 
			un[i] = ux[i]+ k2[i];
		}
		//un[0] = ux[N -1]+k2[N-1];
		//un[N-1] = ux[N - 1] + k1[N - 1];

		// 
		//bump(un,dx); // ********
		//int x0 = un[N-1];

		for (int i = 0; i < N; i++)
		{
			ux[i] = un[i];
		}

		// update to next iteration 
		t += dt;
		indx++;
	

		//ux[N - 1] = ux[0]; // ***********

		// assign current t, u(x,t) and x values to data arrray
		tdat[indx] = t;							// allocate t
		for (int i = 0; i < N; i++)
		{
			udat[i][indx] = ux[i];				// allocate u(x,t)

		}
	}

	return;
	

}


