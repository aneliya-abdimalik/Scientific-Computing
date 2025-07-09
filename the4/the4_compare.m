function retval = the4_compare (A, k_limit, group_size)
  if ~exist('k_limit','var')
    k_limit = 100;
  end
  retval = zeros(2 + group_size, k_limit);
  [U, S, V] = svd(A);
  A_reconstructed = U*S*transpose(V);
  deliminator = norm(A_reconstructed);
  for k = 1:k_limit
    for n = 1:group_size
      [u, s, v] = approximate_svd(A, k);
      retval(n, k) = norm(u*s*transpose(v)- A_reconstructed)/deliminator;
    end
    retval(group_size + 1, k) = mean(retval(1:group_size, k));
    [u, s, v] = svds(A, k);
    retval(group_size + 2, k) = norm(u*s*transpose(v)- A_reconstructed)/deliminator;
    disp(k);
  end
end