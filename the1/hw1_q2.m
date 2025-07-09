% Define n range
n = 1:10^6;

% Create k arrays for single and double precision
k_single = single(1 + (10^6 + 1 - n) * 10^(-8));
k_double = 1 + (10^6 + 1 - n) * 10^(-8); % Double precision

% Theoretical value of the sum
N = 10^6;
nums_1 = single(1 + (10^6 + 1 - 1) * 10^(-8));  % nums[1]
nums_N = single(1 + (10^6 + 1 - N) * 10^(-8));  % nums[N]

% Calculate the theoretical sum using the formula for a linearly changing series
theoretical_sum = (N * (nums_1 + nums_N)) / 2;

% Function to calculate Kahan summation
function sum_kahan = kahan_sum(arr)
    sum_kahan = 0;
    c = 0; % Compensation for lost low-order bits
    for i = 1:length(arr)
        y = arr(i) - c;
        t = sum_kahan + y;
        c = (t - sum_kahan) - y;
        sum_kahan = t;
    end
end

% Function for pairwise summation
function sum_p = pairwise_sum(array)
    if length(array) == 1
        sum_p = array(1);
    else
        mid = floor(length(array) / 2);
        sum_p = pairwise_sum(array(1:mid)) + pairwise_sum(array(mid+1:end));
    end
end

% a. Naive summation - single precision
tic;
naive_sum_single = sum(k_single);
naive_time_single = toc;

% a. Naive summation - double precision
tic;
naive_sum_double = sum(k_double);
naive_time_double = toc;

% b. Kahan summation - single precision
tic;
kahan_sum_single = kahan_sum(k_single);
kahan_time_single = toc;

% b. Kahan summation - double precision
tic;
kahan_sum_double = kahan_sum(k_double);
kahan_time_double = toc;

% c. Pairwise summation - single precision
tic;
pairwise_sum_single = pairwise_sum(k_single);
pairwise_time_single = toc;

% c. Pairwise summation - double precision
tic;
pairwise_sum_double = pairwise_sum(k_double);
pairwise_time_double = toc;

% Calculate absolute and relative errors
naive_error_abs_single = abs(naive_sum_single - theoretical_sum);
naive_error_rel_single = naive_error_abs_single / abs(theoretical_sum);

naive_error_abs_double = abs(naive_sum_double - theoretical_sum);
naive_error_rel_double = naive_error_abs_double / abs(theoretical_sum);

kahan_error_abs_single = abs(kahan_sum_single - theoretical_sum);
kahan_error_rel_single = kahan_error_abs_single / abs(theoretical_sum);

kahan_error_abs_double = abs(kahan_sum_double - theoretical_sum);
kahan_error_rel_double = kahan_error_abs_double / abs(theoretical_sum);

pairwise_error_abs_single = abs(pairwise_sum_single - theoretical_sum);
pairwise_error_rel_single = pairwise_error_abs_single / abs(theoretical_sum);

pairwise_error_abs_double = abs(pairwise_sum_double - theoretical_sum);
pairwise_error_rel_double = pairwise_error_abs_double / abs(theoretical_sum);

% Display results
fprintf('The theoretical sum is: %.10f\n', theoretical_sum);
fprintf('Naive Summation - Single Precision:\n');
fprintf('Sum: %.10f, Absolute Error: %.10e, Relative Error: %.10e, Runtime: %.5f s\n', naive_sum_single, naive_error_abs_single, naive_error_rel_single, naive_time_single);

fprintf('Naive Summation - Double Precision:\n');
fprintf('Sum: %.10f, Absolute Error: %.10e, Relative Error: %.10e, Runtime: %.5f s\n', naive_sum_double, naive_error_abs_double, naive_error_rel_double, naive_time_double);

fprintf('Kahan Summation - Single Precision:\n');
fprintf('Sum: %.10f, Absolute Error: %.10e, Relative Error: %.10e, Runtime: %.5f s\n', kahan_sum_single, kahan_error_abs_single, kahan_error_rel_single, kahan_time_single);

fprintf('Kahan Summation - Double Precision:\n');
fprintf('Sum: %.10f, Absolute Error: %.10e, Relative Error: %.10e, Runtime: %.5f s\n', kahan_sum_double, kahan_error_abs_double, kahan_error_rel_double, kahan_time_double);

fprintf('Pairwise Summation - Single Precision:\n');
fprintf('Sum: %.10f, Absolute Error: %.10e, Relative Error: %.10e, Runtime: %.5f s\n', pairwise_sum_single, pairwise_error_abs_single, pairwise_error_rel_single, pairwise_time_single);

fprintf('Pairwise Summation - Double Precision:\n');
fprintf('Sum: %.10f, Absolute Error: %.10e, Relative Error: %.10e, Runtime: %.5f s\n', pairwise_sum_double, pairwise_error_abs_double, pairwise_error_rel_double, pairwise_time_double);
