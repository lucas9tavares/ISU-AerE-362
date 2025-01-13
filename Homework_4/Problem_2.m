% AerE 362, Homework 4 Problem 2, Lucas Tavares

clear, clc, close all

%% Problem 2

fprintf('\n --------------- Problem 2 -------------- \n\n')

% (a)

fprintf('Part (a) \n\n')

% Generate sample points
rng default
X = lhsdesign(50,2);

Mt = X(:, 1);
Rt = X(:, 2);

% Calculate Dt from Mt and Rt
Dt = (Mt - 0.2).^2 + (Rt - 0.3) + 1;

% Create table to show Mt, Rt, and Dt values
valuesTable = table(Mt, Rt, Dt, 'VariableNames', {'Mach Number', 'Reynolds Number', 'Drag Force'});
disp(valuesTable)

% Plot the distribution of sample points in the design space
figure;
scatter(Mt, Rt, 50, Dt, 'filled');
colorbar;
xlabel('Mach Number (M_t)');
ylabel('Reynolds Number (R_t)');
title('Distribution of Sample Points in Design Space');
subtitle('Drag Force value colored')
grid on;

% (b)

fprintf('Part (b) \n\n')

% Train neural network
Mdl = fitrnet(X, Dt, "LayerSizes", [2 3 1], "Activations", "sigmoid", "Standardize", false);

% Predict the drag force
Dt_pred = predict(Mdl, X);

% Calculate the error %
errors = (abs(Dt_pred - Dt) ./ Dt ) .* 100;

% Plot: actual drag vs predicted drag
figure;
scatter(Dt, Dt_pred, 50);
hold on;
plot([min(Dt) max(Dt)], [min(Dt) max(Dt)]);
xlabel('Actual Drag Force');
ylabel('Predicted Drag Force');
title('Actual vs Predicted Drag Force (Part (b))');
grid on;
legend('Predicted Points', 'Ideal Prediction (y=x)', 'Location', 'best');
hold off;

% % Table comparing actual and predicted drag
% resultsTable = table(Dt, Dt_pred, errors, 'VariableNames', {'Actual Drag', 'Predicted Drag', 'Error %'});
% disp(resultsTable);

fprintf('Average Error %%: %.2f%% \n\n', mean(errors))

% (c)

fprintf('Part (c) \n\n')

% Train neural network
Mdl2 = fitrnet(X, Dt, "LayerSizes", [2 10 20 1], "Activations", "sigmoid", "Standardize", false);

% Predict the drag force
Dt_pred2 = predict(Mdl2, X);

% Calculate the error %
errors2 = (abs(Dt_pred2 - Dt) ./ Dt ) .* 100;

% Plot: actual drag vs predicted drag
figure;
scatter(Dt, Dt_pred2, 50);
hold on;
plot([min(Dt) max(Dt)], [min(Dt) max(Dt)]);
xlabel('Actual Drag Force');
ylabel('Predicted Drag Force');
title('Actual vs Predicted Drag Force (Part (c))');
grid on;
legend('Predicted Points', 'Ideal Prediction (y=x)', 'Location', 'best');
hold off;

% % Table comparing predicted drag from (b) and (c)
% resultsTable2 = table(Dt, Dt_pred, errors, Dt_pred2, errors2, 'VariableNames', {'Actual Drag', 'Predicted Drag (b)', 'Error % (b)', 'Predicted Drag (c)', 'Error % (c)'});
% disp(resultsTable2);

fprintf('Average Error %% (c): %.2f%% \n\n', mean(errors2))
