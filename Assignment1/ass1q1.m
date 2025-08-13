s = tf('s');                                  % creating trasfer function variable s

%normal method:
%G_original = ((0.1*exp(-2*s))+s)/ (s^2+4*s+0.1);
%[out1, time1] = step(G_original, 10); 
%bode(G_original)
%step(G_original)


% method suggested:
num = 0.1;
den = [1 4 0.1];
P = tf(num,den,'InputDelay',2)
num1 = [1 0];
P1 = tf(num1,den,'InputDelay',0)
P2= P+P1;
[out1, time1] = step(P2, 10);        
unitstep1 = ones(size(out1));
step(P2)
bode(P2)
hold off

%bump test
% Define the plant transfer function
numerator = [0.1 1];
denominator = [1 4 0.1];
G = tf(numerator, denominator, 'InputDelay', 2);

% Define the actuator saturation limits
saturation_limits = [0, 10];

% Bump test input
t_bump = 0:0.01:10;
u_bump = 0.5*sin(2*pi*1*t_bump) + 0.2*sin(2*pi*5*t_bump);

% Simulate the response with actuator saturation
[y_bump, t_bump_actual, x_bump] = lsim(G, u_bump, t_bump, saturation_limits);

% Plot the bump test input and output
figure;
subplot(2,1,1);
plot(t_bump_actual, u_bump);
xlabel('Time');
ylabel('Input');
title('Bump Test Input Signal');
grid on;

subplot(2,1,2);
plot(t_bump_actual, y_bump);
xlabel('Time');
ylabel('Output');
title('Plant Response to Bump Test');
grid on;




