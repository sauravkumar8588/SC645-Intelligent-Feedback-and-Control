function dx = pendulumDynamics(t, x, u)
    g = 9.81;  % acceleration due to gravity in m/s^2
    L = 1;     % length of the pendulum in meters
    b = 0.5;   % damping coefficient
    m = 1;     % mass of the pendulum in kg
    dx(1,1) = x(2);
    dx(2,1) = (-g/L) * sin(x(1)) - (b/(m*L^2)) * x(2) + (1/(m*L^2)) * u;
end
