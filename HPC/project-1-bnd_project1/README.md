## README File for Project 1
### Links

* [LaTex Report document on Overleaf]() (view only)
* [Intmath sample ODE](https://www.intmath.com/differential-equations/12-runge-kutta-rk4-des.php) contains sample ODE and full numerical solution for testing RK4

### Project Overview

Goal: Write code to numerically integrate the 1D KdV equation via Runge-Kutta or other explicit method and parallelize code with OpenMP

Objectives: 
- Use git for version management and keeping history
- Use cmake and a makefile to build project
- Include tests, esp for RHS of KdV equation
- Use C++ (optional, but seems like the best place to start..)
- Submit report WITH plots
- Parallelize with OpenMP (near end of project after everything already works)
- Keep code well organized, structured, and consistent

The KdV Equation:
		du / dt + d^3 u / dx^3 + 6u * du / dx = 0



Discrete Derivatives:

We can consider delta(x) a constant value, so that
		 x_i = i*delta(x), where i = 0, 1, 2, ...   
	and	 u_i = u(x_i)

So the variables would look something like
		x[i] = i*delta(x)
		x[i+1] = (i+1)*delta(x) 
		...

The first spatial derivative of u (du / dx) can be expressed via finite difference approx
		[du/dx]_i = (u_i+1 - u_i-1) / 2*delta(x) 
	we divide by 2*delta(x) here because x[i+1] and x[i-1] are separated by 2*delta(x)

The second spatial derivative is d/dx (du/dx).  Approximations in the project documentation make it easier to express in terms of u
		[d^2u/dx^2]_i = (u_i+1 - 2*u_i + u_i-1) / (delta(x)^2)

The third spatial derivative is d/dx (d^2u/dx^2).  The form is similar to the first derivative example
		[d^3x/dx^3]_i = ([d^2u/dx^2]_i+1 - [d^2u/dx^2]_i-1) / 2*delta(x)

With these, we should be able to express the entire kdV equation in terms of u_i, delta(x) and the d/dt term.  

u'_j = (1/2*dx) * (u_j+1 - u_j-1)

u'''_j = (1/2*(dx)^3) * (u_j+2 + u_j-2 - 2 * (u_j+1 - u_j-1) 
 
------------------------------------------------------------------------------------------------------------------------------------



I tried defining the basic parameters of the problem; number of steps N, total length of box, timestep, lengthstep.  I defined u as an NxN null matrix to start where u_ij represents u at position i and time j.

I also included some in-line notes to explain my reasoning..






We can consider a matrix U_ij, where the rows (i) represent timesteps and the columns (j) represent the length steps
The first row of the matrix is the initial state of the system at all points: U_0j


With appropriate approximations of spatial derivatives, our method is:


	- [du/dt]_j = (1/2(dx^3)) * [ u_j+2 + u_j-2 - 2(u_j+1 - u_j-1) ]  +  (3*u_j /dx) * [u_j+1 - u_j-1] 
























