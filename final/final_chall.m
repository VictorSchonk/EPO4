cport = 6;		% Com port to use.

try
	
	openCom(cport);
	
	setup_beacon(10000,'0x62ffdfff',2500,2500);
	pause(0.1)
	EPOCommunications('transmit','A1');
	
	
	
	closeCom();
	
catch
	closeCom();
end