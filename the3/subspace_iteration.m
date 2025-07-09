function [eVals, eVecs] = subspace_iteration(A, k)
    % POWER_K_SUBSPACE: Finds the largest k eigenvalues and eigenvectors using subspace iteration.
    % Inputs:
    %   A - Square matrix.
    %   k - Number of largest eigenvalues to compute.
    % Outputs:
    %   eVals - k-largest eigenvalues (1xk vector).
    %   eVecs - Corresponding eigenvectors (k x n matrix).

    [n, ~] = size(A);
    V = randn(n, k); % Random initial subspace
    [V, ~] = qr(V, 0); % Orthogonalize initial subspace

    for iter = 1:1000
        % Apply matrix to subspace
        V_new = A * V;

        % Re-orthogonalize using QR factorization
        [V_new, ~] = qr(V_new, 0);

        % Check for convergence
        if norm(V - V_new, 'fro') < 1e-6
            break;
        end
        V = V_new;
    end

    % Compute eigenvalues and eigenvectors
    T = V' * A * V; % Projected matrix
    [eVecs_T, eVals_diag] = eig(T);
    eVals = diag(eVals_diag);

    % Sort eigenvalues and eigenvectors
    [eVals, idx] = sort(eVals, 'descend');
    eVecs = V * eVecs_T(:, idx);
end
