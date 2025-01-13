function f = objFunc(x)
dVtheta = x(1);
dVr = x(2);
tof = x(3);
w = 1;

%%% write the objective function to calculate deltaV as a function of x

deltaV = sqrt(dVtheta^2 + dVr^2);

f = w * deltaV + (1 - w) * tof;

end