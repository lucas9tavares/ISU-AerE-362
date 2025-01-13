function dStatedT = dynEqn(t, state)
% state: spacecraft state
% t: time
% theta: angle in a polar coordinate system
% r: radial distance in a polar coordinate system
% vtheta: tangential velocity
% vr: radial velocity
% state = [theta, r, vtheta, vr]

theta=state(1);
r = state(2);
vtheta=state(3);
vr=state(4);

dStatedT = zeros(4,1);
dStatedT(1) = vtheta/r;
dStatedT(2) = vr;
dStatedT(3) = -vr*vtheta/r;
dStatedT(4) = vtheta^2/r - 1/r/r;

end