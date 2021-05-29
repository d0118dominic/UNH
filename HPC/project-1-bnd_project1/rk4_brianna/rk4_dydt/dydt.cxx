using namespace std;
#include "param.h"

double dydt(double yi, double ti, double yk, double tk ) {

	double yval = yi + yk;
	double tval = ti + tk;
	double sum_yt = tval + yval;


	double num = (5*pow(tval,2)) - yval;
	double den = exp(sum_yt);
	double kval = (num/den);

	return kval;
}
