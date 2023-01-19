using namespace std;
#include "param.h"

// TITLE;	rk4_dydt
// DESC.;	
//
// INPUT;	yx;			inital value of y(t) at t = t0
//			t0;     	initial value fot t (start time)
//			tn;			stop time
//			dt;			step size
//			filename;	name for output file (optional); default = "out.csv"
//
// Eyample implemenaion: 

//u0 x0 u[] to tn dt
// x: [i][xi][u]
void rk4_dydt(double yx, double t0, double tn, double dt, string filename = "out")
{

	// calculating N number of steps taken 
	int N; 
	N = nsteps(t0, tn, dt);

	// create and outfile to store data
	ofstream outfile (filename+".txt");

	// create N rows y 2 cols array of zeros to hold y(t) and t values
	//std::vector < vector < int > > dat(N, vector< int >(2,0));
	double dat[N][2]; // dat[row][col]

	// initiallzing values for loop
	int i = 0;  
	double y = yx;

	// -- 

	//ofstream testfile ("test.txt");
	//int w = 20;
	//testfile << left << setw(w)  << "t" << setw(w) << "y" << setw(w)<< "k1" << setw(w)<< "t+t2" << setw(w)<< "y+y2" << setw(w)<< "k2" << setw(w)<< "t+t3" << setw(w)<< "y+y3" << setw(w)<< "k3" << setw(w)<<"t+t4" << setw(w)<<"y+y4" << setw(w)<<"k4"<< "\n";
	
	// --

	// delcare variables

	double k1, y1, t1;
	double k2, y2, t2;
	double k3, y3, t3;
	double k4, y4, t4;

	for(double t = t0; t <= tn; t = t+dt)
	{
		// allocate current y-t values to array
		dat[i][0] = t; 
		dat[i][1] = y; 

		// write values to file
		int width = 10;
		outfile << left
				<< setw(width) << dat[i][0] 
				<< setw(width) << dat[i][1] << "\n";

		// step 1
		// k1 = dt*dydt(y,t)
		k1 = dt*dydt(y,t,0,0);
		
		// step 2
		// k2 = dt*dydt(y + 0.5*k1, t+0.5*dt)
		y2 = 0.5*k1;
		t2 = 0.5*dt;
		k2 = dt*dydt(y,t,y2,t2);

		// step 3
		//k3 = dt*dydt(y + 0.5*k2, t + 0.5*dt)
		y3 = 0.5*k2;
		t3 = 0.5*dt;
		k3 = dt*dydt(y,t,y3,t3);

		// step 4
		//k4 = dt*dydt(y+k3,t+dt)
		y4 = k3;
		t4 = dt;
		k4 = dt*dydt(y,t,y4,t4);

		// --
		// testfile << left << setw(w) << t << setw(w) << y << setw(w)<< k1 << setw(w)<< t+t2 << setw(w)<< y+y2 << setw(w)<<k2 << setw(w)<<t+t3 << setw(w)<<y+y3 << setw(w)<<k3 << setw(w)<<t+t4 << setw(w)<<y+y4 << setw(w)<<k4<< "\n";
		// --
		
		// update value for y(t) 
		y = y + (1.0/6.0)*(k1 + 2*k2 + 2*k3 + k4);

		// update counter
		i = i++;


	}

	cout << "When t = " << tn << " s,\n";
	cout << "y(t) = "<< dat[i][1] <<"\n";

	// --
	//testfile.close();
	// --


	// close outfile 
	outfile.close();

}