function [eVals, eVecs] = power_k(A, k)
    % POWER_K: Finds the largest k eigenvalues and eigenvectors using deflation.
    % Inputs:
    %   A - Square matrix.
    %   k - Number of largest eigenvalues to compute.
    % Outputs:
    %   eVals - k-largest eigenvalues (1xk vector).
    %   eVecs - Corresponding eigenvectors (k x n matrix).

    [n, ~] = size(A);
    eVals = zeros(1, k);
    eVecs = zeros(k, n);

    for i = 1:k
        % Initialize a random vector
        v = randn(n, 1);
        v = v / norm(v); % Normalize the vector

        % Power iteration to find the dominant eigenpair
        for iter = 1:1000
            v_new = A * v;
            v_new = v_new / norm(v_new);
            if norm(v - v_new) < 1e-6
                break;
            end
            v = v_new;
        end

        % Dominant eigenvalue
        lambda = v' * A * v;
        eVals(i) = lambda;
        eVecs(i, :) = v';

        % Deflate the matrix
        A = A - lambda * (v * v') / (v' * v);
    end
end
