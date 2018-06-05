cport = 6;		% Com port to use.
q = 0;

try
	
	openCom(cport);
	
	setup_beacon(10000,'0x62ffdfff',2500,2500);
	pause(0.1)
	EPOCommunications('transmit','A1');
	
	while not(q)
		
	end
	
	input("Press enter to continue to the next waypoint.");
	q = 0;
	
	while not(q)
		
	end
	
	record();
	
	closeCom();
	
catch
	closeCom();
end