function g=cnd(x,h)
% first centered finite-difference
f_b=objfun(x-h);
f_f=objfun(x+h);
g=(f_f-f_b)./(2*h);
end
