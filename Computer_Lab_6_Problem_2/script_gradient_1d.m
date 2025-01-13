% script to numerically differentiate a 1d function with gradient
clear variables;
close all;

% define function and analytical derivative
f=@(x) 0.2+25*x-200*x.^2+675*x.^3-900*x.^4+400*x.^5;
g=@(x) 25-400*x+3*675*x.^2-4*900*x.^3+5*400*x.^4;

% compute analytical derivatives
xa=[0:0.01:0.8]';
ga=g(xa);

% compute numerical derivatives
xn=[0:0.1:0.8]';
fn=f(xn);
gn=gradient(fn,.1);

% plot results
figure;
plot(xa,ga,'k-','linewidth',1.5);
hold on;
plot(xn,gn,'ro','markerfacecolor','r');
hold off;
set(gca,'FontSize',14,'FontName','Times New Roman');
xlabel('x');
ylabel('g');
legend('Analytical','Numerical');

