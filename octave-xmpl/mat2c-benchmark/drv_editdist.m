
function drv_editdist

%%
%% Driver for the edit distance between two strings.
%%

t1 = clock;

N = ceil(rand*269);

s1 = round(rand(1, N));
s2 = round(rand(1, N));

d = editdist(s1, s2);

t2 = clock;

% Display result.
% disp(d);
disp(mean(d(:)));

% Display timings.
fprintf(1, 'EDITDIST: total = %f\n', (t2-t1)*[0 0 86400 3600 60 1]');


