% AerE 362, Homework 4 Problem 3, Lucas Tavares

clear; close all; clc;

rng default

%% ------------------- Part 1. Data Loading and Preprocessing -------------------
% Load data from current folder
data = readtable('AirfoilSelfNoise.csv');

% Here we rename columns
data.Properties.VariableNames = {'Frequency', 'Angle_of_attack', 'Chord_length', ...
    'Free_stream_velocity', 'Section_side_displacement_thickness', 'Scaled_Sound_Pressure_Level'};

% Randomize data to avoid any biased patterns
data = data(randperm(height(data)), :);

% Display basic statistical information
summary(data);

%% ------------------- Part 2. Data Visualization -------------------
% Univariate distribution plots
figure;
subplot(3,2,1);
histogram(data.Frequency, 'Normalization', 'pdf');
title('Frequency Distribution');

subplot(3,2,2);
histogram(data.Angle_of_attack, 'Normalization', 'pdf');
title('Angle of Attack Distribution');

subplot(3,2,3);
histogram(data.Chord_length, 'Normalization', 'pdf');
title('Chord Length Distribution');

subplot(3,2,4);
histogram(data.Free_stream_velocity, 'Normalization', 'pdf');
title('Free Stream Velocity Distribution');

subplot(3,2,5);
histogram(data.Section_side_displacement_thickness, 'Normalization', 'pdf');
title('Section Side Displacement Thickness');

subplot(3,2,6);
histogram(data.Scaled_Sound_Pressure_Level, 'Normalization', 'pdf');
title('Scaled Sound Pressure Level Distribution');

%% ------------------- Part 3. Correlation Analysis and Heatmap -------------------
% Extract numerical data for correlation analysis
numericalData = [data.Frequency, data.Chord_length, data.Free_stream_velocity, ...
                 data.Angle_of_attack, data.Section_side_displacement_thickness, data.Scaled_Sound_Pressure_Level];

% Calculate correlation matrix
correlationMatrix = corr(numericalData);

% Plot correlation heatmap
figure;
heatmap({'Frequency', 'Chord Length', 'Free-stream Velocity', 'Angle of Attack', ...
    'Section Side Displacement Thickness', 'Scaled Sound Pressure Level'}, ...
    {'Frequency', 'Chord Length', 'Free-stream Velocity', 'Angle of Attack', ...
    'Section Side Displacement Thickness', 'Scaled Sound Pressure Level'}, ...
    correlationMatrix, 'ColorMap', parula, 'Title', 'Correlation Heatmap');

%% ------------------- Part 4. ML Model Training -------------------
% This part will begin model training.
x = [data.Frequency, data.Angle_of_attack, data.Chord_length, data.Free_stream_velocity, data.Section_side_displacement_thickness];
y = data.Scaled_Sound_Pressure_Level;

% Split data into training (80%) and test sets (20%)
cv = cvpartition(size(x,1),'HoldOut',0.2);
xTrain = x(training(cv), :);
xTest = x(test(cv), :);
yTrain = y(training(cv), :);
yTest = y(test(cv), :);

% Normalize the training data
[xTrainNorm, mu, sigma] = normalize(xTrain);

% Normalize the test data using the training set's statistics
XTestNorm = (xTest - mu) ./ sigma;

% Train the neural network by adjusting the hyperparameters
% net = feedforwardnet([8, 5]);  % Using two layers with 8, 5 neurons respectively (b)
net = feedforwardnet([10, 20, 5, 5]);  % Using two layers with 10, 20, 5, 5 neurons respectively (c)
net = configure(net, xTrainNorm', yTrain');
net.trainFcn = 'trainbfg'; % Use BFGS Quasi-Newton
net.trainParam.epochs = 1000;  % Set the number of epochs

% Train the neural network
net = train(net, xTrainNorm', yTrain');

% Predict on test data
yPredANN = net(XTestNorm')';

%% ------------------- Part 5. Evaluate Model Predcition Performance ------------------- 
% Calculate MSE and R2 for ANN model; finish the calculation code

% mse = perform(net,yPredANN, yTest);
mse = mean((yTest - yPredANN).^2);
disp(['MSE (ANN): ', num2str(mse)]);

% Calculate R² (R-squared) for ANN model
r2 = 1 - sum((yTest - yPredANN).^2) / sum((yTest - mean(yTest)).^2);
disp(['R² (ANN): ', num2str(r2)]);

%% ------------------- Part 6. Plot actual vs predicted values -------------------
figure;
plot(yTest, 'b', 'DisplayName', 'Actual Values');
hold on;
plot(yPredANN, 'r', 'DisplayName', 'Predicted Values');
legend;
title('Actual vs Predicted Scaled Sound Pressure Level');
xlabel('Test Data Index');
ylabel('Scaled Sound Pressure Level');

% Visualize the error
figure;
scatter(yTest, yPredANN);
xlabel('Actual Scaled Sound Pressure Level');
ylabel('Predicted Scaled Sound Pressure Level');
title('Actual vs Predicted (Scatter Plot)');
hold on
plot(min(yTest):max(yTest),min(yTest):max(yTest))

% Calculate the error %
errors = (abs(yPredANN - yTest) ./ yTest ) .* 100;
fprintf('Average Error %% (c): %.2f%% \n\n', mean(errors))
