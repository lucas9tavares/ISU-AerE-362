function [theta, r] = propagator(x, plot)

dVtheta = x(1);
dVr = x(2);
tof = x(3);

theta0 = 0;
r0 = 1;
vtheta0 = 1;
vr0 = 0;
state0=[theta0; r0; vtheta0+dVtheta; vr0+dVr];

tSpan = linspace(0,tof,100);
[tProp, stateProp] = ode45(@(t,state) dynEqn(t,state), tSpan, state0);

theta = stateProp(:,1);
r = stateProp(:,2);

if (plot == 1)
    % sun
    polarplot(0,0,'ro', 'markersize', 20)
    hold on;
    % spacecraft initial location
    polarplot(theta0,r0,'bo')

    polarplot(theta,r,'-k')
    rlim([0 3])
end

end





