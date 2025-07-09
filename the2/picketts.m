function [L, U] = picketts(A)
    [m, n] = size(A);
    if m ~= n
        error('Matrix A must be square.');
    end
    if n == 1
        L = 1;
        U = A;
    else
        [L11, U11] = picketts(A(1:end-1, 1:end-1));
        U12 = A(1:end-1, end);
        L21 = A(end, 1:end-1) / U11;
        U22 = A(end, end) - L21 * U12;
        L = blkdiag(L11, 1);
        U = blkdiag(U11, U22);
        L(end, 1:end-1) = L21;
        U(1:end-1, end) = U12;
    end
end