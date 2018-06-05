cport = 4;		% Com port to use.
q = 0;

try
	
	openCom(cport);
	
	setup_beacon(10000,'0x62ffdfff',2500,2500);
	pause(0.1)
	EPOCommunications('transmit','A1');
	
	while not(q)
		
		rec = record();		% Record 24000 samples.
		times = ch_td(rec);	% Calculate all the times.
		pos = loc(times);	% Calculate the position.
		break;
		
	end
	
	input("Press enter to continue to the next waypoint.");
	q = 0;
	
	while not(q)
		
		rec = record();		% Record 24000 samples.
		times = ch_td(rec);	% Calculate all the times.
		pos = loc(times);	% Calculate the position.
		break;
		
	end
	
% 	rec = record();
	
	EPOCommunications('transmit','A0');
	
	closeCom();
	
catch
	closeCom();
end