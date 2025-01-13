% script to numerically differentiate a 2d function with gradient
clear variables;
close all;

% define function and analytical derivative
f=@(x,y) y-x-2*x.^2-2*x.*y-y.^2;

% compute gradient
[x,y]=meshgrid(-2:.25:0,1:.25:3);
z=f(x,y);
[fx,fy]=gradient(z,.25);

% plot results
figure;
[M,c]=contourf(x,y,z);
clabel(M);
c.LineWidth=1.5;
hold on;
quiver(x,y,fx,fy);
hold off;
set(gca,'FontSize',14,'FontName','Times New Roman');
xlabel('x');
ylabel('y');
