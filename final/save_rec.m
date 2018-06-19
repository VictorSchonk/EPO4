cport = 7;
fn = 'data/19-06-2018_M.mat';

% c2 = '0xFEDBFF57';
c3 = '0xD073CDA6';

setpref('dsp','portaudioHostApi',3) 

try
	
	openCom(cport);
	
	pause(0.1);
	setup_beacon(3750,c3,10000,1250);
	pause(0.1);
	EPOCommunications('transmit','A1');
	pause(0.5);
	rec = record();
% 	times = ch_td(rec,360,360);
% 	pos = loc2(times,createmaze(1));
% 	fn = 'data/19-06-2018_m5_10k.mat';
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