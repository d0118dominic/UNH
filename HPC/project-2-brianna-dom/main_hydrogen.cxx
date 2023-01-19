using namespace std;
#define _USE_MATH_DEFINES
#include "hydrolib.h"

// atomic constants                 //
const double a0 = 0.52917721067;    // bohr radius (angstroms)
const int Z = 1;                    // atomic number

// set max quantum number n
int N = 5;

// number of points to plot
int pts = 1500;

// box dimensions
int dx = 50;
int dy = 50;
int dz = 0;

// cooridnate boundaries
double xbounds = dx/2.;
double ybounds = dy/2.;
double zbounds = dz/2.;

// declar arrays to hold data
vector<double> probdat(pts);
vector<double> rdat(pts);
vector<double> xdat(pts);
vector<double> ydat(pts);
vector<double> zdat(pts);

// loop runtime data
vector<double> rtimes;

// define struct to hold n,l,m values
struct Psi_nlm
{
    int n;
    int l;
    int m;	
};

int main(int argc, char** argv)
{
    // set timer for total runtime
    double T10 = Wtime();

    // mpi setup
    MPI_Init(&argc,&argv);
    int rank, size;
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    MPI_Comm_size(MPI_COMM_WORLD, &size);

    // mpi indices
    assert(pts % size == 0);
    int ib = rank*pts / size ;
    int ie = (rank + 1)*pts / size ;
    

    vector<Psi_nlm> psi;
    
    int indx = 0;

    // loop to get all values of n, l, m
    // for  n = [1, N]:
    //      l = [0, n - 1]
    //      m = 0

    for(int nx = 1; nx < N; nx++)
    {
        for(int lx = 0; lx < nx; lx++)
        {
                // add new struct element
                psi.push_back(Psi_nlm());

                // append n,l,m values to struct
                psi[indx].n = nx;
                psi[indx].l = lx;
                psi[indx].m = 0;  //mx;

                // update to next index
                indx++;
            }
    }
    

    vector<Psi_nlm> psi_range(psi.begin(), psi.end());
    for (const auto &qnum : psi_range)
    {
    
        int n = qnum.n;
        int l = qnum.l;
        int m = qnum.m;

        // // estimate upper limit
        double r_max = rmag(dx, dy, dz);
        double thet_max = theta(dx, dy, dz);
        double rho_max = Y_ang(l, abs(m), thet_max, 0);
        double rad_max = R_rad(n, l, rho_max, r_max);

        double Max = 1.2*get_probMax(r_max, M_PI, a0, Z, n, l, m);

        // set counter
        int i = ib;

        // set loop timer
        double T00 = Wtime();

        while(i < ie)
        {
            // generate random (x, y, z) coordinates
           double x = Randomize(-xbounds, xbounds);
           double y = Randomize(-ybounds, ybounds);
           double z = Randomize(-zbounds, zbounds);
           
           // get radius and theta values
           double r = radius(x, y, z);
           double thet = theta(x, y, z);
           //theta(x, y, z);

           //choose random value of probability within max range
           double w = Randomize(0, Max);

           // get radial component (rad)
           double rhoR = rho(n, Z, a0, r);
           double radR = R_rad(n, l, rhoR, r);

           // get angular component
           double phi = 0.;
           double angY = Y_ang(l, abs(m), thet, phi);

           // find probabaility
           double probPsi = probability(radR, angY);

            // check if random prob < calculated prob
            if(w <= probPsi)
            {
                // test; out of bounds check
                // assert(i < xdat.size());
                

                //Store Values
                probdat[i] = probPsi;
                rdat[i] = r;
                xdat[i] = x;
                ydat[i] = y;
                zdat[i] = z;

                i++;
            }

        }
        
        //cout << "PSI: " << pi << "\n";

        // collect runtime
        double T01 = Wtime();
        double runtime = T01 - T00;
        rtimes.push_back(runtime);

        // write data to file
        writetofile("data", n, l, m, pts, runtime, xdat, ydat, zdat, rdat, probdat);
        cout << "*";
    }

    int numfiles = rtimes.size();
    double avrg_runtime = vecAvrg(rtimes);


    // end timer for total runtime
    double T11 = Wtime();
    double tot_runtime = T11 - T10;

    // final output
    cout << "\n(" << numfiles <<") FILES CREATED... \n";
    cout << "POINTS = " << pts << "\t";
    cout << "AVERAGE RUNTIME = " << avrg_runtime << " s \t";
    cout << "TOTAL RUNTIME = " << tot_runtime << " s (" << tot_runtime/60. << " min) \n";

    MPI_Finalize();


    return 0;
}

