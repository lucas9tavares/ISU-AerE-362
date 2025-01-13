function [c,ceq] = nlConstraint(x)

theta(1) = x(1);
theta(2) = x(2);

t(1) = x(3);
t(2) = x(4);

dt(1) = x(5);
dt(2) = x(6);

gammat(1) = x(7);
gammat(2) = x(8);

d = struct_component(theta, t, gammat);
sigma = stress_component(d);

gamma = aero_component(theta, dt);
[D,L] = force_component(theta, gamma);

c(1) = sigma - 1;
ceq(1) = L - 1;
ceq(2) = gamma(1) - gammat(1);
ceq(3) = gamma(2) - gammat(2);
ceq(4) = d(1) - dt(1);
ceq(5) = d(2) - dt(2);

end