% AerE 361, Homework 1, Lucas Tavares

clear;
clc;
close all;


%%%%%%%%%% Problem 1 %%%%%%%%%%

% 1.1) Optimum design problem for minimum cross-sectional area S:
% 
% Design variables: d (depth) and b (width)
% 
% Known values:
% 
%     Maximum bending moment: 127 kN*m
%     Maximum shear: 400 kN
%     Allowable bending stress: 213 MPa
%     Allowable shearing stress:  56 MPa
% 
% Problem constrains:
% 
%     0.1 cm < d < 50 cm
%     0.1 cm < b < 50 cm
% 
%     g1 = sigma = 5.3 * M_max / (b * d^2) <= sigma_a
%     g2 = tau = V_max / (b * d) <= tau_a
%     g3 = d <= 2 * b
% 
%     S = b * d
% 
% Objective: Minimize S (S will be minimal where b and d are minimal)
% 
% 1.2) Standard format:
% 
%     d - 2*b <= 0;
%     0.1 - d <= 0; % m
%     d - 50 <= 0; % m
%     0.1 - b <= 0; % m
%     b - 50 <= 0; % m
% 
%     g1 = 5.3 * M_max / (b * d^2) - sigma_a <= 0; % N/m^2
%     g2 = V_max / (b * d) - tau_a <= 0; % N/m^2
%     g3 = d - 2*b <= 0; % m
% 
%     S = b * d; % m^2

% 1.3) MATLAB code:

% Define known values
M_max = 12700000; % N*cm
V_max = 400000; % N
sigma_a = 21300; % N/cm^2
tau_a = 5600; % N/cm^2

% Generate meshgrid for the b and d plane
[b, d] = meshgrid(0.1:0.05:50, 0.1:0.05:50);

% Define the objective function
S = b .* d;

% Plot objective function's contour
c_levels = 0:100:1000;
fc = contour(b, d, S, c_levels, "k");
clabel(fc);

% Define constraints
g1 = 5.3 .* M_max ./ (b .* d.^2) - sigma_a;
g2 = V_max ./ (b .* d) - tau_a;
g3 = d - 2*b;

% Plot constraints
hold on;
infeasible_levels1 = 0:50:3000;
infeasible_levels2 = 0:0.05:3;

contour(b, d, g1, [0 0], 'r', 'Linewidth', 5);
contour(b, d, g1, infeasible_levels1, 'c');

contour(b, d, g2, [0 0], 'k', 'Linewidth', 5);
contour(b, d, g2, infeasible_levels1, 'c');

contour(b, d, g3, [0 0], 'k', 'Linewidth', 5);
contour(b, d, g3, infeasible_levels2, 'c');

% Annotate the contraint names and feasible region in the plot
text(35, 35, "Feasible", 'FontSize',13);
text(47, 10.5, "g1", 'FontSize',11);
text(47, 4, "g2", 'FontSize',11);
text(24, 47, "g3", 'FontSize',11);

xlabel('Width b (cm)')
ylabel('Depth d (cm)')
title('Contour Plots of Beam of Rectangular Cross-Section Problem')

% 1.4) Optimal design variable values are approximatelly:
% 
%     b = 10.1 cm
%     d = 18.85 cm
%     S = 190.385 cm^2
% 
% Constraints g1 and g3 are active, while g2 is inactive.


%%%%%%%%%% Problem 2 %%%%%%%%%%

% 2.1) Function f is nonlinear, since it includes a quadratic term (8 * x1^2) and a product term (-9 * x1 * x2).

% 2.2) MATLAB code:

% Define symbolic function
syms f(x1, x2)
f(x1, x2) = 8 * x1^2 - 9 * x1 * x2 + 10 * x2 + 7;

% Compute gradient
dfdx1 = diff(f, x1);
dfdx2 = diff(f, x2);

% Norm of gradient
norm = sqrt(dfdx1^2 + dfdx2^2);

% Input x* values
dfdx1_xstar = dfdx1(1, 3);
dfdx2_xstar = dfdx2(1, 3);
norm_xstar = norm(1, 3);

% Output results
fprintf('\n---------- Problem 2 ---------- \n\n')
fprintf('Gradient of f at x* = (1, 3):  [%.04f, %.04f] \n\n', dfdx1_xstar, dfdx2_xstar)
fprintf('Norm of gradient of f at x* = (1, 3):  %.04f \n\n\n\n', norm_xstar)

% Gradient of f at x* = (1, 3):  [-11.0000, 1.0000] 
% 
% Norm of gradient of f at x* = (1, 3):  11.0454


%%%%%%%%%% Problem 3 %%%%%%%%%%

fprintf('---------- Problem 3 ---------- \n\n')

% Define symbolic function
syms f(x1, x2)
f(x1, x2) = 7 * x1^2 - 2 * x1 * x2 - 8 * x2^2 + 19 * x2;

% Compute gradient
dfdx1 = diff(f, x1);
dfdx2 = diff(f, x2);

% Solve for stationary points
stationaryPoints = solve([dfdx1 == 0, dfdx2 == 0], [x1, x2]);

x1Opt = stationaryPoints.x1;
x2Opt = stationaryPoints.x2;

fprintf('Stationary points:  [%.04f, %.04f] \n\n', x1Opt, x2Opt);

% Compute the Hessian matrix

h11 = diff(dfdx1, x1);
h12 = diff(dfdx1, x2);
h21 = diff(dfdx2, x1);
h22 = diff(dfdx2, x2);

H = double([h11 h12; h21 h22]);

% Compute and analyze the eigenvalues of the Hessian

lambdas = eig(H);

fprintf('Eigenvalues of the Hessian are:  [%.04f, %.04f] \n\n', lambdas(1), lambdas(2))

if all(lambdas > 0)
    fprintf('The Hessian is positive definite. This point is a local minimum. \n\n')
else
    fprintf('The Hessian is not positive definite. The point is not a minimum. \n\n')
end

% 3.1) Stationary points:  [0.1667, 1.1667] 
% 
% 3.2) Eigenvalues of the Hessian are:  [-16.1327, 14.1327] 
% 
% The Hessian is not positive definite. The point is not a minimum. 
