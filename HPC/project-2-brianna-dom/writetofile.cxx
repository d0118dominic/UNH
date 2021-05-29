using namespace std;
#include "hydrolib.h"
/*
* TITLE:	writetofile
* DESC:		compilation of functions to write data to .txt file
*           
* FILENAME in the form of:  DAT_{P,N}{n}{l}{m}_{PTS}
* P, N designates +/- m value
*/

// Where to save
// "data";

string setstr(int num, int clen);

void writetofile(string floc, int n, int l, int m, int pts, double runtime, vector<double>& xdat, vector<double>& ydat, vector<double>& zdat, vector<double>& rdat, vector<double>& probdat)
{
    int row = 5;
    int col = pts;

    // create file name
    string nstr = to_string((int)round(n));
    string lstr = to_string((int)round(l));
    string mstr = to_string((int)abs(round(m)));

    string msign;
    if (m < 0)
    {
        msign = "N";
    } else {

        msign = "P";
    }

    string pstr = setstr(pts, 8);

    string fname = "DAT_" + msign + nstr + lstr + mstr + "_" + pstr;
    string fdir = string("..") + '/' + floc + '/' + fname + ".txt";

    // create file 
	ofstream outfile(fdir);
    
    // write time to top of file
    string tstr = to_string((double)runtime);
    outfile << left
            << "TIME(s) =" << '\t'
            << tstr << '\t'
            << "\n";

    // write data header
    outfile << left
            << "P" << '\t'
            << "r" << '\t'
            << "X" << '\t' 
            << "Y" << '\t' 
            << "Z" << '\t' 
            << "\n";

    // write values to file
    for (int i = 0; i < col; i++)
    {
        outfile << left
                << probdat[i] << '\t'
                << rdat[i] << '\t'
                << xdat[i] << '\t' 
                << ydat[i] << '\t' 
                << zdat[i] << '\t' 
                << "\n";
    }

    // close file
    outfile.close();

	return;
}



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