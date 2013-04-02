
function drv_nbody1d

%%
%% Driver for the N-body problem coded using 1d arrays for the
%% displacement vectors.
%%

t1 = clock;

n = floor(28*rand);
dT = rand*0.0833;
T = rand*32.4362;

Rx = rand(n, 1)*1000.23;
Ry = rand(n, 1)*1000.23;
Rz = rand(n, 1)*1000.23;

m = rand(n, 1)*345;

[Fx, Fy, Fz, Vx, Vy, Vz] = nbody1d(n, Rx, Ry, Rz, m, dT, T);

t2 = clock;

% Display result.
% disp(Fx), disp(Fy), disp(Fz);
% disp(Vx), disp(Vy), disp(Vz);
disp(mean(Fx(:))), disp(mean(Fy(:))), disp(mean(Fz(:)));
disp(mean(Vx(:))), disp(mean(Vy(:))), disp(mean(Vz(:)));

% Display timings.
fprintf(1, 'NBODY1D: total = %f\n', (t2-t1)*[0 0 86400 3600 60 1]');


