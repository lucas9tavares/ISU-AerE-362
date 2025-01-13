clear;
clc;
close all;

% Generating a meshgrid for the x1-x2 plane, ranging from -10 to 10 with steps of 0.2.
[x1, x2] = meshgrid(-10:0.2:10, -10:0.2:10); % In Python: -10:10:0.2

% Defining the objective function f.
% using dot . before math operators for element-wise operation within
% matrics
f = 2*(x1 - 1).^2 + 3*(x2 - 2).^2;

% Plotting the objective function's contour.
c_levels = 0:10:100; % These are the contour levels for the objective function.
fc = contour(x1, x2, f, c_levels, "k"); % "k" specifies the color black for contours.
clabel(fc); % Adding labels to the contour lines.

% Defining the constraints g1 and g2.
g1 = x1 - x2;
g2 = x2;

% Plotting constraints.
hold on; % Retaining the current plot so that new plots can be added on top of it.

% create an array of values from 0 to 1, where the interval between each value is 0.05. 
infeasible_levels = 0:0.05:1;
% Plotting the first constraint g1.
contour(x1, x2, g1, [0 0], 'r', 'Linewidth', 5); % The constraint line g1 = 0.
contour(x1, x2, g1, infeasible_levels, 'c'); % Other levels of g1 in cyan to show infeasible regions.
% Plotting the second constraint g2.
contour(x1, x2, g2, [0 0], 'k', 'Linewidth', 5); % The constraint line g2 = 0.
contour(x1, x2, g2, infeasible_levels, 'c'); % Other levels of g2 in cyan to show infeasible regions.

% Adding annotations to the plot for clarity.
text(9, 9, "g1", "FontSize", 10); % Labeling constraint g1.
text(-9, -1, "g2", "FontSize", 10); % Labeling constraint g2.
plot(1, 2, 'rx'); % Marking the point (1, 2) with a red 'x'.
text(-8, -2.5, "Feasible", "FontSize", 10); % Indicating the feasible region.

% Labeling the axes and adding a title to the plot.
xlabel('x1');
ylabel('x2');
title('The contour plots of f=2*(x1-1)^2+3*(x2-2)^2');
