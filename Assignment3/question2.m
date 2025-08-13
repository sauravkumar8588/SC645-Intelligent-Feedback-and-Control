
clc
clear all

%defining our PID
Kp = 43;
Ki = 48;
Kd = 12.4;

s = tf('s');
C = Kp + Ki/s + Kd*s ;

%Given trasfer funtion
NUM1 = [1];
DEN1 = [1, 3.6, 9];
G= tf(NUM1, DEN1);

% D to C tranfer function
G1 = feedback(G, C);
step(G1);

% R to C tranfer func
G2 = feedback(G*C, 1);
%step(G2);

% Ziglar Nicolas tuning
%{
% Obtain the step response
time = 0:0.01:20;                % Time vector
[y_out, time] = step(G, time);   % Simulate the response to the step input

% point of maximum slope
delta_y = diff(y_out) ./ diff(time);          % Calculate the slope
[max_slope, max_slope_index] = max(delta_y);  % Find the maximum slope

%time and output value for the maximum slope
max_slope_time = t(max_slope_index);
max_slope_output = y(max_slope_index);

%slope of the tangent at the point of maximum slope
tangent_slope = max_slope;

%intercepts of the tangent line
y_intercept = max_slope_output - tangent_slope * max_slope_time;
x_intercept = -y_intercept / tangent_slope;

% Plot the step response and tangent line
plot(time, y_out);
hold on;
plot(max_slope_time, max_slope_output, 'ro');  % Mark the point of max slope
plot([0, max_slope_time + 2], [y_intercept, max_slope_output + tangent_slope * (max_slope_time + 2)], 'g--');  % Plot the tangent line
hold off;
xlabel('Time');
ylabel('Response');
title('Step Response with Tangent at Max Slope');

% Display the intercepts
fprintf('L: %.4f\n', x_intercept);
fprintf('a: %.4f\n', -y_intercept);

a = 0.0196;
L = 0.1181;

Kp = 1.2/a;
Kd = 1/(2*L);
Ki = 0.5*L;

% PID Controller
C = Kp + Kd*s + Ki/s;

% R to C tranfer function
G3 = G*C/(1+G*C);
step(G3);

% D to C tranfer function
G4 = G/(1+G*C);
%step(G4); 
%}

% auto tuning 
% Auto-tune the PID controller
[PID_controller,~,info] = pidtune(G,'pid');

% Display the tuned PID controller gains
disp('Tuned PID Controller Gains:');
disp(PID_controller);

% Display tuning information
disp('Tuning Information:');
disp(info);

Kp = get(PID_controller,'Kp');
Kd = get(PID_controller,'Kd');
Ki = get(PID_controller,'Ki');

% PID Controller
C = Kp + Kd*s + Ki/s;

% R to C tranfer funcion
G5 = G*C/(1+G*C);
%step(G5);

% D to C tranfer function
G6 = G/(1+G*C);
step(G6/s); 



