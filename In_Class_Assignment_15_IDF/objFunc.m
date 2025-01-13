function f = objFunc(x)

theta(1) = x(1);
theta(2) = x(2);

t(1) = x(3);
t(2) = x(4);

dt(1) = x(5);
dt(2) = x(6);

gammat(1) = x(7);
gammat(2) = x(8);

gamma = aero_component(theta, dt);
[D,L] = force_component(theta, gamma);

f=D;

end