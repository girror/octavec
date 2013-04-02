function C = tclosure(N)
% Initialization.
A = zeros(N, N);
for ii = 1:N
  for jj = 1:N
    if ii*jj < N/2,
      A(N-ii, ii+jj) = 1;
      A(ii, N-ii-jj) = 1;
    end;
    if ii == jj
      A(ii, jj) = 1;
    end
  end;
end;
B = A;
% Closure.
ii = N/2;
while ii >= 1,
  B = B*B;
  ii = ii/2;
end
C = B > 0;
