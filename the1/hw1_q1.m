% Define the function f(x)
f = @(x) x .* (((x + 1) ./ x) - 1) - 1;

% Machine epsilon
epsilon = eps;

% Define the function g(n)
g = @(n) f(n) / epsilon;

% Generate the integer values from 1 to 1000
n = 1:1000;

% Evaluate g(n)
g_values = g(n);

% Plot g(n)
figure;
plot(n, g_values);
xlabel('n');
ylabel('g(n)');
title('Plot of g(n) for n ∈ [1, 1000]');
grid on;


% Find values of n where g(n) is 0
zero_indices = find(g_values == 0);

% Display the results
if isempty(zero_indices)
    disp('No values of n satisfy g(n) = 0 within the range [1, 1000].');
else
    disp('Values of n that satisfy g(n) = 0:');
    disp(n(zero_indices));
end

