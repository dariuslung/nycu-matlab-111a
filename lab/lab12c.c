#include "mex.h"
#include "matrix.h"

void foo(long* C, double* A, double* B, int n, int numIntervals) {
    // mexPrintf("n = %d, numIntervals = %d", n, numIntervals);
    for (int i = 0; i < n; i++) {
        C[i] = 0;
        for (int j = 0; j < numIntervals; j++) {
            int index = j * 2; // Linear index
            if (B[index] <= A[i] && A[i] < B[index+1]) {
                C[i] = j+1;
                break;
            }
        }
    }
}

void mexFunction(   int nlhs, mxArray *plhs[], // OUTPUT
                    int nrhs, const mxArray *prhs[] // INPUT
                ) {
    if (nlhs != 1 || nrhs != 2) {
        mexErrMsgTxt("USAGE: C = lab12m(A, B)");
    }
    // Input
    // mexPrintf("INTO INPUT\n");
    double *A = mxGetPr(prhs[0]);
    double *B = mxGetPr(prhs[1]);
    // Output
    // mexPrintf("INTO OUTPUT\n");
    plhs[0] = mxCreateNumericMatrix(mxGetM(prhs[0]), mxGetN(prhs[0]), mxINT32_CLASS, mxREAL);
    long *C = mxGetPr(plhs[0]);
    // // Others
    // mexPrintf("INTO OTHERS\n");
    int n = mxGetNumberOfElements(prhs[0]);
    int numIntervals = mxGetM(prhs[1]);
    if (mxGetN(prhs[1]) != 2) {
        mexErrMsgTxt("ERROR: B must have 2 columns");
    }
    // mexPrintf("INTO PROCESSING\n");
    foo(C, A, B, n, numIntervals);
}