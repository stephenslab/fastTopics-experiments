/*
 *  This file was downloaded from http://www.cs.utexas.edu/~cjhsieh/nmf.
 *  See the COPYRIGHT file for information about redistribution.
 * 
 *  Usage: [W H objKL timeKL] = ccd_KL(V, k, max_iter, Winit, Hinit, trace);
 *
 * Given the nonnegative input matrix V, this code solves the following KL-NMF problem to find the low-rank approximation WH for V. 
 *
 *  min_{W>=0,H>=0} sum_{i,j} V_{ij}*log(V_{ij}/(WH)_{ij})
 *
 *  Input arguments
 *  	V: n by m nonnegative input matrix.
 *  	k: rank of output matrices W and H. 
 *  	max_iter: maximum iteration. 
 *  	Winit: k by n initial matrix for W. 
 *  	Hinit: k by m initial matrix for H. 
 *  	trace: 1: compute objective value per iteration. 
 *  		   0: do not compute objective value per iteration. (default)
 *
 *  Output arguments
 *  	W: k by n dense matrix.
 *  	H: k by m dense matrix.
 *  	objKL: objective values.
 *  	timeKL: time taken by this algorithm. 
 *
 * Downloaded from 
 */

#include "math.h"
#include "mex.h" 
#include <time.h>

double obj(int n, int m, double *V, double *WH)
{
	double total = 0;
	for ( int i=0 ; i<n*m ; i++ )
		total = total + V[i]*log((V[i]+1e-5)/(WH[i]+1e-5))-V[i]+WH[i];
	return (total);
}

void update(int m, int k, double *Wt, double *WHt, double *Vt, double *H)
{
	int maxinner = 1;
	for ( int q=0 ; q<k ; q++ )
	{
		for (int inneriter =0 ; inneriter<maxinner ; inneriter++)
		{
			double g=0, h=0, tmp, s, oldW, newW, diff;
			for (int j=0, hind=q ; j<m ; j++, hind+=k )
			{	
				tmp = (Vt[j])/(WHt[j]+1e-10);
				g = g + H[hind]*(1-tmp); // 1-V/WH
				h = h + H[hind]*H[hind]*tmp/(WHt[j]+1e-10);    //V/WH^2
			}
			s = -g/h;
			oldW = Wt[q];
			newW = Wt[q]+s;
			if ( newW < 1e-15)
				newW = 1e-15;
			diff = newW-oldW;
			Wt[q] = newW;
			for ( int j=0 ; j<m ; j++)
				WHt[j] = WHt[j]+diff*H[j*k+q];
			if ( fabs(diff) < fabs(oldW)*0.5 )
				break;
		}
	}
}

int newKL(int n, int m, int k, int maxiter, double *V, double *W, double *H, int trace, double *objlist, double *timelist)
{
	char matlab_output[1024];
	double total = 0, begin;
	double *WH = (double *)malloc(sizeof(double)*n*m);

	// temp arrays when updating variables in W (since V and WH are stored in column format)
	double *WHt = (double *)malloc(sizeof(double)*m); 
	double *Vt = (double *)malloc(sizeof(double)*m);

	begin = clock();
	for ( int i=0, ind=0 ; i<m ; i++ )
		for ( int j=0 ; j<n ; j++, ind++ )
		{
			WH[ind] = 0;
			int indw = j*k, indh = i*k;
			for (int r=0 ; r<k ; r++ )
				WH[ind] += W[indw+r]*H[indh+r];
		}
	total = (clock()-begin)/CLOCKS_PER_SEC;

	for ( int iter=0 ; iter<maxiter ; iter++)
	{
		double begin = clock();

		// Update W
		for ( int i=0 ; i<n ; i++)
		{
			double  *Wt = &(W[i*k]);
			for ( int j=0 ; j<m ; j++ )
			{
				WHt[j] = WH[j*n+i];
				Vt[j] = V[j*n+i];
			}
			update(m, k, Wt, WHt, Vt, H);
			for ( int j=0 ; j<m ; j++ )
				WH[j*n+i] = WHt[j];
		}

		// Update H
		for ( int i=0 ; i<m ; i++ )
		{
			double *Ht = &(H[i*k]);
			double *wht = &(WH[i*n]);
			double *vt = &(V[i*n]);

			update(n,k,Ht,wht,vt,W);
		}

		if ( trace == 1 ) 
		{
			total += (clock()-begin)/CLOCKS_PER_SEC;
			timelist[iter] = total;
			objlist[iter] = obj(n,m,V,WH);
			// printf will not flush the output buffer
			sprintf(matlab_output, "display('Iteration %d Objective: %lf Time taken: %lf');", iter, objlist[iter], timelist[iter]);
			mexEvalString(matlab_output);
		}
		else {
			sprintf(matlab_output, "display('Iteration %d')", iter);
			mexEvalString(matlab_output);
		}
	}

	free(WH);
	free(WHt);
	free(Vt);
}

void usage()
{
	printf("Error calling KL_NMF.\n");
	printf("Usage: [W H objKL timeKL] = ccd_KL(V, k, max_iter, Winit, Hinit, trace=0)\n");
}

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{
	double *xValues;
	int i,j;
	double avg;
	double *V, *W, *H;
	double *timelist = NULL, *objlist = NULL;

	int n,m, k, maxiter;
	int trace = 0;
	double *outArray;

	// Check input/output number of arguments
	if ( nlhs > 4 || nrhs != 6 )
	{
		usage();
		printf("Number of input or output arguments are not correct.\n");
		return;
	}

	V = mxGetPr(prhs[0]);
	n = mxGetM(prhs[0]);
	m = mxGetN(prhs[0]);

	k = mxGetScalar(prhs[1]);
	maxiter = mxGetScalar(prhs[2]);

	W = mxGetPr(prhs[3]);
	if ( mxGetM(prhs[3]) != k || mxGetN(prhs[3])!=n ) {
		usage();
		printf("Error: Winit should be a %d by %d matrix. \n", k, n);
		return;
	}

	H = mxGetPr(prhs[4]);
	if ( mxGetM(prhs[4]) != k || mxGetN(prhs[4])!=m ) {
		usage();
		printf("Error: Hinit should be a %d by %d matrix. \n", k, m);
		return;
	}
	
	if ( nrhs>5 )
		trace = mxGetScalar(prhs[5]);

	if ( trace==0 && nlhs >2 )
	{
		usage();
		printf("Error: only 2 output matrices (W, H) when trace = 0.\n");
		return;
	}

	if ( trace==1 )
	{
		plhs[2] = mxCreateDoubleMatrix(1,maxiter,mxREAL);
		objlist = mxGetPr(plhs[2]);
		plhs[3] = mxCreateDoubleMatrix(1,maxiter,mxREAL);
		timelist = mxGetPr(plhs[3]);
	}

	newKL(n,m, k,maxiter,V,W,H, trace, objlist, timelist);

	plhs[0] = mxCreateDoubleMatrix(k,n,mxREAL);
	outArray=mxGetPr(plhs[0]);
	for ( i=0 ; i<k*n ; i++ )
		outArray[i] = W[i];
	plhs[1] = mxCreateDoubleMatrix(k,m,mxREAL);
	outArray=mxGetPr(plhs[1]);
	for ( i=0 ; i<k*m ; i++ )
		outArray[i] = H[i];

	return;
}
