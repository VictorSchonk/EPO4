cport = 6;
fn = 'data/15-06-2018_extra_M1.mat';

c2 = '0xFEDBFF57';

setpref('dsp','portaudioHostApi',3) 

try
	
	openCom(cport);
	setup_beacon(3750,c2,15000,4000);
	pause(0.1);
	EPOCommunications('transmit','A1');
	pause(0.5);
	rec = record();
	times = ch_td(rec,360,360);
	pos = loc2(times);
	save(fn,'rec');
	pause(0.1);
	closeCom();
	
	
	figure;
	plot(rec);
	pause(1.5);
% 	close all;
	
catch
	closeCom();
end