using namespace std;
#include "kdv_param.h"

/*
TITLE:	u_sol
DESC.:	provides exact solution for KdV equation to test against our solutions; a
		also used to get the initial value u(x,0) where t = 0

		u(x,t) = -0.5 * c * sech^2(0.5 * sqrt(c) * (x - ct - a) )

INPUT:
	x	; position
	t	; time
	c	; phase speed
	a	; arbitrary constant


*/

double u_sol(double x, double t, int c, int a) 
{
	double ax = (0.5*sqrt(c)) * (x - (c * t) - a);
	double bx = (0.5) * c * 1./(pow(cosh(ax), 2));

	return bx;
}


/*
TITLE:	savedat, savevars, setstr
DESC.:	writes KdV solution and parameters to .txt file
		setstrng converts values into string of preset length

INPUT:
		udat	; u(x,t) data to write to file
		x		; x values to write to first columns
		c,a		; constants
		floc	; path/location to write data to
		ftype	; string tag to label outputs

OUTPUT:

	1xN+1 array for all values of du(x)/dt for [x0,N], where the
	first column is our x values

*/

void savedat(vector<vector<double>>& udat, double x[], int c, int a, string floc, string ftype)
{
	int row = udat.size();
	int col = udat[0].size();

	// convert values for string
	string N_str = setstr(row, 8);
	string M_str = setstr(col, 8);
	string c_str = setstr(c, 2);
	string a_str = setstr(a, 2);

	// create file name 
	string fname = "kdv" + ftype + "_" + N_str + "_" + M_str + "_" + c_str + "_" + a_str;
	string fdir = string("..") + '/' + floc + '/' + fname + ".txt";
	cout << "file written to... " << fdir << endl;


	// create file 
	ofstream outfile(fdir);

	// write values to file
	for (int i = 0; i < row; i++)
	{
		outfile << left
			<< x[i] << '\t';

		for (int j = 0; j < col; j++)
		{
			outfile << left
				<< udat[i][j] << '\t'; 
		}
		outfile << "\n";
	}
	// close file
	outfile.close();

	return;
}

// for savedat() function, keeps file name spacing the same
// EX.	INPUT:	22,4	OUTPUT: 0022
//		INPUT:	212,4	OUTPUT: 0212

 string setstr(int num, int clen)
 {
	 string newstr;
	 string cnum = to_string((int)round(num));
	 int nlen = cnum.length();

	 // test
	 assert(nlen <= clen);

	 while (nlen < clen)
	 {
		 newstr = newstr + "0";
		 nlen++;
	 }

	 newstr = newstr + cnum;

	 return newstr;
 }

 // modified version of avdat to save variables to be read into jupyter
 void savevars(int N, int M, int c, int a, double L0, double LN, double dx, double t0, double tn, double dt, string floc)
 {
	// convert values for string
	string N_str = setstr(N, 8);
	string M_str = setstr(M, 8);
	string c_str = setstr(c, 2);
	string a_str = setstr(a, 2);

	// create file name 
	string ftag_nme = "_" + N_str + "_" + M_str + "_" + c_str + "_" + a_str + ".txt";
	string ftag_loc = string("..") + '/' + floc + '/';

	// create file name 
	string vtag = "VARS";
	string vname = "kdv"+vtag;
	string vdir = string("..") + '/' + floc + '/' + vname + ".txt";
	cout << "VARS saved... " << vdir << endl;

	// create file 
	ofstream outfile(vdir);

	// write values to file
	
	outfile << left << "loc" << '\t' << ftag_loc << "\n";
	outfile << left << "tag" << '\t' << ftag_nme << "\n";
	outfile << left << "N" << '\t' << N << "\n";
	outfile << left << "M" << '\t' << M << "\n";
	outfile << left << "c" << '\t' << c << "\n";
	outfile << left <<"a" << '\t' << a << "\n";
	outfile << left <<"L0" << '\t' << L0 << "\n";
	outfile << left << "LN" << '\t' << LN << "\n";
	outfile << left << "dx" << '\t' << dx << "\n";
	outfile << left <<"t0" << '\t' << t0 << "\n";
	outfile << left << "tn" << '\t' << tn << "\n";
	outfile << left << "dt" << '\t' << dt << "\n";

	// close file
	outfile.close();

	return;
 }




/*
* TITLE:	bump
* DESC:		horizontally rotates 1D array by 1
* 
* EX.		INPUT:	[2,4,6,8]	
*			OUTPUT: [8,2,4,6]
*/


 void bump(vector<double>& un, double dx)
 {
	const int N = un.size();	// vector size

	vector<double> temp(N);		// temporary file to store original array
	int i = 0;
	int loc = 1;
	int offset;
	// define sub range 
	if (i < loc) { offset = (i + (N - loc)); }
	if (i >= loc) { offset = (i - loc); }

	// pass values to temporary array
	for (int j = 0; j < N; j++)
	{
		temp[j] = un[j];
	}

	for (int j = 0; j < offset; j++)
	{
		// define i-th iteration as first value
		double i0 = temp[0];

		// shifting values in array
		for (int k = 0; k <= N - 2; k++)
		{
			temp[k] = temp[k + 1];
		}

		// update last element with saved first element
		temp[N - 1] = i0;
	}

	// pass values back to array
	for (int j = 0; j < N; j++)
	{
	un[j] = temp[j];
	//un[j] = un[j]/(dx*dx);
	}
	 
	 return;

 }


