%%source(".m");
  
global_settings;

global OFDM_SYMBOL_SIZE;
global QAM_MODE;

pattern = [0 0 0 0 ;
	   0 0 0 1 ;
	   0 0 1 0 ;
	   0 0 1 1 ;
	   0 1 0 0 ;
	   0 1 0 1 ;
	   0 1 1 0 ;
	   0 1 1 1 ;
	   1 0 0 0 ;
	   1 0 0 1 ;
	   1 0 1 0 ;
	   1 0 1 1 ;
	   1 1 0 0 ;
	   1 1 0 1 ;
	   1 1 1 0 ;
	   1 1 1 1];

% Let x be an OFDM symbol
x = zeros (OFDM_SYMBOL_SIZE, log2(QAM_MODE));
x(1:16,:) = pattern;

y = map (x);

z = demap (y);

if z == x
  fprintf('mapper works');
else
  fprintf('error in mapper');
end