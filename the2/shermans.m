function [L, U] = shermans(A)
    [m, n] = size(A);
    if m ~= n
        error('Matrix A must be square.');
    end
    if n == 1
        L = 1;
        U = A;
    else
        [L11, U11] = shermans(A(1:end-1, 1:end-1));
        L21 = A(end, 1:end-1) / U11;
        U12 = L11 \ A(1:end-1, end);
        L = [L11, zeros(size(L11, 1), 1); L21, 1];
        U = [U11, U12; zeros(1, size(U11, 2)), A(end, end) - L21 * U12];
    end
end