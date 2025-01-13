clear

% Gauss-Seidel formulation
% x^(k+1) = L^-1 * (b - T * x^k);

% assign values for L, T, and b
L = [6 0 0; 2 5 0; 1 1 5];
T = [0 2 1; 0 0 2; 0 0 0];
b = [1; 2; 1];
A = [6 2 1; 2 5 2; 1 1 5];

x = [1; 1; 1];

for i=1:10
    disp("Gauss-Seidel iteration");
    disp(i);
    disp(x);
    % calculate the residual
    Res = A * x - b;
    ResNorm = norm(Res);
    disp("Residual Norm: ")
    disp(ResNorm)
    
    x = inv(L)*(b-T*x);
end

