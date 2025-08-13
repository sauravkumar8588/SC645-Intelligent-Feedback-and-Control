clc;
clear all;
% System parameters
g = 9.81;%gravity
L = 1;   %length
b = 0.5; % damping coefficient
m = 1;   % mass

% Sampling parameters
num_points = 100; 
sampling_time = 0.01;

% Operating point sampling
theta_values = linspace(-pi, pi, num_points);

% Linearized system matrices
A_matrices = cell(num_points, 1);
B_matrices = cell(num_points, 1);

% Control gains and inputs
K_gains = cell(num_points, 1);
U_inputs = cell(num_points, 1);

% Compute linearized system dynamics and control gains
for i = 1:num_points
    theta_i = theta_values(i);
    % Trimming: Compute input corresponding to the operating point
    U_i = m * g * L * sin(theta_i);
    % Linearize the system around the current initial angle
    A_i = [0, 1; -g * cos(theta_i) / L, -b / (m * L^2)];
    B_i = [0; 1 / (m * L^2)];
    % Store matrices
    A_matrices{i} = A_i;
    B_matrices{i} = B_i;
    U_inputs{i} = U_i;
    % Design controller gains using LQR
    Q = diag([50, 50]); % State cost
    R = 1; % Control cost
    sysd = c2d(ss(A_i, B_i, eye(2), zeros(2, 1)), sampling_time); % Convert to discrete-time
    K_gains{i} = dlqr(sysd.A, sysd.B, Q, R);
end

% Simulation parameters
final_state = [pi; 0]; % Final state
final_time = 25; % Final time
time = 0:sampling_time:final_time; % Time vector

% Initialize state and control input vectors
state_vector = zeros(2, length(time)); % State vector
control_input_vector= zeros(1, length(time)); % Control input vector

% Additive noise parameters
noise_mean = 0;
noise_variance = 0.001;

% Simulate system dynamics with noise disturbance
for i = 1:length(time)-1
    % Add noise to the current state
    state_vector(:, i) = state_vector(:, i) + noise_variance * randn(2, 1) + noise_mean;
    % Get the index of the closest operating point
    [~, idx] = min(abs(theta_values - state_vector(1, i)));
    % Applying control law based on gain scheduling
    control_input_vector(i) = -K_gains{idx} * (state_vector(:, i) - final_state) + U_inputs{idx};
    % Update system dynamics
    state_vector(:, i + 1) = state_vector(:, i) + [state_vector(2, i); -g / L * sin(state_vector(1, i)) - b / (m * L^2) * state_vector(2, i) + 1 / (m * L^2) * control_input_vector(i)] * sampling_time;
end

% Plot results
figure;

% Plot angle, angular velocity, and control input vs time
subplot(2, 1, 1);
plot(time, state_vector(1, :), 'black', 'LineWidth', 2);
hold on;
plot(time, state_vector(2, :), 'b', 'LineWidth', 2);
ylabel('Angle (rad), Angular Velocity (rad/s)');
title('Pendulum Angle and Angular Velocity vs Time');
legend('Angle', 'Angular Velocity', 'Location', 'best');
grid on;

subplot(2, 1, 2);
plot(time, control_input_vector, 'r', 'LineWidth', 2);
xlabel('Time (s)');
ylabel('Control Input');
title('Control Input vs Time');
grid on;
