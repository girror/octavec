%%source(".m");

function dvbt_tb
 
global_settings; 

global NET_PACKET_LENGTH;


input_file = fopen ([getenv('MOUSE_TOP') '/app/dvbt/demo_head.mpg'], 'r');

while ~ feof (input_file)

  data_in= [1.0]
  [ data_in, count ] = fread (input_file, NET_PACKET_LENGTH);
   disp(data_in);

  if count ~= 0
    fprintf ('reading block of length %d\n', count);

    % zero pad block
    if count < NET_PACKET_LENGTH
      data_in = [ data_in ; zeros(NET_PACKET_LENGTH - count,1) ];
    end

    data_channel_in = dvbt_send (data_in);
    data_channel_out = channel_model (data_channel_in);
    data_out = dvbt_receive (data_channel_out);

    if data_in == data_out
      fprintf ('send&receive of %d bytes successful\n', length(data_in));
    else
      fprintf ('**error**\n');
      return;
    end
    fprintf ('\n');
  end
end

fclose (input_file);
end
 