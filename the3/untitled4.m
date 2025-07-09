A = [0.2 0.3 -0.5;
    0.6 -0.8 0.2;
     -1.0 0.1 0.9];

v = [1; 1; 1];  % Initial vector
v = v / norm(v);  % Normalize the starting vector
tol = 1e-6;
maxIter = 1000;

for k = 1:maxIter
    w = A * v;  % Matrix-vector multiplication
    lambda = dot(v, w);  % Rayleigh quotient to estimate eigenvalue
    w = w / norm(w);  % Normalize the new vector
    
    if norm(w - v) < tol
        break;
    end
    
    v = w;  % Update the vector for the next iteration
end

disp('Largest Eigenvalue:');
disp(lambda);
disp('Corresponding Eigenvector:');
disp(v);
