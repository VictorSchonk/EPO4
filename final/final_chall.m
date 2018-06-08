cport = 3;		% Com port to use.
q = 1;

try
	
	openCom(cport);
	
	setup_beacon(10000,'0x62ffdfff',2500,2500);
	pause(0.1)
	EPOCommunications('transmit','A1');
	
	while not(q)
		
		rec = record();		% Record 24000 samples.
		times = ch_td(rec);	% Calculate all the times.
		pos = loc(times(1),times(2),times(3),times(4),times(5),times(6),times(7),times(8),times(9),times(10));	% Calculate the position.
		
		break;
		
	end
	
% 	input('Press enter to continue to the next waypoint.');
	q = 0;
	
	while not(q)
		
		rec = record();		% Record 24000 samples.
		times = ch_td(rec)	% Calculate all the times.
		pos = loc(times(1),times(2),times(3),times(4),times(5),times(6),times(7),times(8),times(9),times(10));	% Calculate the position.
		
		break;
		
	end
	
% 	rec = record();
	
	EPOCommunications('transmit','A0');
	
	closeCom();
	
catch
	closeCom();
end