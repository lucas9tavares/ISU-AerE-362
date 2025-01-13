function H = objFuncHessianFD(x)
% calculate Hessian using central finite-difference
% d^2f/dx1^2 = [f(x1+eps,x2) - 2*f(x1,x2) + f(x1-eps,x2)]/(eps*eps)
% d^2f/dx2^2 = [f(x1,x2-eps) - 2*f(x1,x2) + f(x1,x2+eps)]/(eps*eps)
% d^2f/dx1dx2 = [f(x1+eps,x2+eps) - f(x1+eps,x2-eps) - f(x1-eps, x2+eps) + f(x1-eps, x2-eps)]/(4*eps*eps)

eps = 1e-5;
f = objFunc(x);

%% d^2f/dx1^2 or H(1,1)
xP(1) = x(1) + eps;
xP(2) = x(2);
fA = objFunc(xP);

xP(1) = x(1) - eps;
xP(2) = x(2);
fB = objFunc(xP);

H11 = (fA - 2*f + fB)/eps/eps;

%% d^2f/dx2^2 or H(2,2)
xP(1) = x(1);
xP(2) = x(2) - eps;
fA = objFunc(xP);

xP(1) = x(1);
xP(2) = x(2) + eps;
fB = objFunc(xP);

H22 = (fA - 2*f + fB)/eps/eps;


%% d^2f/dx1dx2 or H(1,2)/H(2,1)
xP(1) = x(1) + eps;
xP(2) = x(2) + eps;
fA = objFunc(xP);

xP(1) = x(1) + eps;
xP(2) = x(2) - eps;
fB = objFunc(xP);

xP(1) = x(1) - eps;
xP(2) = x(2) + eps;
fC = objFunc(xP);

xP(1) = x(1) - eps;
xP(2) = x(2) - eps;
fD = objFunc(xP);

H21 = (fA - fB - fC + fD)/(4*eps*eps);

%% symmetry

H12 = H21;

%% output Hessian matrix H

H = [H11 H12; H21 H22];

end
