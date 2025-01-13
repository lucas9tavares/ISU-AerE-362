% example fmincon run script
clear variables;
close all;
% clc

% objective function name
funcName='objFunc';
nlConName='nlCon';
% Initial point x0
x0=[0.1 0.1 5];

options=optimoptions('fmincon','Display','iter','Algorithm','sqp');

%%$ Write the optimization code below using fmincon

[x0pt, f0pt, exitflag, output, lambda] = fmincon(funcName, x0, [], [], [], [], [-2, -2, 0.1], [2, 1, 100], nlConName, options);

propagator(x0pt, 1); %Output plot
