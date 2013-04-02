function data_out = map (data_in)

  fprintf ('    map (%d)\n', length(data_in));

  global QAM_MODE;
  global QAM_TABLE;
  global QAM_ROW;
  global QAM_COL;
  
  [symbol_size, should_be_log_qam_mode] = size (data_in);
  data_out = zeros (symbol_size, 1);
  for i = 1:symbol_size
    bits = data_in(i,:);

    % Make a string of bits
    bitstring='XXXX';
    for j = 1:log2(QAM_MODE)
      if bits(j) <= 0.5
	bitstring(j) = '0';
      else
	bitstring(j) = '1';
      end
    end

    % Search bits in table
    for r = 1:sqrt(QAM_MODE)
      for c = 1:sqrt(QAM_MODE)
	if sprintf('%4.4d', QAM_TABLE(r,c)) == bitstring
	  value = QAM_ROW(r) + QAM_COL(c);
	end
      end
    end

    data_out(i) = value;
  end

