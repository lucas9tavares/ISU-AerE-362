function [gamma,d] = mda_solver(theta, t)

gamma = [1;1];
d=[1;1];

for i=1:10
    gamma = aero_component(theta, d);
    d = struct_component(theta, t, gamma);
end

end

