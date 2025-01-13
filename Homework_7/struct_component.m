function d = struct_component(theta, t, gamma)
K=[3*t(1)-2*theta(1) 1; 1 10*t(2)-3*theta(2)];
f=[9*gamma(1)^2; 2*gamma(2)^2];
d = inv(K)*f;
end