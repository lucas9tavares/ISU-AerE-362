clear
clc

fprintf('\n---------- Problem 3 Outputs ---------- \n\n')

theta=[1; 1];
t=[1; 1];

gamma = [1; 1];
d=[1; 1];

for i=1:2

    [gamma, residual_aero] = aero_component(theta, d, gamma);
    [d, residual_struct] = struct_component(theta, t, gamma, d);

    fprintf('MDA Iteration %d: \n\n', i)
    fprintf('gamma  = (%.04f, %.04f) \n', gamma)
    fprintf('d  = (%.04f, %.04f) \n', d)
    fprintf('Residual aerodynamics  = (%.04f, %.04f) \n', residual_aero)
    fprintf('Residual structure  = (%.04f, %.04f) \n\n', residual_struct)
end
