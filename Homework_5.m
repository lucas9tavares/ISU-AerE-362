% AerE 362, Homework 5, Lucas Tavares

clear;
clc;
close all;


%% %%%%%%%%%% Problem 1 %%%%%%%%%%

% Define the objective and constraints functions
rho = 10;
f_hat = @(x) (x(1) - 6)^2 + (x(2) - 8)^2 + rho * (x(1) - x(2) - 6)^2;

% Initial guess
x0 = [8.666667, 5.333333];

% Minimizing
options = optimoptions('fminunc', 'Display', 'iter', 'Algorithm', 'quasi-newton');
[xOpt, fOpt] = fminunc(f_hat, x0, options);

% Display results
fprintf('Optimal x1: %f\n', xOpt(1));
fprintf('Optimal x2: %f\n', xOpt(2));
fprintf('Minimized function value: %f\n', fOpt);


%% %%%%%%%%%% Problem 2 %%%%%%%%%%

% Define the system of equations
system_of_eqs = @(vars) [
    2 * vars(1) - 7 * vars(2) + vars(3) + vars(4);  % 2 * x1 - 7 * x2 + nu + u = 0
    -10 * vars(2) + 1 - 7 * vars(1) + 6 * vars(3);  % -10 * x2 + 1 - 7 * x1 + 6 * nu = 0
    vars(1) + 6 * vars(2);                          % x1 + 6 * x2 = 0
    vars(1) + 4 + vars(5)^2;                        % x1 + 4 + s^2 = 0
    2 * vars(5) * vars(4)                           % 2 * s * u = 0
];

% Initial guess
initial_guess = [1, 1, 1, 1, 1];

% Solve the system
options = optimoptions('fsolve', 'Display', 'iter');
solution = fsolve(system_of_eqs, initial_guess, options);

% Calculate f_star
f_star = solution(1)^2 - 5 * solution(2)^2 + solution(2) - 7 * solution(1) * solution(2);

% Display results
    fprintf('Solution found:\n');
    fprintf('x1 = %f\n', solution(1));
    fprintf('x2 = %f\n', solution(2));
    fprintf('nu = %f\n', solution(3));
    fprintf('u = %f\n', solution(4));
    fprintf('s = %f\n', solution(5));
    fprintf('f_star = %f\n', f_star);



%% %%%%%%%%%% Problem 3 %%%%%%%%%%

% Objective function
objFun = @(x) 3*x(1)^2 + 6*x(2)^2 + 9*x(3)^2 - 2*x(1)*x(3) - x(1)*x(2);

% Initial guess
x0 = [1; 2; 3];

% Baseline objective function
f_0 = objFun(x0);

% Equality constraint h = x1 + 2*x2 - 6 = 0
Aeq = [1, 2, 0];
beq = 6;

% Inequality constraints A * x <= b
A = [
    1, -2, 2;   % g1: x1 - 2*x2 + 2*x3 <= 4
    0, 1, 3;    % g2: x2 + 3*x3 <= 6
    3, -2, 0    % g4: -3*x1 + 2*x2 >= -2 -> 3*x1 - 2*x2 <= 2
];
b = [4; 6; 2];

% Nonlinear constraint x1^3 + x2^2 - 2*x1*x3 <= 0
nlCon = @(x) deal(x(1)^3 + x(2)^2 - 2*x(1)*x(3), []);

% Execute fmincon
options = optimoptions('fmincon', 'Display', 'iter', 'Algorithm', 'sqp');
[xOpt, fOpt, exitflag, output, lambda] = fmincon(objFun, x0, A, b, Aeq, beq, [], [], nlCon, options);

% Display results
fprintf('Beaseline objective function f_0: %f\n', f_0)
fprintf('Optimal x*: [%f, %f, %f]\n', xOpt(1), xOpt(2), xOpt(3));
fprintf('Optimal objective function f*: %f\n', fOpt);
fprintf('First-order optimality measure: %e\n', output.firstorderopt);
fprintf('Constraint feasibility measure: %e\n', output.constrviolation);
