function [gamma,d] = mda_solver(theta, t)

gamma = [0;0];
d=[0;0];

for i=1:10
    gamma = aero_component(theta, d);
    d = struct_component(theta, t, gamma);
end

end

