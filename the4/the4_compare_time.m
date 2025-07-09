function retval = the4_compare_time (A, k_limit)
  if ~exist('k_limit','var')
    k_limit = 100;
  end
  retval = zeros(2, k_limit);
  for k = 1:k_limit
    timer = tic;
    [u, s, v] = approximate_svd(A, k);
    retval(1,k) = toc(timer);
    timer = tic;
    [u, s, v] = svds(A, k);
    retval(2,k) = toc(timer);
  end
end