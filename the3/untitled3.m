A = [2 -1 0 0 0;
     -1 2 -1 0 0;
     0 -1 2 -1 0;
     0 0 -1 2 -1;
     0 0 0 -1 2];

[eVecs, eVals] = eig(A);

% Extract eigenvalues
eVals = diag(eVals);

% Find the largest and smallest eigenvalue by magnitude
[largest_eigenvalue, idx_largest] = max(abs(eVals));
[smallest_eigenvalue, idx_smallest] = min(abs(eVals));

% Corresponding eigenvectors
largest_eigenvector = eVecs(:, idx_largest);
smallest_eigenvector = eVecs(:, idx_smallest);

disp('Largest Eigenvalue:');
disp(largest_eigenvalue);
disp('Corresponding Eigenvector:');
disp(largest_eigenvector);

disp('Smallest Eigenvalue:');
disp(smallest_eigenvalue);
disp('Corresponding Eigenvector:');
disp(smallest_eigenvector);
