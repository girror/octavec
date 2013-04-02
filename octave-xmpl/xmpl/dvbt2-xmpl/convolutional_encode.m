function [x, y] = convolutional_encode (data)

  fprintf ('    convolutional_encode (%d)\n', length(data));

  global INIT_CONV_REGISTER;
  
  global dvbt_send_current_packet;
  global dvbt_send_conv_register;

  x=zeros(length(data),1);
  y=zeros(length(data),1);
  for k = 1:length(data)
    data_in=data(k);

    x(k) = data_in;
    for v = [1 2 3 6]
      x(k) = xor(x(k), dvbt_send_conv_register(v));
    end
    
    y(k) = data_in;
    for v = [2 3 5 6]
      y(k) = xor(y(k), dvbt_send_conv_register(v));
    end

    dvbt_send_conv_register=[data_in dvbt_send_conv_register(2:6)];
  end