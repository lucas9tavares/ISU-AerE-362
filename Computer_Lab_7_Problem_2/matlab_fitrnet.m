clc
clear 
close all

% sample points. The x is the input [Mt, Rt] and y is the output Dt
x=[0.92 0.42; 0.42 0.92; 0.58 0.25; 0.8 0.8; 0.25 0.58; 0.75 0.75];
y=[1.2088; 1.1088; 1.1289; 1.4468; 1.0629; 1.0850];

% train the neural network model with 3 layers [2 2 1]
% the input layer has 2 neurons, the hiden layer has 2 neuron
% and the output layer has one neron
Mdl = fitrnet(x,y,"LayerSizes",[2 2 1], ...
              "Activations","sigmoid", ...
              "Standardize",false);

% now, we can use the trained model to predict D at any M and R
% here is an example of predicting [M, R] = [0.92 0.42]
yfit = predict(Mdl,[0.92 0.42]);

% we can also show the weights for the neural network model
w=Mdl.LayerWeights{2};


% Plot the Predicted Dt vs true Dt
figure;
testPredictions = predict(Mdl,x);
plot(y,testPredictions,"o")
xlabel("True Dt")
ylabel("Predicted Dt")

hold on
m = [1:0.02:1.5];
plot(m, m) % plot the slop y = x to show the slop trend
hold off