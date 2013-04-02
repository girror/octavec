%%source(".m");
  
global_settings;

% Let x be a vector of 6048 rows..
x = 1:6048;
x = x';

y = inner_interleave (x);

z = inner_deinterleave (y);

if z == x
  fprintf('inner interleaver works');
else
  fprintf('error in inner interleaver');
end
