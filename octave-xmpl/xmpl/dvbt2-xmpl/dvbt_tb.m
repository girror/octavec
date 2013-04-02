%%source(".m");

global_settings;

global NET_PACKET_LENGTH;
global OI_PACKETS_TO_TRASH;

input_file = fopen ([getenv('MOUSE_TOP') '/app/dvbt/demo_head.mpg'], 'r');

queue = [];

trashed_packet_count=0;

while ~ feof (input_file)
  
  % get an MPEG transport MUX packet into a row vector
  [ data_in, count ] = fread (input_file, NET_PACKET_LENGTH);
  
  if count ~= 0
    fprintf ('reading block of length %d\n', count);

    % zero pad block
    if count < NET_PACKET_LENGTH
      data_in = [ data_in ; zeros(NET_PACKET_LENGTH-count,1) ];
    end
    if isempty(queue)
      queue = data_in;
    else
      queue = [ queue , data_in ];
    end

    data_channel_in = dvbt_send (data_in);
    data_channel_out = channel_model (data_channel_in);
    data_out = dvbt_receive (data_channel_out);

    if trashed_packet_count < OI_PACKETS_TO_TRASH
      [should_be_packet_size, packets_out] = size(data_out);
      while packets_out > 0
	if (trashed_packet_count < OI_PACKETS_TO_TRASH)
	  data_out = data_out(:,2:packets_out);
	  packets_out = packets_out-1;
	  trashed_packet_count = trashed_packet_count+1;
	  fprintf ('ignoring initial packet %d\n', trashed_packet_count);
	else
	  break;
	end
      end
    end
    
    [should_be_packet_size, packets_in] = size(queue);
    [should_be_packet_size, packets_out] = size(data_out);
    for i = 1:packets_out
      send_packet=queue(:,i);
      receive_packet=data_out(:,i);
      if send_packet == receive_packet
	fprintf ('send&receive of %d bytes successful\n',...
		 length(send_packet));
      else
	fprintf ('**error**\n');
	return;
      end
      fprintf ('\n');
    end
    queue = queue(:,packets_out+1:packets_in);
  end
end

fclose (input_file);
