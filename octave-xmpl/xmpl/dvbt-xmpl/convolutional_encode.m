function [x, y] = convolutional_encode (data)

  fprintf ('    convolutional_encode (%d)\n', length(data));

  global INIT_CONV_REGISTER;
  
  global dvbt_send_current_packet;
  global dvbt_send_conv_register;

  if dvbt_send_current_packet == 0
    dvbt_send_conv_register=INIT_CONV_REGISTER;
  end

  x=zeros(length(data),1);
  y=zeros(length(data),1);
  for i = 1:length(data)
    data_in=data(i);

    x(i) = data_in;
    for j = [1 2 3 6]
      x(i) = xor(x(i), dvbt_send_conv_register(j));
    end
    
    y(i) = data_in;
    for j = [2 3 5 6]
      y(i) = xor(y(i), dvbt_send_conv_register(j));
    end

    dvbt_send_conv_register=[data_in dvbt_send_conv_register(2:6)];
  end