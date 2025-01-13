function T = thermo_component(t, theta, d, M)
A=[1/(t(1)+d(1)+theta(1)) 1;1 1/(t(2)+d(2)+theta(2))];
b=[M; M];
T = inv(A)*b;
end