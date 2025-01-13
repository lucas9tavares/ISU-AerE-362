% example fmincon run script
clear variables;
close all;

% objective function name
func='objFunc';
nlConstraint='nlConstraint';
% Initial point x0
x0=[0.1;0.1;1;1;0;0;0;0];

% setup the optimizer options. No need to change.
% NOTE: sqp: Sequential quadratic programming, which is an iterative
% optimization algorithm using the quasi-Newton method with
% Lagrangian multipliers
options=optimoptions('fmincon','Display','iter','Algorithm','sqp');

% Call the fmincon function to start the optimization
[xOpt,fOpt,exitflag,output,lambda]=fmincon(func,x0,[],[],[],[],[],[],nlConstraint,options);

xOpt
fOpt
