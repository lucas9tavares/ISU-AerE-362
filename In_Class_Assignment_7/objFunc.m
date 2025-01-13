function f = objFunc(x)
% Write objective function definition; 
% input x is a vector: x = [x1 x2]; x(1) is for x1 and x(2) is for x2

f = 2*x(1)^2 + 3*x(2)^2*x(1) - 8*x(1)*x(2) - 2*x(1);

end
