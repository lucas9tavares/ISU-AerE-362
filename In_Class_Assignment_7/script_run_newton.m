% run script for Netwon optimization
clear variables;
close all;
clc;

%% define input parameters
% initial design variable
x=[-4;4];

% x1Hist and x2Hist store the history of x during optimization
x1Hist=[x(1)];
x2Hist=[x(2)];
% nFuncEvals is the number of function evaluations
nFuncEvals = 0;
% initialize iter
iter = 0;


%% main loop, we do maximal 100 optimization iterations
for n=0:10
    
    % compute f, c, and d
    f = objFunc(x);
    c = objFuncDerivFD(x);
    if norm(c) <= 1e-4
        break;
    else
        H = objFuncHessianFD(x);
        d = -inv(H) * c;
        x = x + d;
    end
    
    % x has been updated, we need to increment the number of function
    % evaluations, store the history of design variables x and print some
    % info to the screen.
    nFuncEvals = nFuncEvals + iter + 1;
    disp("optIter: "+num2str(n)+ ...
        " nFuncEvals: "+num2str(nFuncEvals)+ ...
        " f: "+num2str(f) + ...
        " x1: "+num2str(x(1))+ ...
        " x2: "+num2str(x(2)));
    x1Hist=[x1Hist;x(1)];
    x2Hist=[x2Hist;x(2)];
    
end
% Optimization is done!

%% plot results
[x1,x2] = meshgrid(-10:0.2:10,-10:0.2:10);
sizeX = size(x1);
fC = x1;
for i = 1:sizeX(1)
    for j = 1:sizeX(2)
        fC(i,j) = objFunc([x1(i,j),x2(i,j)]);
    end
end

fc=contour(x1,x2,fC,[-200:40:200],'k');
clabel(fc)
hold on;
plot(x1Hist, x2Hist,"-ro", "markerfacecolor","r")
plot(x1Hist, x2Hist)
xlim([-10 10]);
ylim([-10 10]);
set(gca,'FontSize',20,'FontName','Times New Roman');
xlabel('x1');
ylabel('x2');
