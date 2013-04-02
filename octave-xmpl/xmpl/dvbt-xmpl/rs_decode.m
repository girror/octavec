function data_out = rs_decode (data_in)

  fprintf ('    rs_decode (%d)\n', length(data_in));

  global PACKET_LENGTH;
  global RS_PARITY_BYTES;
  
  % do "perfect-transmission RS", i.e.,
  % just fake the parity bits
  if length(data_in) ~= PACKET_LENGTH+RS_PARITY_BYTES
    fprintf('error: rs_decode: packet size %d is not expected %d.\n',...
	    length(data_in), PACKET_LENGTH+RS_PARITY_BYTES);
    return;
  end
  if data_in(PACKET_LENGTH+1:PACKET_LENGTH+RS_PARITY_BYTES)...
	~= zeros(RS_PARITY_BYTES,1)
    fprintf('error: parity\n');
  end
  
  data_out=data_in(1:PACKET_LENGTH);
