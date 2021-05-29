using namespace std;
#include "hydrolib.h"


/*
* TITLE:	lagurre
* DESC:		calculate lagurre polynomial
*/

double laguerre(int n, int l, double rho)
{
    int k0 = 0;
    int kn = n-l-1;

    double sum = 0.;

    for(int k = k0; k < kn+1; k++)
    {
        double a = pow(abs(factorial(n + l)),2.);
        double b = factorial(n - l - 1. - k)*factorial(2*l + 1. + k)*factorial(k);
        double c = pow(rho,k);

        sum = sum + pow((-1.),(k + 1.))*(a/b)*c;
    }

    return sum;
    
}

// 24,25
// legendre polynomial 3-term recurrence relation
// (n + 1) P{n + 1}(x) = (2b + 1) xP{n}(x)-nP{n - 1}(x)

double leg_rod(int a, double x)
{
    vector<double> plst(a+1);

    double P0 = 1.;
    double P1 = x;
    double Pa;

    if(a == 0)
    {
        Pa = P0;

    } else if (a == 1){

        Pa = P1;

    } else {
        
        plst[0] = P0;
        plst[1] = P1;

        for (int i = 2; i < a+1; i++)
        {
            double Pn1 = plst[i - 1];
            double Pn2 = plst[i - 2];

            Pa = ((2. * i - 1.) * x * Pn1 - (i - 1.) * Pn2) / i;

            plst[i] = Pa;
        }
    }

    return Pa;
}

/*
* TITLE:	leg_dPdx
* DESC:		first derivative of  legendre polynomial
*/

double leg_dPdx(int a, double x)
{
    // check a is above 1
    assert(a > 1);

    double dP = (a * leg_rod(a - 1., x) - x * leg_rod(a, x)) / (1. - (x * x));

    return dP;
}

/*
* TITLE:	leg_aso
* DESC:		associated legendre polynomial
*/

double leg_aso(int m, int a, double x)
{
    vector<double> plst(m+1);

    double Pma;
    double dPa;

    double coeff = pow(-1., m) * pow((1 - (x * x)), m / 2.);
    double P0a = leg_rod(a, x);
    double P11 = pow(-1.*(1. - (x * x)), 0.5);

    if (m == 0 )
    {
        Pma = P0a;

    } else if (m == 1) {

        if ( a == 1) 
        {
            Pma = P11;

        } else {

            dPa = coeff * leg_dPdx(a, x);
            Pma = dPa;
        }
    } else {

        dPa = coeff * leg_dPdx(a, x);

        plst[0] = P0a;
        plst[1] = dPa;

        for (int i = 2; i < m+1; i++) 
        {

            double Pn1 = plst[i - 1];
            double Pn2 = plst[i - 2];

            Pma = -1. * (2. * i * x) / sqrt(1 - (x * x)) * Pn1 - (a + i - 1.) * (a - i) * Pn2;
            plst[i] = Pma;
        }


    }

    return Pma;
}

