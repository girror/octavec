
function drv_adapt

%%
%% Driver for adaptive quadrature using Simpson's rule.
%%

t1 = clock;

a = -1;
b = 6;
sz_guess = 1;
tol = 1e-12;

[SRmat, quad, err] = adapt(a, b, sz_guess, tol);

t2 = clock;

% Display result.
% disp(SRmat), disp(quad), disp(err);
disp(mean(SRmat(:))), disp(mean(quad(:))), disp(mean(err(:)));

% Display timings.
fprintf(1, 'ADAPT: total = %f\n', (t2-t1)*[0 0 86400 3600 60 1]');


