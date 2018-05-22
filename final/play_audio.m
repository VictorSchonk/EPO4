cport = 6;
fb = 2500;
code = '0x32f21dff';
fc = 10000;
rc = 250;

try
	openCom(cport);
	setup_beacon(fb,code,fc,rc);
	closeCom();
catch
	closeCom();
end