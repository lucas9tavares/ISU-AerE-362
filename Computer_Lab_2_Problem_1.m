clear
clc

%% Step 1: Declare the symbolic function
syms f(x1, x2)
f(x1, x2) = x1^2 + 2*x2^2 - 4*x1 - 2*x1*x2;

%% Step 2: Compute the gradient (partial derivatives)
dfdx1 = diff(f, x1);
dfdx2 = diff(f, x2);

%% Step 3: Extract coefficients of the gradient for the A matrix and b vector
[C1, T1] = coeffs(dfdx1, [x1, x2], 'All');
[C2, T2] = coeffs(dfdx2, [x1, x2], 'All');

% Convert symbolic coefficients to numerical values
C1 = double(C1);
C2 = double(C2);

%% Step 4: Construct the system of equations A*x = b
a11 = C1(1,2);
a12 = C1(2,1);
a21 = C2(1,2);
a22 = C2(2,1);
b1 = -C1(2,2);
b2 = -C2(2,2);

A = [a11 a12; a21 a22];
b = [b1; b2];

%% Step 5: Solve for the stationary point (xOpt)
xOpt = A\b;

disp('The optimal point is:')
disp(xOpt)

%% Step 6: Compute the Hessian matrix
h11 = diff(dfdx1, x1);
h12 = diff(dfdx1, x2);
h21 = diff(dfdx2, x1);
h22 = diff(dfdx2, x2);

H = double([h11 h12; h21 h22]);

disp('Hessian matrix at the stationary point is:')
disp(H)

%% Step 7: Analyze the eigenvalues of the Hessian matrix
lambdas = eig(H);

disp('Eigenvalues of the Hessian are:')
disp(lambdas)

if all(lambdas > 0)
    disp('The Hessian is positive definite. This point is a local minimum.')
else
    disp('The Hessian is not positive definite. The point is not a minimum.')
end

%% Step 8: Compute the function value at the optimal point
fOpt = f(xOpt(1), xOpt(2));

disp('The optimal function value is:')
disp(double(fOpt))

%% Step 9: Visualize the function using a contour plot
[x1_grid, x2_grid] = meshgrid(-10:0.2:10, -10:0.2:10);
f_grid = x1_grid.^2 + 2*x2_grid.^2 - 4*x1_grid - 2*x1_grid.*x2_grid;

contour_levels = 0:10:100;
fc = contour(x1_grid, x2_grid, f_grid, contour_levels, 'k');
clabel(fc);
hold on;
plot(xOpt(1), xOpt(2), 'rx', 'MarkerSize', 10, 'LineWidth', 2);
title('Contour plot of the function with the optimal point marked');
xlabel('x_1');
ylabel('x_2');
grid on;
hold off;
