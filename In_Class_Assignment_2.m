clear;
clc;
close all; % close all current figure 

%% Generate the meshgrid for the boundary D, H using "meshgrid"

[D, H] = meshgrid(3.5:0.045:8, 8:0.1:18); % fill the meshgrid function

%% Write the objective function

S = pi * D .* H + (pi * D.^2) ./ 2; % fill the objective function


%% plot the objective function

c_levels = 100:50:600;
fc = contour(D, H, S, c_levels, 'k');
clabel(fc);

%% Write constraints

V = 400 - (pi * D.^2 .* H) ./ 4; % fill the constraint equation

%% Plot constrains
hold on;

infeasible_levels = 0:1:10;
contour(D, H, V, [0,0], 'k', 'LineWidth', 5);
contour(D, H, V, infeasible_levels, 'c');

% Labeling the axes and adding a title to the plot.

text(7, 11, "g", "FontSize", 15); % Labeling constraint g1.

plot(8, 8, 'ro', 'MarkerSize', 12, 'MarkerFaceColor', 'r');   % identify the optimum point from the plot 

text(6.5, 14, "Feasible", 'FontSize',13);

xlabel('D');
ylabel('H');
title('The contour plots of the can design problem');
