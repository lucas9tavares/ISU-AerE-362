function gamma = aero_component(theta, d)
A=[(6*theta(1)+2*d(1))^2+3 2;1 (5*theta(2)+2*d(2))^2+2];
b=[5*theta(1)+d(1); theta(2)+2*d(2)];
gamma = inv(A)*b;
end