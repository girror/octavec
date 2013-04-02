
function drv_nbody3d

%%
%% Driver for the N-body problem coded using 3d arrays for the
%% displacement vectors.
%%

t1 = clock;

n = floor(28*rand);
dT = rand*0.0833;
T = rand*32.4362;

R = rand(n, 3)*1000.23;

m = rand(n, 1)*345;

[F, V] = nbody3d(n, R, m, dT, T);

t2 = clock;

% Display result.
% disp(F);
% disp(V);
disp(mean(F(:)));
disp(mean(V(:)));

% Display timings.
fprintf(1, 'NBODY3D: total = %f\n', (t2-t1)*[0 0 86400 3600 60 1]');


