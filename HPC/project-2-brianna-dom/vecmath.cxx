using namespace std;
#include "hydrolib.h"

/*
*   get factorial of a number
*/
int factorial(int num)
{
    int ans = 1;

    // test for negative
    // assert(num >= 0);

    for(int i = 1; i <= num; ++i) 
    {
        ans *= i;
    }

    return ans;
}

/*
*   random number generation between interval [a,b]
*/
double Randomize(double a, double b)
{
    std::random_device rd;                              // get seed for random generator to use
    std::mt19937 generator(rd());                       // randomization engine
    std::uniform_real_distribution<double> distr(a, b); // produce uniform distribution

    double ans = distr(generator);
    return ans;    
}

/*
*   get avergae of elements inside of vector
*/
double vecAvrg(vector<double>& vec)
{   
    double avrg;
    double sum;

    // get vector size
    int vsize = vec.size();

    for (int i = 0; i < vsize; i++)
    {
        sum += vec[i];
    }

    avrg = sum / vsize;
    return avrg;
}
