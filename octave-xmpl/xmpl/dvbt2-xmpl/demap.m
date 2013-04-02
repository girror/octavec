function data_out = demap (data_in)

  fprintf ('    demap (%d)\n', length(data_in));

  global QAM_MODE;
  global QAM_TABLE;
  global QAM_ROW;
  global QAM_COL;
  
  [symbol_size, should_be_log_qam_mode] = size (data_in);
  data_out = zeros (symbol_size, log2(QAM_MODE));
  for i = 1:symbol_size
    symbol = data_in(i,:);

    % Search bits in table
    d=inf;
    bitstring='XXXX';
    for r = 1:sqrt(QAM_MODE)
      for c = 1:sqrt(QAM_MODE)
	d1 = abs(symbol - (QAM_ROW(r)+QAM_COL(c)));
	if d1 < d
	  d = d1;
	  bitstring = sprintf ('%4.4d', QAM_TABLE(r,c));
	end
      end
    end
      
    % Make a string of bits from string
    bits = zeros (1, log2(QAM_MODE));
    for k = 1:log2(QAM_MODE)
      if bitstring(k) == '1'
	bits(k) = 1;
      else
	bits(k) = 0;
      end
    end
    
    data_out(i,:) = bits;
  end

