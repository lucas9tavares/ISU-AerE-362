clear
clc

theta=[0.6;0.3];
t=[1;0.5];

gamma = [1;1];
d=[1;1];

for i=1:20
    gamma = aero_component(theta, d);
    d = struct_component(theta, t, gamma);
end

disp(gamma)

disp(d)

