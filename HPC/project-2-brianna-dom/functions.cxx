using namespace std;
#define _USE_MATH_DEFINES
#include "hydrolib.h"

/*
* TITLE:	radius
* DESC:		calculate radius r from r^2 = (x^2 + y^2 + z^2)
*/
double radius(double x, double y, double z)
{
    double ans = pow(((x*x) + (y*y) + (z*z)),0.5);
    return ans;
}

/*
* TITLE:	theta
* DESC:		calculate theta
*           theta = arcos(z/radius)
*/
double theta(double x, double y, double z)
{
    double ans;
    
    if (z == 0){

        ans = atan2(y, x);

    } else {

        double a = z;
        double b = sqrt((x*x) + (y*y) + (z*z));

        ans = acos(a/b);

    }
    return ans;
}

/*
* TITLE:	rmag
* DESC:		magnitude of vector at center of box
            to corner
*/
double rmag(int dx, int dy, int dz)
{
    double ans = 0.5 * sqrt((dx * dx) + (dy * dy) + (dz * dz));
    return ans;
}



/*
* TITLE:	rho
* DESC:		calculate 2*Z*radius/n*a0
*/
double rho(int n, int Z, double a0, double r)
{
    double a = 2.*Z*r;
    double b = n*a0;

    double ans = a/b;
    return ans;
}



/*
* TITLE:	R_rad (R(r))
* DESC:		radial component of wavefunction, where psi = R(r)Y(theta,psi)
*/

double R_rad(int n, int l, double rho, double r)
{
    double lpoly = laguerre(n, l, rho);
    double a = factorial(n - l - 1.);
    double b = 2.*n*pow(factorial(n + l),3.);
    double c = -1.*sqrt(pow((rho/r),3.)*(a/b));

    double ans  = c*exp(-rho/2.)*pow(rho,l)*lpoly;
    return ans;

}

/*
* TITLE:	Y_ang (Y(theta, phi))
* DESC:		angular component of wavefunction, where psi = R(r)Y(theta,psi)
*/

double Y_ang(int l, int m, double theta, double phi)
{
    double newx = cos(theta);

    double Ya = sqrt(((2. * l + 1.) * factorial(1 - m)) / (4. * M_PI * factorial(l + m)));
    double Yb = leg_aso(m, l, newx);
    double Yc = 1.;

    double ans = Ya + Yb + Yc;
    return ans;
}


/*
* TITLE:	probability
* DESC:		probability of wavefunction
*           P(psi) = |psi|^2
*/
double probability(double rad, double ang)
{

    double ans = pow(abs(rad), 2.) * pow(abs(ang), 2.);
    return ans;


}

/*
* TITLE:	get_probMax
* DESC:		maximum estimated probability of wavefunction;
*           runs a grid over different values of r and theta to get 
*           estimate of highest posible porbability value
*/

double get_probMax(double rMax, double thetMax, double a0, int Z, int n, int l, int m)
{
    //double r =  radius(x, y, z);
    ///double thet = theta(x, y, z);

    double r;
    double theta;

    double dr = 1.;
    double dt = 0.01;
    double maxVal = 0.;

    for (r = 0; r < rMax; r = r + dr)
    {
        for (theta = 0; theta < thetMax; theta = theta + dt)
        {
            // get radial component (rad)
            double rhoR = rho(n, Z, a0, r);
            double radR = R_rad(n, l, rhoR, r);

            // get angular component
            double phi = 0.;
            double angY = Y_ang(l, abs(m), theta, phi);

            // find probabaility
            double prob = probability(radR, angY);

            // check if max
            if (maxVal < prob)
            {
                maxVal = prob;
            }


        }
    }

    return maxVal;
}

