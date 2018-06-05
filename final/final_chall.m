cport = 6;		% Com port to use.
q = 0;

try
	
	openCom(cport);
	
	setup_beacon(10000,'0x62ffdfff',2500,2500);
	pause(0.1)
	EPOCommunications('transmit','A1');
	
	while not(q)
		
		rec = record();
		times = ch_td(rec);
		pos = loc(times);
		
		q = 1; % Exit first while loop when close enough to the waypoint
		
	end
	
	input("Press enter to continue to the next waypoint.");
	q = 0;
	
	while not(q)
		
		rec = record();
		%	Chanel estimation stuff for TDOA's
		pos = loc();
		
		q = 1; % Exit second while loop when waypoint is reached
		
	end
	
	closeCom();
	
catch
	closeCom();
end