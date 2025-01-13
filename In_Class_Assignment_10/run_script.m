% example fmincon run script
clear variables;
close all;

% objective function name
func='objFunc';
% nonlinear constraint function name
nlFunc='nlCon';
% Initial point x0
x0=[5; 5; 5];

% setup the optimizer options. No need to change.
% NOTE: sqp: Sequential quadratic programming, which is an iterative
% optimization algorithm using the quasi-Newton method with
% Lagrangian multipliers
options=optimoptions('fmincon','Display','iter','Algorithm','sqp');



% Now we need to write the equality constraint as Aeq * x = beq
Aeq=[5 -6 2];
% equality constraint right-hand-side vector beq = -7
beq=-7;

% Now we need to write the inequality constraint as A * x <= b
A = [2 3 -1; 1 -9 0];
% inequality constraint right-hand-side vector b = | 4  |
%                                                  | 10 |
b = [4; 10];

% Call the fmincon function to start the optimization
[xOpt,fOpt,exitflag,output,lambda]=fmincon(func,x0,A,b,Aeq,beq,[],[],nlFunc,options);

% Print result
fprintf('\nxOpt = (%.04f, %.04f, %.04f) \n', xOpt(1), xOpt(2), xOpt(3))
fprintf('fOpt = %.04f \n\n', fOpt)
