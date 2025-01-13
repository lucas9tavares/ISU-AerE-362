function c = objFuncDerivFD(x)
% calculate gradient using forward finite-difference
% df/dx1 = [f(x1+eps,x2) - f(x1,x2)]/eps
% df/dx2 = [f(x1,x2+eps) - f(x1,x2)]/eps

eps = 1e-5;
f = objFunc(x);

%% df/dx1
xP(1) = x(1) + eps;
xP(2) = x(2);
fP = objFunc(xP);
dfdx1 = (fP - f) / eps;

%% df/dx2
xP(1) = x(1);
xP(2) = x(2) + eps;
fP = objFunc(xP);
dfdx2 = (fP - f) / eps;

%% output gradient vector c

c = [dfdx1; dfdx2];

end
