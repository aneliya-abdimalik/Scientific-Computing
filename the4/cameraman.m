% Load the image
filename = "cameraman.jpg";
A = im2double(imread(filename));

% Desired ranks
k_values = [5, 25, 50];

% Loop through desired ranks
figure;
for i = 1:length(k_values)
    k = k_values(i);
    
    % Call the approximate SVD function
    [u_k, s_k, v_k] = approximate_svd(A, k);
    
    % Reconstruct the image
    approx_image = u_k * s_k * v_k';
    
    % Display the reconstructed images
    subplot(1, length(k_values)+1, i);
    imshow(approx_image, []);
    title(['k = ', num2str(k),]);
end

% Display the original image
subplot(1, length(k_values)+1, length(k_values)+1);
imshow(A, []);
title('Original Image');

% Function to calculate approximate SVD
function [u_k, s_k, v_k] = approximate_svd(A, k, p)
    if ~exist('p', 'var')
        p = 5; % Oversampling parameter
    end
    [m, n] = size(A);
    random_matrix = randn(n, k + p); % Generate random matrix
    sample = A * random_matrix;
    Q = orth(sample); % Orthonormalize sampled matrix
    small_matrix = Q' * A; % Project A into lower-dimensional space
    [u, s, v] = svd(small_matrix, 'econ'); % SVD on the small matrix
    u_k = Q * u(:, 1:k); % Reconstruct u_k
    s_k = s(1:k, 1:k); % Truncate s_k
    v_k = v(:, 1:k); % Truncate v_k
end

 % Compare errors for different ranks
k_limit = 50;
group_size = 5;
errors = the4_compare(A, k_limit, group_size);

% Compare runtimes for different ranks
runtimes = the4_compare_time(A, k_limit);

% Plotting errors
figure;
plot(1:k_limit, errors(end-1, :), '--', 'DisplayName', 'Approx SVD Mean Error');
hold on;
plot(1:k_limit, errors(end, :), '-', 'DisplayName', 'svds Error');
xlabel('Rank (k)');
ylabel('Relative Error');
title('Error Comparison');
legend;
hold off;

% Plotting runtimes
figure;
plot(1:k_limit, runtimes(1, :), '--', 'DisplayName', 'Approx SVD Runtime');
hold on;
plot(1:k_limit, runtimes(2, :), '-', 'DisplayName', 'svds Runtime');
xlabel('Rank (k)');
ylabel('Runtime (seconds)');
title('Runtime Comparison');
legend;
hold off;