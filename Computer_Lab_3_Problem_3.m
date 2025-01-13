clear

% assign initial values for x
x = [1; 1; 1];
b = [1; 2; 1];

% main loop to solve the nonlinear eqn
for i = 1:10
    % update A
    A = [6 2*x(1) x(1); ...
         2*x(1) 5 2; ...
         1 x(2) 5];
   
    disp("Direct method iteration")
    disp(i)
    Res = A*x-b;
    ResNorm = norm(Res);
    disp("Residual Norm:")
    disp(ResNorm);

    x = inv(A) * b
    
end