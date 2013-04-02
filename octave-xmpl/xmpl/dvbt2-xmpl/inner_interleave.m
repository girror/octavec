function [data_out] = inner_interleave (data_in)

  fprintf ('    inner_interleave (%d)\n', length(data_in));

  global II_BLOCK_SIZE;
  global OFDM_SYMBOL_SIZE;
  global QAM_MODE;
  global SEND_EVEN_SYMBOL;
  global Hq;
  
  sblock_size=II_BLOCK_SIZE*log2(QAM_MODE);
  
  [symbol_size, should_be_one] = size (data_in);
  num_blocks=symbol_size/sblock_size;
  if rem(symbol_size,sblock_size) ~= 0
    fprintf('error: symbol size %d does not match block size %d\n',...
	    symbol_size, sblock_size);
    return;
  end

  y = zeros (OFDM_SYMBOL_SIZE, log2(QAM_MODE));
  for i = 1:num_blocks
    x=data_in(1+(i-1)*sblock_size:i*sblock_size);

    % Step 1: Demultiplexer
    a=reshape (x, log2(QAM_MODE), II_BLOCK_SIZE)';
    b=zeros (II_BLOCK_SIZE, log2(QAM_MODE));
    
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
      b(:,1+mapping(k)) = a(:,k);
    end

    [should_be_log2_qam_mode, should_be_ii_block_size] = size (b);

    % Step 2: Bit Interleaver
    a=zeros (II_BLOCK_SIZE, log2(QAM_MODE));
    h_param=[0 63 105 42 21 84];
    for e = 0:log2(QAM_MODE)-1
      for w = 0:II_BLOCK_SIZE-1
	% compute H(e,w)
	h=rem(w+h_param(1+e), II_BLOCK_SIZE);
	a(1+w,1+e)=b(1+h,1+e);
      end
    end

    y(1+(i-1)*II_BLOCK_SIZE:i*II_BLOCK_SIZE,:) = a;
  end
  
  % Step 3: Symbol Interleaver
  data_out = zeros (OFDM_SYMBOL_SIZE, log2(QAM_MODE));
  for i = 1:OFDM_SYMBOL_SIZE
    if SEND_EVEN_SYMBOL
      data_out(1+Hq(i),:) = y(i,:);
    else
      data_out(i,:) = y(1+Hq(i),:);
    end
  end  

  SEND_EVEN_SYMBOL = ~SEND_EVEN_SYMBOL;