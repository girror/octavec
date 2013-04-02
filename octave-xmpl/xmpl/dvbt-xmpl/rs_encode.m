function data_out = rs_encode (data_in)

  fprintf ('    rs_encode (%d)\n', length(data_in));

  global PACKET_LENGTH;
  global RS_PARITY_BYTES;
  
  % do "perfect-transmission RS", i.e.,
  % just fake the parity bits
  if length(data_in) ~= PACKET_LENGTH
    fprintf('error: rs_endcode: packet size %d is not expected %d.\n',...
	    length(data_in), PACKET_LENGTH);
    return;
  end
  data_out=[data_in ; zeros(RS_PARITY_BYTES,1)];