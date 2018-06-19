cport = 7;
fn = 'data/15-06-2018_extra_m2_8k.mat';

c2 = '0xFEDBFF57';
c3 = '0xD073CDA6';

setpref('dsp','portaudioHostApi',3) 

try
	
	openCom(cport);
% 	setup_beacon(3750,c3,8000,1250);
% 	pause(0.1);
% 	EPOCommunications('transmit','A1');
% 	pause(0.5);
% 	rec = record();
% 	fn = 'data/15-06-2018_extra_C_8k.mat';
% 	save(fn,'rec');
% 	pause(0.1);
% 	figure;
% 	plot(rec);
% 	
% 	pause(0.1);
% 	setup_beacon(3750,c3,10000,1250);
% 	pause(0.1);
% 	EPOCommunications('transmit','A1');
% 	pause(0.5);
% 	rec = record();
% 	fn = 'data/15-06-2018_extra_C_10k.mat';
% 	save(fn,'rec');
% 	pause(0.1);
% 	figure;
% 	plot(rec);
	
	pause(0.1);
	setup_beacon(3750,c3,10000,1250);
	pause(0.1);
	EPOCommunications('transmit','A1');
	pause(0.5);
	rec = record();
% 	times = ch_td(rec,360,360);
% 	pos = loc2(times,createmaze(1));
	fn = 'data/19-06-2018_C_10k.mat';
	save(fn,'rec');
	pause(0.1);
	closeCom();
	
% 	close all;
	figure;
	plot(rec);
% 	close all;
	
catch
	figure;
	plot(rec);
	closeCom();
end