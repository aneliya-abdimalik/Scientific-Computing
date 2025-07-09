n_values = 1:2:300; % Use every other value to save computation
errors = struct('shermans', [], 'picketts', [], 'crouts', [], 'builtin', []);
times = struct('shermans', [], 'picketts', [], 'crouts', [], 'builtin', []);

for n = n_values
    A = hilb(n);
    tic;
    [L, U] = shermans(A);
    times.shermans(end+1) = toc;
    errors.shermans(end+1) = norm(A - L * U, 2) / norm(A, 2);
    
    tic;
    [L, U] = picketts(A);
    times.picketts(end+1) = toc;
    errors.picketts(end+1) = norm(A - L * U, 2) / norm(A, 2);
    
    tic;
    [L, U] = crouts(A);
    times.crouts(end+1) = toc;
    errors.crouts(end+1) = norm(A - L * U, 2) / norm(A, 2);
    
    tic;
    [L, U] = lu(A);
    times.builtin(end+1) = toc;
    errors.builtin(end+1) = norm(A - L * U, 2) / norm(A, 2);
end

% Plot relative errors
figure;
hold on;
plot(n_values, errors.shermans, '-o', 'DisplayName', "Sherman's March");
plot(n_values, errors.picketts, '-x', 'DisplayName', "Pickett's Charge");
plot(n_values, errors.crouts, '-s', 'DisplayName', "Crout's Method");
plot(n_values, errors.builtin, '-d', 'DisplayName', "Builtin LU");
xlabel('n');
ylabel('Relative Error');
legend;
title('Relative Error for LU Factorization Methods');
hold off;

% Plot execution times
figure;
hold on;
plot(n_values, times.shermans, '-o', 'DisplayName', "Sherman's March");
plot(n_values, times.picketts, '-x', 'DisplayName', "Pickett's Charge");
plot(n_values, times.crouts, '-s', 'DisplayName', "Crout's Method");
plot(n_values, times.builtin, '-d', 'DisplayName', "Builtin LU");
xlabel('n');
ylabel('Execution Time (s)');
legend;
title('Execution Time for LU Factorization Methods');
hold off;
