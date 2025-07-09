function [uk, sigma_k, vk] = approximate_svd(A, k)
    p = 5;
    l = k + p; 
    [m, n] = size(A);
    Omega = randn(n, l);
    Y = A * Omega;
    [Q, ~] = qr(Y, 0);
    B = Q' * A;
    [U_tilde, Sigma, V] = svd(B, 'econ');
    uk = Q * U_tilde(:, 1:k);
    sigma_k = Sigma(1:k, 1:k);
    vk = V(:, 1:k); 
end