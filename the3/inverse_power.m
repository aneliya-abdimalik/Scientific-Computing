function [eVal, eVec] = inverse_power(A, alpha)
    n = size(A, 1);
    I = eye(n);
    V = rand(n, 1);
    V = V / norm(V);
    M = A - alpha * I;
    tol = 1e-6;
    maxIter = 1000;
    
    for k = 1:maxIter
        V_new = M \ V;
        V_new = V_new / norm(V_new);
        if norm(V_new - V) < tol
            break;
        end
        V = V_new;
    end
    
    eVec = V;
    eVal = alpha + (V' * A * V) / (V' * V);
end