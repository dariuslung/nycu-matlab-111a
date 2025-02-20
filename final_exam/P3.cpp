// ID: 109550194
// Name: 龍偉亮

#include "mex.h"
#include "matrix.h"

void foo(long* C, int n) {
    int f1 = 1;
    int f2 = 1;
    if (n == 1) {
        C[0] = f1;
    }
    else if (n == 2) {
        C[0] = f1;
        C[1] = f2;
    }
    else {
        C[0] = f1;
        C[1] = f2;
        for (int i = 2; i < n; i++) {
            mexPrintf("i = %d", i);
            C[i] = C[i-1] + C[i-2];
        }
    }   
}

void mexFunction(   int nlhs, mxArray *plhs[], // OUTPUT
                    int nrhs, const mxArray *prhs[] // INPUT
                ) {
    if (nlhs != 1 || nrhs != 1) {
        mexErrMsgTxt("USAGE: C = P3(n)");
    }
    // Input
    int n = mxGetScalar(prhs[0]);
    // Output
    if (n < 0) {
        mexErrMsgTxt("ERROR: n must be positive");
    }
    else if (n == 0) {
        plhs[0] = mxCreateNumericMatrix(1, 1, mxINT32_CLASS, mxREAL);
        long *C = (long *) mxGetPr(plhs[0]);
        C[0] = 0;
        return;
    }
    else plhs[0] = mxCreateNumericMatrix(1, n, mxINT32_CLASS, mxREAL);
    // Output
    long *C = (long *) mxGetPr(plhs[0]);
    // mexPrintf("INTO PROCESSING\n");
    foo(C, n);
}