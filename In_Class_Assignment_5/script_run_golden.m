% run script for golden section line search
clear variables;
close all;

% define input parameters
% initial design point
x0 = [-4 4];
% search direction
d = [0.640,-0.768];
% lower bound for the initial interval of uncertainty
alphaL=0;
% upper bound for the initial interval of uncertainty
alphaU=10;
% line search tolerance
tol=1e-4;
% maximal number of iteration for the line search
maxit=50;
% call the golden function to do the line search
[alphaMin,fMin,I,iter]=golden(x0,d,alphaL,alphaU,tol,maxit);

% plot results
plotLS(x0, d, alphaMin);