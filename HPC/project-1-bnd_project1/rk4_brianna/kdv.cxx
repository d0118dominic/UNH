using namespace std;
#define _USE_MATH_DEFINES
#include "kdv_param.h"

// declare u(x,t) constants			//
double c = 4.;						// constant in exact solution; phase speed
double a = 0.;						// constant in exact solution 

// x-grid conditions				//
//double L = 10;					// grid width, can also be (L0-LN)
double LN = 10.;	 				// upper boundary 
double L0 = 0.; ;					// lower boundary 
double nx = 400.;		 			// number of grid points (cells)
double dx = 2.*(LN) / (nx);	 		// cell width 


// t-grid conditions				//
double t0 = 0.;     				// initial value fot t(start time)
double tn = 10.;						// stop time
double dt = 0.0001;					// timestep size; good: dt = 0.0001;
double nt = ((tn - t0) / dt);		// number of timesteps

// array dimensions					//
int N = nx + 1;						// x size
int M = nt + 1;						// t size

// output file parameters			//
string floc = "data";				// folder to hold data 
vector <double> ux(N);				// values of initial u at u(x,t0) ~ u(x)
vector <double> tdat(M);			// values of t

// 2D vector array to hold final u(x,t) values at each time;
std::vector<std::vector<double>> udat(N, std::vector<double>(M, 0));

// 2D vector array to theoretical (exact) u(x,t) values at each time;
std::vector<std::vector<double>> udat_sol(N, std::vector<double>(M, 0));


int main()
{
	// STEP 1.	define gridspace and set intitial values for u(x,t0)
	double x[N];					// values of x
	for (int i = 0; i < N; i++)
	{
		// creating gridspace in 1D-2D form
		x[i] = -LN + (i * dx);


		// set initial value u(x,t0) at each step
		ux[i] = u_sol(x[i], t0, c, a);
	}

	//ux[0] = 0;
	//ux[N - 1] = 0;


	// STEP 2.	solve for the RHS of the equation to convert KdV PDE 
	//			into ODE of the form du/dt
	//					+
	// STEP 3.	solve for the complete solution of u(x,t) for each 
	//			x and t through the RK4 method.

	double tk4_0 = Wtime();

	//rk4(udat, tdat, ux, dx, t0, tn, dt);
	rk4(udat, tdat, ux, dx, t0, tn, dt);
	
	double tk4_1 = Wtime();


	// get theoretical (solution) values for u(x,t) to compare with
	#pragma omp parallel for collapse(2)
	for (int i = 0; i < N; i++)
	{
		for (int j = 0; j < M; j++)
		{
			udat_sol[i][j] = u_sol(x[i], tdat[j], c, a);

		}
	}

	// output to new line
	cout << endl;


	// STEP 4.	write data to .txt file						//
	savedat(udat, x, c, a, floc, "DAT");					// calculated u(x,t)
	savedat(udat_sol, x, c, a, floc, "SOL");				// theoretical u(x,t)
	savevars(N, M, c, a, L0, LN, dx, t0, tn, dt, floc);		// variables

	// output rk4 runtime
	std::cout << "\n" << "Run Time (rk4): " << tk4_1 - tk4_0 << " s  \n";

	return 0;
}

