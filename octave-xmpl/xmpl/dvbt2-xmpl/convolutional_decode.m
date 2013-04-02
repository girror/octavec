function data = convolutional_decode (x, y)

  fprintf ('    convolutional_decode (%d)\n', length(x));

  global INIT_CONV_REGISTER;
  
  global dvbt_receive_current_packet;
  global dvbt_receive_conv_register;

%%  if dvbt_receive_current_packet == 0
%%    dvbt_receive_conv_register=INIT_CONV_REGISTER;
%%  end

  data=zeros(length(x),1);
  for k = 1:length(data)
    data_x = x(k);
    for v = [1 2 3 6]
      data_x = soft_xor(data_x, dvbt_receive_conv_register(v));
    end
    
    data_y = y(k);
    for v = [2 3 5 6]
      data_y = soft_xor(data_y, dvbt_receive_conv_register(v));
    end
    
    if data_x == 0.5 & data_y == 0.5
      fprintf('warning: undefined symbol %d\n', k);
    end
    if (data_x < 0.5 & data_y > 0.5) ...
	  | (data_x > 0.5 & data_y < 0.5)
      fprintf('warning: contradicting symbol %d\n', k);
    end

    if data_x < 0.5 | data_y < 0.5
      data(k) = 0;
    elseif data_x > 0.5 | data_y > 0.5
      data(k) = 1;
    else
      fprintf('error: internal error at symbol %d\n', k);      
    end

    dvbt_receive_conv_register=[data(k) dvbt_receive_conv_register(2:6)];
  end