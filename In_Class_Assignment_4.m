clear

% assign initial guess for x
x = [1; 1; 1];
b = [1; 2; 1];

for i=1:10
    % update L
    L = [6 0 0; 2*x(1) 5 0; 1 x(2) 5];
    % update T
    T = [0 2*x(1) x(1); 0 0 2; 0 0 0];
    % compute A
    A = L + T;
    
    disp("Direct method iteration")
    disp(i)
    Res = A*x-b;
    ResNorm = norm(Res);
    disp("Residual Norm:")
    disp(ResNorm);

    x = inv(L) *(b - T*x)
end
