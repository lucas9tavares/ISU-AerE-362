function f = objFunc(x)
    % Objective Function
    % Inputs:
    %   x: A vector containing design variables [x1, x2]
    % Outputs:
    %   f: The value of the objective function at x

    % Calculate the objective function value
    f = x(1)^2 + 2*x(2)^2 - 4*x(1) - 2*x(1)*x(2);
end
