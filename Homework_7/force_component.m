function [D,L] = force_component(gamma)
L=10*gamma(1)+8*gamma(2);
D=2*gamma(1)+gamma(2);
end