runs=3;
cumulate = 0; p = 0; vt = 0; vr = 0; vrt = 0; rvt = 0; RV = 0; j = 0; k = 0;
x2 = 0; R = 0; Rxx = 0; Ryy = 0; Rxy = 0; Ryx = 0; Rvmax = 0; f = 0;
for i = 1:runs
  x = abs(randn(37, 37));
#  tic;
    % Calculation of Escoufier's equivalent vectors
    p = size(x, 2);
    vt = [1:p];                                % Variables to test
    vr = [];                                   % Result: ordered variables
    RV = [1:p];                                % Result: correlations
    for j = 1:p                                % loop on the variable number
      Rvmax = 0;
      for k = 1:(p-j+1)                        % loop on the variables
        if j == 1
          x2 = [x, x(:, vt(k))];
        else
          x2 = [x, x(:, vr), x(:, vt(k))];     % New table to test
        end
        R = corrcoef(x2);                      % Correlations table
        Ryy = R(1:p, 1:p);
        Rxx = R(p+1:p+j, p+1:p+j);
        Rxy = R(p+1:p+j, 1:p);
        Ryx = Rxy';
        rvt = trace(Ryx*Rxy)/((trace(Ryy^2)*trace(Rxx^2))^0.5); % RV calculation
        if rvt > Rvmax
          Rvmax = rvt;                         % test of RV
          vrt(j) = vt(k);                      % temporary held variable
        end
      end
      vr(j) = vrt(j);                          % Result: variable
      RV(j) = Rvmax;                           % Result: correlation
      f = find(vt~=vr(j));                     % identify the held variable
      vt = vt(f);                              % reidentify variables to test
    end
#  timing = toc;
#  cumulate = cumulate + timing;
end

