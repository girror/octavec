function outer_interleave_tb
%%source(".m");
  
global_settings;

global PACKET_LENGTH;
global RS_PARITY_BYTES;
global OI_PACKETS_TO_TRASH;

rs_length=PACKET_LENGTH+RS_PARITY_BYTES;

count=16;

x = (1:rs_length)' * ones (1,count) + ones (rs_length,1) * (1i * (1:count));
y = zeros(rs_length,count+OI_PACKETS_TO_TRASH);
z = zeros(rs_length,count+OI_PACKETS_TO_TRASH);

for k = 1:count

  y(:,k) = outer_interleave (x(:,k));

  z(:,k) = outer_deinterleave (y(:,k));

end

for k = 1:OI_PACKETS_TO_TRASH

  y(:,count+k) = outer_interleave (zeros(rs_length,1));

  z(:,count+k) = outer_deinterleave (y(:,count+k));
  
end

trash = z(:,1:OI_PACKETS_TO_TRASH);
z = z(:,1+OI_PACKETS_TO_TRASH:count+OI_PACKETS_TO_TRASH);

if all(all(z == x)) & all(all(trash == zeros(rs_length,OI_PACKETS_TO_TRASH)));
  fprintf('outer interleaver works');
else
  fprintf('error in outer interleaver');
end
