
function drv_capacitor

%%
%% Driver to compute the capacitance of a transmission line using
%% finite difference and Gauss-Seidel iteration.
%%

%%% t1 = clock;

a = rand*2;
b = 8.65*rand;
c = 3.29*rand;
d = rand*6.171;

n = floor(56.0980*rand);
tol = 1e-9; % Tolerance.
rel = 1.90; % Relaxation parameter.
a = 34.4;
b = 8.65 * 0.34;
c = 3.29 * 0.23;
d = 6.171 * 0.655;
n = floor(56.0980 * 0.342);
t1 = clock;
cap = capacitor(a, b, c, d, n, tol, rel);

t2 = clock;

% Display result.
% disp(cap);
disp(mean(cap(:)));

% Display timings.
fprintf(1, 'CAPACITOR: total = %f\n', (t2-t1)*[0 0 86400 3600 60 1]');


