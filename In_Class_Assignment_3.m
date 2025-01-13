clear
clc

%% Step 1: Define the symbolic function
syms f(x1, x2, x3)
f(x1, x2, x3) = exp(x1 + x2) + (x1 - 2)^2 + (x2 + 3)^2 + sin(x3);

%% Step 2: Compute the gradient (partial derivatives)
dfdx1 = diff(f, x1);
dfdx2 = diff(f, x2);
dfdx3 = diff(f, x3);

%% Step 3: Solve for stationary points (where the gradient is zero)
stationaryPoints = solve([dfdx1 == 0, dfdx2 == 0, dfdx3 == 0], [x1, x2, x3]);

x1Opt = stationaryPoints.x1;
x2Opt = stationaryPoints.x2;
x3Opt = stationaryPoints.x3;

disp('Symbolic stationary points:');
disp([x1Opt, x2Opt, x3Opt]);


%% Step 4: Compute the Hessian matrix
% You need to compute h11 h12 h13 h21 h22 h23 h31 h32 h33 and Hessian
% matrix H
h11 = diff(dfdx1, x1); 
h12 = diff(dfdx1, x2);
h13 = diff(dfdx1, x3);
h21 = diff(dfdx2, x1);
h22 = diff(dfdx2, x2);
h23 = diff(dfdx2, x3);
h31 = diff(dfdx3, x1);
h32 = diff(dfdx3, x2);
h33 = diff(dfdx3, x3);

H = [h11 h12 h13; h21 h22 h23; h31 h32 h33];

% Evaluate the Hessian matrix at the optimal point
HessianAtOpt = subs(H, {x1, x2, x3}, {x1Opt, x2Opt, x3Opt});
HessianAtOpt = double(HessianAtOpt);

disp('Hessian matrix at the optimal point:');
disp(HessianAtOpt);

%% Step 5: Check the eigenvalues of the Hessian to determine the nature of the stationary point
eigenvalues = eig(HessianAtOpt);

disp('Eigenvalues of the Hessian at the optimal point:');
disp(eigenvalues);

if all(eigenvalues > 0)
    disp('The Hessian is positive definite. This point is a local minimum.');
elseif all(eigenvalues < 0)
    disp('The Hessian is negative definite. This point is a local maximum.');
else
    disp('The Hessian is indefinite. This point is a saddle point.');
end

%% Step 6: Compute the optimal function value
fOpt = f(x1Opt, x2Opt, x3Opt);
disp('The optimal function value is:');
disp(double(fOpt));

%% Step 7: Visualization of the function over x1 and x2 (fixing x3 at its optimal value)
[x1_grid, x2_grid] = meshgrid(-5:0.1:5, -5:0.1:5);
x3_fixed = double(x3Opt);
f_grid = exp(x1_grid + x2_grid) + (x1_grid - 2).^2 + (x2_grid + 3).^2 + sin(x3_fixed);

contour_levels = 0:5:50;
contour(x1_grid, x2_grid, f_grid, contour_levels, 'k');
hold on;

plot(x1Opt, x2Opt, 'rx', 'MarkerSize', 10, 'LineWidth', 2);
title('Contour plot of the function with the optimal point (x_3 fixed)');
xlabel('x_1');
ylabel('x_2');
grid on;
hold off;
