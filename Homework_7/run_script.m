% example fmincon run script
clear variables;
close all;

% objective function name
func='objFunc';
nlConstraint='nlConstraint';
% Initial point x0
x0=[1;2;1;1];

% setup the optimizer options. No need to change.
% NOTE: sqp: Sequential quadratic programming, which is an iterative
% optimization algorithm using the quasi-Newton method with
% Lagrangian multipliers
options=optimoptions('fmincon','Display','iter','Algorithm','sqp');

% Call the fmincon function to start the optimization
[xOpt,fOpt,exitflag,output,lambda]=fmincon(func,x0,[],[],[],[],[],[],nlConstraint,options);

fprintf('\nOptimized theta = (%.4f, %.4f) \n', xOpt(1), xOpt(2))
fprintf('Optimized t = (%.4f, %.4f) \n\n', xOpt(3), xOpt(4))
fprintf('Optimized D = %.4f \n\n', fOpt)

fprintf('Lagrangian multipliers: \n')
fprintf('Lift constraint = %.4f \n', lambda.eqnonlin)
fprintf('Stress constraint = %.4f \n\n', lambda.ineqnonlin)


