
function drv_diffraction

%%
%% Driver for the diffraction pattern calculator.
%%

t1 = clock;

CELLS = 2;
SLITSIZE1 = 1e-5;
SLITSIZE2 = 1e-5;
T1 = 1;
T2 = 0;

mag = diffraction(CELLS, SLITSIZE1, SLITSIZE2, T1, T2);

t2 = clock;

% Display result.
% disp(mag);
disp(mean(mag(:)));

% Display timings.
fprintf(1, 'DIFFRACTION: total = %f\n', ...
(t2-t1)*[0 0 86400 3600 60 1]');


