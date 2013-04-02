function [data_out] = inner_deinterleave (data_in)

  fprintf ('    inner_deinterleave (%d)\n', length(data_in));

  global II_BLOCK_SIZE;
  global OFDM_SYMBOL_SIZE;
  global OFDM_SYMBOL_LENGTH;
  global QAM_MODE;
  global RECEIVE_EVEN_SYMBOL;
  global Hq;
  
  sblock_size=II_BLOCK_SIZE*log2(QAM_MODE);
  
  [symbol_size, should_be_log2_qam_mode] = size (data_in);
  num_blocks=symbol_size/II_BLOCK_SIZE;
  if rem(symbol_size,sblock_size) ~= 0
    fprintf('error: symbol size %d does not match block size %d\n',...
	    symbol_size, sblock_size);
    return;
  end
  
  data_out = zeros (OFDM_SYMBOL_LENGTH, 1);

  % Step 1: Reverse Symbol Interleaver
  y = zeros (OFDM_SYMBOL_SIZE, log2(QAM_MODE));
  for i = 1:OFDM_SYMBOL_SIZE
    if RECEIVE_EVEN_SYMBOL
      y(i,:) = data_in(1+Hq(i),:);
    else
      y(1+Hq(i),:) = data_in(i,:);
    end
  end

  for i = 1:num_blocks
    a = y(1+(i-1)*II_BLOCK_SIZE:i*II_BLOCK_SIZE,:);

    % Step 2: Reverse Bit Interleaver
    b=zeros (II_BLOCK_SIZE, log2(QAM_MODE));
    h_param=[0 63 105 42 21 84];
    for e = 0:log2(QAM_MODE)-1
      for w = 0:II_BLOCK_SIZE-1
	% compute H(e,w)
	h=rem(w+h_param(1+e), II_BLOCK_SIZE);
	b(1+h,1+e) = a(1+w,1+e);
      end
    end
    
    % Step 3: Demultiplexer
    a = zeros (II_BLOCK_SIZE, log2(QAM_MODE));
    switch QAM_MODE
      case 4
	mapping=[0 1];
      case 16
	mapping=[0 2 1 3];
      case 64
	mapping=[0 2 4 1 3 5];
      otherwise
	fprintf ('inner interleave: QAM mode %g not implemented.\n', QAM_MODE);
	return
    end
    for k = 1:log2(QAM_MODE)
      a(:,k) = b(:,1+mapping(k));
    end

    data_out(1+(i-1)*sblock_size:i*sblock_size) =...
	reshape (a', sblock_size, 1);
  end

  RECEIVE_EVEN_SYMBOL = ~RECEIVE_EVEN_SYMBOL;