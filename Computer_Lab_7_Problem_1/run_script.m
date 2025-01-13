clear;
clc;
close all;

% set the random number genereator
rng default

global Mt
global Rt
global Dt

x=lhsdesign(6, 2, 'smooth', 'off');
x=round(x,2);

Mt_original = x(:, 1);
Rt_original = x(:, 2);
Dt = (Mt_original - 0.5).^2 + (Rt_original - 0.6).^2 + 1;

% 
Mt = (Mt_original - mean(Mt_original)) / std(Mt_original);
Rt = (Rt_original - mean(Rt_original)) / std(Rt_original);

%figure(1)
%plot(Mt, Rt, 'ko')

options = optimoptions('fmincon', ...
                       'Display', 'iter', ...
                       'Algorithm', 'sqp', ...
                       'MaxIterations', 1e3, ... 
                       'MaxFunctionEvaluations', 1e3);

x0=randn(8,1);

[xOpt,fOpt]=fmincon("objFunc",x0,[],[],[],[],[],[],[],options);

w = xOpt(1:6);
b = xOpt(7:8);
% for i=1:6
%     w(i) = xOpt(i);
% end
% b(1) = xOpt(7);
% b(2) = xOpt(8);

D = nnModel(0.92, 0.42, w, b);

%% Plot the Predicted Dt vs true Dt
prediction_D = zeros(size(Dt));
for i = 1:length(Mt)
    prediction_D(i) = nnModel(Mt(i), Rt(i), w, b);
end

% Visualization
figure;
plot(Dt, prediction_D, 'o');
xlabel('True Dt');
ylabel('Predicted Dt');
hold on;
plot(min(Dt):0.01:max(Dt), min(Dt):0.01:max(Dt), '--'); 
hold off;

