cport = 6;
fn = 'data/15-06-2018__c2.mat';

c1 = '0xD073CDA6';
c2 = '0xFEDBFF57';
c3 = '0x62ffdfff';

setpref('dsp','portaudioHostApi',3) 

try
	
	openCom(cport);
	setup_beacon(10000,c2,2500,2500);
	pause(0.1);
	EPOCommunications('transmit','A1');
	pause(0.5);
	rec = record();
	times = ch_td(rec,360,360);
	pos = loc2(times);
% 	save(fn,'rec');
	pause(0.1);
	closeCom();
	
	
	figure;
	plot(rec);
	pause(1.5);
% 	close all;
	
catch
	closeCom();
end