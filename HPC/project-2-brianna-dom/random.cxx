#include <random>
#include <iostream>

//We can delete this later.  Using this script to test randomization.  Copied in functions.cxx
 
int main()
{
    std::random_device rd;  //Get seed for random generator to use
    std::mt19937 rand(rd()); //Randomization engine
    std::uniform_real_distribution<> dis(3.0, 800);  //Produce uniform distribution 
    
    
    for (int n = 0; n < 10; ++n) {
        std::cout <<"x =  " << dis(rand) << " \n";
        std::cout <<"y =  " << dis(rand) << " \n";
        std::cout <<"z =  " << dis(rand) << " \n\n\n";
    }
}
