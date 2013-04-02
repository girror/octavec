%%source(".m");
  
global_settings;

count = 4;
data_in = zeros(256*8,count);
data_out = zeros(256*8, count);

data_in(:,1) = bit_from_byte_vector ((0:255)');
for k = 2:count
  data_in(:,k) = round(rand(256*8,1));
end

for k = 1:count
  [x, y] = convolutional_encode (data_in(:,k));
  
  data_out(:,k) = convolutional_decode (x, y);
end

if data_in == data_out
  fprintf('convolutional encoder works\n');
else
  fprintf('error in convolutional encoder\n');
end
