
function drv_dirich

%%
%% Driver for the Dirichlet solution to Laplace's equation.
%%

t1 = clock;

a = 4;
b = 4;
h = 0.1;
tol = 0.0001;
max1 = 200;

f1 = 20;
f2 = 180;
f3 = 80;
f4 = 0;

U = dirich(f1, f2, f3, f4, a, b, h, tol, max1);

t2 = clock;

% Display result.
% disp(U);
disp(mean(U(:)));

% Display timings.
fprintf(1, 'DIRICH: total = %f\n', (t2-t1)*[0 0 86400 3600 60 1]');


