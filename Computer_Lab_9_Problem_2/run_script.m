% example fmincon run script
clear variables;
close all;

% objective function name
func='objFunc';
% Initial point x0
x0=[2; 2];

% setup the optimizer options. No need to change.
% NOTE: sqp: Sequential quadratic programming, which is an iterative
% optimization algorithm using the quasi-Newton method with
% Lagrangian multipliers
options=optimoptions('fmincon','Display','iter','Algorithm','sqp');

% Problem formulation:
% Find x1 and x2 to:
% Minimize f = x1^2 + x2^2 - 4*x1 - 2*x1*x2
% Subject to h  = 5*x1 - 6*x2 + 7   = 0
%            g1 = 2*x1 + 3*x2 - 4  <= 0
%            g2 =   x1 - 9*x2 - 10 <= 0

% Now we need to write the equality constraint as Aeq * x = beq
% equality constraint matrix Aeq = 5*x1-6*x2
Aeq=[5 -6];
% equality constraint right-hand-side vector beq = -7
beq=-7;

% Now we need to write the inequality constraint as A * x <= b
% inequality constraint matrix A =| 2*x1 + 3*x2 |
%                                 |   x1 + 9*x2 |
A = [2 3; 1 -9];
% inequality constraint right-hand-side vector b = | 4  |
%                                                  | 10 |
b = [4; 10];

% Call the fmincon function to start the optimization
[xOpt,fOpt,exitflag,output,lambda]=fmincon(func,x0,A,b,Aeq,beq,[],[],[],options);


% plot the f contour and optimal point
[x1,x2] = meshgrid(-10:0.2:10,-10:0.2:10);
fC=x1.^2+2*x2.^2-4*x1-2*x1.*x2;
fc=contour(x1,x2,fC,[0:50:500],'k');
clabel(fc)
hold on;
hC1 = 2*x1+3*x2-4;
hC2 = x1-9*x2-10;
hC3 = 5*x1-6*x2 + 7;
contour(x1,x2,hC1,[0 0],'k', "Linewidth", 3);
contour(x1,x2,hC1,[0.05:0.1:0.4],'c');
contour(x1,x2,hC2,[0 0],'k', "Linewidth", 3);
contour(x1,x2,hC2,[0.1:0.1:1.0],'c');
contour(x1,x2,hC3,[0 0],'k', "Linewidth", 3);
plot(xOpt(1),xOpt(2),"ro","Markersize", 8);
xlim([-10 10]);
ylim([-10 10]);
set(gca,'FontSize',20,'FontName','Times New Roman');
xlabel('x1');
ylabel('x2');