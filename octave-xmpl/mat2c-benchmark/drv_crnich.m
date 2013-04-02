
function drv_crnich

%%
%% Driver for the Crank-Nicholson solution to the
%% one-dimensional heat equation.
%%

t1 = clock;

a = 2.5; % a = rand*3;
b = 1.5; % b = 1.5;
c = 2; % c = 2;
m = 321; % n = floor(rand*1389);
n = 321; % n = floor(rand*529);

U = crnich(a, b, c, n, m);

t2 = clock;

% Display result.
% disp(U);
disp(mean(U(:)));

% Display timings.
fprintf(1, 'CRNICH: total = %f\n', (t2-t1)*[0 0 86400 3600 60 1]');


