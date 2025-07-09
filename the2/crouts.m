function [L, U] = crouts(A)
    [m, n] = size(A);
    if m ~= n
        error('Matrix A must be square.');
    end
    if n == 1
        L = A;
        U = 1;
    else
        L = zeros(n);
        U = eye(n);
        L(:, 1) = A(:, 1);
        for i = 2:n
            U(1, i) = A(1, i) / L(1, 1);
        end
        [L(2:end, 2:end), U(2:end, 2:end)] = crouts(A(2:end, 2:end) - L(2:end, 1) * U(1, 2:end));
    end
end