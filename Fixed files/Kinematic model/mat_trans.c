/* Version of the  03 February 2016 */
/* Information from .urdf of July 2015 */

#define TRUE 1
#define FALSE 0
#define NJoints 27
#define Real double
#include "mex.h"
#include <math.h>
#define pi 3.14159265358979323846
#define Set_Val_Matrix(Matrix, NRow, Row, Col, Value) *((Matrix) + ((Row)-1) + ((Col)-1)*NRow ) = (Value)


/* Geometric parameters */
#define d2 0.04519
#define d4 0.1029
#define d5 0.1
#define d11 -0.1
#define d12 -0.1029
#define d14 -0.04519
#define d27 0.030
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
#define r2 -0.095
#define r7  0.07071
#define r8  0.07071
#define r14 0.095
#define r15 -0.233
#define r17 0.105
#define r19 0.05595
#define r20 -0.037
#define r22 0.105
#define r24 0.05595
//#define r25 0.0265
#define r25 0.1615
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
//b
//#define ShoulderOffsetZ 0.1
//#define HipOffsetZ 0.085
//#define HipOffsetY 0.05
//B15,B20=sqrt(2)(ShoulderOffsetZ+HipOffsetZ-HipOffsetY)
#define b15 0.19091
#define b20 0.19091 
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
//gamma
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
//alpha

/* Headers */
void	mat_trans     (Real *, Real *);

/* Utilities */
void	Zeros                    (Real *, int, int);


/* Global variables */


/* Interface function: This function will be called as:
 
[T] = mat_trans( Q );
 
 */
void mexFunction( int nlhs, mxArray *plhs[],int nrhs, const mxArray *prhs[] )
{
Real Zeros_3x1[] = {0,0,0};
Real *Q;
Real *T;
/* Check for proper number of arguments */

/* Getting input arguments */
Q           = mxGetPr(prhs[0]);

    
/* Memory allocation for output arguments */
plhs[0]     = mxCreateDoubleMatrix(4*NJoints,4, mxREAL);
T      = mxGetPr(plhs[0]);


/* Calcul des matrices de transformation */
mat_trans( Q , T );
}


void mat_trans(Real *Q, Real *T)
{
int j; 
int im;
/* Geometric parameters */
Real gam [27] =   {pi/2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,pi/2}; // 
Real b [27] =     {0,0,0,0,0,0,0,0,0,0,0,0,0,0,b15,0,0,0,0,b20,0,0,0,0,0,0,0};
Real r [27] =     {0,r2,0,0,0,0,r7,r8,0,0,0,0,0,r14,r15,0,r17,0,r19,r20,0,r22,0,r24,r25,0,0};
Real d [27] =     {0,d2,0,d4,d5,0,0,0,0,0,d11,d12,0,d14,0,0,0,0,0,0,0,0,0,0,0,0,d27};
Real alpha [27] = {pi/2,0,pi/2,0,0,-pi/2,pi/2,-pi/2,-pi/2,pi/2,0,0,-pi/2,0,-pi/4,pi/2,pi/2,-pi/2,pi/2,-pi/4,pi/2,pi/2,-pi/2,pi/2,pi/4,-pi/2,0};

/* Transformations */
Zeros(T,NJoints*4,4);
im=1;
for (j = 0 ; j < NJoints ; j++){
     Set_Val_Matrix(T,NJoints*4,im,1,cos(gam[j])*cos(Q[j])-sin(gam[j])*cos(alpha[j])*sin(Q[j])); 
     Set_Val_Matrix(T,NJoints*4,im,2,-cos(gam[j])*sin(Q[j])-sin(gam[j])*cos(alpha[j])*cos(Q[j]));
     Set_Val_Matrix(T,NJoints*4,im,3,sin(gam[j])*sin(alpha[j]));
     Set_Val_Matrix(T,NJoints*4,im,4,d[j]*cos(gam[j])+r[j]*sin(gam[j])*sin(alpha[j])); 
     Set_Val_Matrix(T,NJoints*4,im+1,1,sin(gam[j])*cos(Q[j])+cos(gam[j])*cos(alpha[j])*sin(Q[j]));  
     Set_Val_Matrix(T,NJoints*4,im+1,2,-sin(gam[j])*sin(Q[j])+cos(gam[j])*cos(alpha[j])*cos(Q[j]));
     Set_Val_Matrix(T,NJoints*4,im+1,3,-cos(gam[j])*sin(alpha[j]));
     Set_Val_Matrix(T,NJoints*4,im+1,4,d[j]*sin(gam[j])-r[j]*cos(gam[j])*sin(alpha[j]));
     Set_Val_Matrix(T,NJoints*4,im+2,1,sin(alpha[j])*sin(Q[j]));
     Set_Val_Matrix(T,NJoints*4,im+2,2,sin(alpha[j])*cos(Q[j]));
     Set_Val_Matrix(T,NJoints*4,im+2,3,cos(alpha[j]));
     Set_Val_Matrix(T,NJoints*4,im+2,4,r[j]*cos(alpha[j])+b[j]);
     Set_Val_Matrix(T,NJoints*4,im+3,4,1);  
     im=im+4;
     
 }                 
}

/* Creates a "Rows" by "Cols" zero matrix */
void Zeros(Real *Matrix, int Rows, int Cols )
{
  int i;
  for(i=1; i <= Rows * Cols; i++)
        *Matrix++ = 0;
}





