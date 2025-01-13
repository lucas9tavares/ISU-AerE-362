function [c,ceq] = nlConstraint(x)

theta(1) = x(1);
theta(2) = x(2);

t(1) = x(3);
t(2) = x(4);

[gamma, d] = mda_solver(theta, t);
[D,L] = force_component(theta, gamma);
sigma = stress_component(d);

c(1) = sigma - 1;
ceq(1) = L - 1;


end