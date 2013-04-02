%%source(".m");

global_settings;

global OFDM_SYMBOL_SIZE;
global CARRIER_COUNT;
global ALPHA;

x = round(rand(OFDM_SYMBOL_SIZE,4))/ALPHA;
y = zeros(CARRIER_COUNT,4);
z = zeros(OFDM_SYMBOL_SIZE,4);

for i = 1:4
  y(:,i) = insert_reference_signals (x(:,i));

  z(:,i) = remove_reference_signals (y(:,i));
end

if z == x
  fprintf('reference_signals works');
else
  fprintf('error in reference_signals');
end