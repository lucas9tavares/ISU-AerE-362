function [gamma, residual_aero] = aero_component(theta, d, gamma_old)
A=[(theta(1)+d(1))^2+2 1;1 (theta(2)+d(2))^2+1];
b=[theta(1)+d(1); theta(2)+2*d(2)];
gamma = inv(A)*b;
residual_aero = A * gamma_old - b;
end