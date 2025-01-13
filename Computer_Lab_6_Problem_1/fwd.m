function g=fwd(x,h)
% first forward finite-difference
f=objfun(x);
f_f=objfun(x+h);
g=(f_f-f)./h;
end
