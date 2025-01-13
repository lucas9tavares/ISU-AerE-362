% run script for steepest-descent optimization
clear variables;
close all;
clc;

% define input parameters
% initial design variable
x=[15 20];

% x1Hist and x2Hist store the history of x during optimization
x1Hist=[x(1)];
x2Hist=[x(2)];
fHist=[objFunc(x)];
nHist=[0];
% nFuncEvals is the number of function evaluations
nFuncEvals = 0;
% initialize iter
iter = 0;
% main loop, we do maximal 100 optimization iterations
for n=0:100
    % Step 1: Calculate the objective function value (f) at x
    f = objFunc(x);
    % Step 2: Calculate the gradient (c) at x
    c = objFuncDeriv(x);
    % Step 3: Check if norm of gradient is less than 1e-4 (tolerance)
    if norm(c) <= 1e-4
        break;
    else
        % Step 4:
        %    Set the search direction d as d = -c
        d = -c;

        % Step 5:
        %    Call the golden function to calculate alphaMin to minimize f
        %    along the search direction
        alphaL=0; alphaU=10; tol=1e-4; maxit=50;
        [alphaMin,fMin,I,iter] = golden(x,d,alphaL,alphaU,tol,maxit);

        % Step 6:
        %    Update x based on the alphaMin value computed from step 5.
        x = x + alphaMin * d;
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
    fHist=[fHist;f];
    nHist=[nHist;n];
    
end
% Optimization is done!

% plot results
figure(1)
[x1,x2] = meshgrid(0:0.2:25,0:0.2:25);
sizeX = size(x1);
fC = x1;
for i = 1:sizeX(1)
    for j = 1:sizeX(2)
        fC(i,j) = objFunc([x1(i,j),x2(i,j)]);
    end
end
fc=contour(x1,x2,fC,[0:50:500],'k');
clabel(fc)
hold on;
plot(x1Hist, x2Hist,"-ro", "markerfacecolor","r")
plot(x1Hist, x2Hist)
xlim([0 25]);
ylim([0 25]);
set(gca,'FontSize',20,'FontName','Times New Roman');
xlabel('x1');
ylabel('x2');

figure(2)
plot(nHist, fHist, "-ko", "Linewidth", 2);
set(gca,'FontSize',20,'FontName','Times New Roman');
xlabel('Iteration');
ylabel('Objective Function');
