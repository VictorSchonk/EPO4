cport = 4;		% Com port to use.
q = 0;

try
	
	openCom(cport);
	
	setup_beacon(10000,'0x62ffdfff',2500,2500);
	pause(0.1)
	EPOCommunications('transmit','A1');
	
	while not(q)
		
		rec = record();
		times = ch_td(rec);
		
	end
	
	input("Press enter to continue to the next waypoint.");
	q = 0;
	
	while not(q)
		
	end
	
	rec = record();
	
	EPOCommunications('transmit','A0');
	
	closeCom();
	
catch
	closeCom();
end