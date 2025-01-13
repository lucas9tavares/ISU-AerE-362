function [d, residual_struct] = struct_component(theta, t, gamma, d_old)
K=[5*t(1)-theta(1) 2; 2 4*t(2)-theta(2)];
f=[2*gamma(1)^2; gamma(2)^2];
d = inv(K)*f;
residual_struct = K * d_old - f;
end