% AerE 362, Homework 2, Lucas Tavares

clear;
clc;
close all;


%%%%%%%%%% Problem 1 %%%%%%%%%%

[x1, x2] = meshgrid(-10:0.2:10, -10:0.2:10);
sizeX = size(x1);
fC = x1;

x_0 = [-4, 3];
x_1 = [-2, 1];
x_2 = [-1.3, -0.4];
    
% Calculate function values for contour plot
for i = 1:sizeX(1)
    for j = 1:sizeX(2)
        fC(i, j) = 8*x1(i, j)^2 + 6*x1(i, j)*x2(i, j) +3*x2(i, j)^2 -2;
    end
end
    
% Plot the contour of the objective function
fc = contour(x1, x2, fC, 0:50:500, 'k');
clabel(fc)
hold on;

plot(x_0(1), x_0(2), 'ro', 'markerfacecolor', 'r')
plot(x_1(1), x_1(2), 'go', 'markerfacecolor', 'g')
plot(x_2(1), x_2(2), 'bo', 'markerfacecolor', 'b')
plot([x_0(1), x_1(1)], [x_0(2), x_1(2)], "--o");
plot([x_1(1), x_2(1)], [x_1(2), x_2(2)], "--o");

text(x_0(1) - 0.3, x_0(2) + 0.4, 'x0 = (-4, 3); f(x0) = 81');
text(x_1(1) - 0.3, x_1(2) + 0.4, 'x1 = (-2, 1); f(x1) = 21');
text(x_2(1) - 0.3, x_2(2) - 0.4, 'x2 = (-1.3, -0.4); f(x2) = 15.12');

xlim([-10 10]);
ylim([-10 10]);
xlabel('x1');
ylabel('x2');
set(gca, 'FontSize', 20, 'FontName', 'Times New Roman');
title("Objective Function Contour");


%%%%%%%%%% Problem 2 %%%%%%%%%%

% Gauss-Seidel formulation
% x^(k+1) = L^-1 * (b - T * x^k);

% Assign values for L, T, and b
L = [-14 0 0; -5 -12 0; 1 0 -2];
T = [0 -5 1; 0 0 0; 0 0 0];
b = [3; 0; 0];
A = [-14 -5 1; -5 -12 0; 1 0 -2];

x = [1; 1; 1];

for i=1:50
    disp("Gauss-Seidel iteration");
    disp(i);
    disp(x);
    % calculate the residual
    Res = A * x - b;
    ResNorm = norm(Res);
    disp("Residual Norm: ")
    disp(ResNorm)
    
    x = inv(L)*(b-T*x);
end


%%%%%%%%%% Problem 3 %%%%%%%%%%

% assign initial values for x
x = [1; 1];
b = [1; 3];

% main loop to solve the nonlinear eqn
for i = 1:10
    % update A
    A = [21*x(1) 6; ...
         6 2];
   
    disp("Direct method iteration")
    disp(i)
    Res = A*x-b;
    ResNorm = norm(Res);
    disp("Residual Norm:")
    disp(ResNorm);

    x = inv(A) * b
    
end