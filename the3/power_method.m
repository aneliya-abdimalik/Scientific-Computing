function [eVal, eVec] = power_method(A, V)
    if nargin < 2
        V = rand(size(A, 1), 1);
    end
    V = V / norm(V);
    tol = 1e-6;
    maxIter = 1000;
    for k = 1:maxIter
        W = A * V;
        W_norm = norm(W);
        V_new = W / W_norm;
        if norm(V_new - V) < tol
            break;
        end
        V = V_new;
    end
    eVec = V;
    eVal = V' * A * V;
end
