
function drv_closure

%%
%% Driver for the transitive closure of a directed graph.
%%

t1 = clock;

N = 256;

[t2, B] = closure(N);

t3 = clock;

% Display result.
% disp(B);
disp(mean(B(:)));

% Display timings.
fprintf(1, 'CLOSURE: init = %f, exec = %f, total = %f\n', ...
(t2-t1)*[0 0 86400 3600 60 1]', (t3-t2)*[0 0 86400 3600 60 1]', ...
(t3-t1)*[0 0 86400 3600 60 1]');


