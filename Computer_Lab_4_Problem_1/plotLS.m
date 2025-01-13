function plotLS(x0, d0, alphaOpt)
    % Plot the Line Search Function
    % Inputs:
    %   x0: Current design variables [x1, x2]
    %   d0: Search direction
    %   alphaOpt (optional): Optimal step size in the search direction
    % Outputs:
    %   Two plots visualizing the line search process

    % Define the range of alpha values for the line search
    alpha = 0:0.1:10;
    f = [];
    
    % Calculate the function value for each alpha
    for a = alpha
        x = x0 + a * d0;
        f = [f, objFunc(x)];
    end

    %% First plot: Line Search Function
    figure(1)
    plot(alpha, f, '-k');
    hold on;

    % Plot the initial function value
    f0 = objFunc(x0);
    plot(0, f0, 'bo', 'markerfacecolor', 'r');

    % If alphaOpt is provided, plot the optimal function value
    if nargin > 2  % nargin - number of function input arguments
        fOpt = objFunc(x0 + alphaOpt * d0);
        plot(alphaOpt, fOpt, 'bo', 'markerfacecolor', 'b');
    end

    xlabel('alpha');
    ylabel('f(alpha)');
    set(gca, 'FontSize', 20, 'FontName', 'Times New Roman');
    title("Line Search Function");

    %% Second plot: Objective Function Contour
    figure(2)
    [x1, x2] = meshgrid(-10:0.2:10, -10:0.2:10);
    sizeX = size(x1);
    fC = x1;
    
    % Calculate function values for contour plot
    for i = 1:sizeX(1)
        for j = 1:sizeX(2)
            fC(i, j) = objFunc([x1(i, j), x2(i, j)]);
        end
    end
    
    % Plot the contour of the objective function
    fc = contour(x1, x2, fC, [0:50:500], 'k');
    clabel(fc)
    hold on;
    
    % Plot the initial point and search direction
    plot(x0(1), x0(2), 'ro', 'markerfacecolor', 'r')
    plot([x0(1), x0(1) + 100 * d0(1)], [x0(2), x0(2) + 100 * d0(2)], "--k");

    % If alphaOpt is provided, plot the optimal point along the search direction
    if nargin > 2
        plot(x0(1) + alphaOpt * d0(1), x0(2) + alphaOpt * d0(2), 'bo', 'markerfacecolor', 'b');
    end

    xlim([-10 10]);
    ylim([-10 10]);
    xlabel('x1');
    ylabel('x2');
    set(gca, 'FontSize', 20, 'FontName', 'Times New Roman');
    title("Objective Function Contour");
end
