cport = 5;
fn = 'filename.mat';

try
	
	openCom(cport);
	setup_beacon(10000,'0x62ffdfff',2500,2500);
	pause(0.1);
	EPOCommunications('transmit','A1');
	pause(0.5);
	rec = record();
	save(fn,'rec');
	pause(0.1);
	closeCom();
	
catch
	closeCom();
end