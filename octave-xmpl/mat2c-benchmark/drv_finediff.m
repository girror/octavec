
function drv_finediff

%%
%% Driver for finite-difference solution to the wave equation.
%%

t1 = clock;

a = 2.5;
b = 1.5;
c = 0.5;
n = 451;
m = 451;

U = finediff(a, b, c, n, m);

t2 = clock;

% Display result.
% disp(U);
disp(mean(U(:)));

% Display timings.
fprintf(1, 'FINEDIFF: total = %f\n', (t2-t1)*[0 0 86400 3600 60 1]');


