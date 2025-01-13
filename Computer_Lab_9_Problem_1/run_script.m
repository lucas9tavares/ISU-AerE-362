% example fmincon run script
clear variables;
close all;

% objective function name
func='objFunc';
% Initial point x0
x0=[2 2]';

% setup the optimizer options. No need to change.
% NOTE: sqp: Sequential quadratic programming, which is an iterative
% optimization algorithm using the quasi-Newton method with
% Lagrangian multipliers
options=optimoptions('fmincon','Display','iter','Algorithm','sqp');

% Problem formulation:
% Find x1 and x2 to:
% Minimize f = x1^2 + x2^2 - 4*x1 - 2*x1*x2
% Subject to h = 2*x1 + 3*x2 - 4 = 0

% Now we need to write the equality constraint as Aeq * x = beq
% equality constraint matrix Aeq = 2*x1+3*x2
Aeq=[2 3];
% equality constraint right-hand-side vector beq = 4
beq=4;

% Call the fmincon function to start the optimization
[xOpt,fOpt,exitflag,output,lambda]=fmincon(func,x0,[],[],Aeq,beq,[],[],[],options);


% plot the f contour and optimal point
[x1,x2] = meshgrid(-10:0.2:10,-10:0.2:10);
fC=x1.^2+2*x2.^2-4*x1-2*x1.*x2;
fc=contour(x1,x2,fC,0:50:500,'k');
clabel(fc)
hold on;
hC = 2*x1+3*x2-4;
contour(x1,x2,hC,[0 0],'k', "Linewidth", 3);
plot(xOpt(1),xOpt(2),"ro","Markersize", 8);
%contour(x1,x2,hC,[0.05:0.05:0.2],'c');
xlim([-10 10]);
ylim([-10 10]);
set(gca,'FontSize',20,'FontName','Times New Roman');
xlabel('x1');
ylabel('x2');