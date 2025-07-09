% Load the can_229 matrix
load('can_229.mat'); % Ensure this file is in your working directory
A = Problem.A;       % Update if necessary

% Parameters
k = 5; % Number of largest eigenvalues to compute

% Power Method
disp('Running Power Method...');
tic;
[eVals_power, eVecs_power] = power_k(A, k);
time_power = toc;
disp('Power Method completed.');

% Subspace Iteration Method
disp('Running Subspace Iteration Method...');
tic;
[eVals_subspace, eVecs_subspace] = subspace_iteration(A, k);
time_subspace = toc;
disp('Subspace Iteration Method completed.');

% Display Results
fprintf('Power Method Time: %.6f seconds\n', time_power);
fprintf('Subspace Iteration Time: %.6f seconds\n', time_subspace);

% Plot Execution Times
methods = {'Power Method', 'Subspace Iteration'};
times = [time_power, time_subspace];

figure;
bar(times);
set(gca, 'XTickLabel', methods);
ylabel('Execution Time (seconds)');
title('Comparison of Execution Times');
