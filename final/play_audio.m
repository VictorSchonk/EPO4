cport = 6;
fb = 2500;
code = '0x32f21dff';
fc = 10000;
rc = 250;

recObj = audiorecorder(44100,24,2);
record(recObj, 10);

try
	openCom(cport);
	pause(0.01);
	setup_beacon(fb,code,fc,rc);
	EPOCommunications('transmit','A1');
	pause(5);
	EPOCommunications('transmit','A0');
	pause(0.01);
	closeCom();
catch
	stop();
end