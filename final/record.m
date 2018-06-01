function [ rec, ind ] = record()
%RECORD Summary of this function goes here
%   Detailed explanation goes here
	
	%	setup of the threshold and recording values
	nmic = 5; % Amount of microphones being used
	thresh = 0.002;
	th = zeros(nmic,1);
	firstchannel = 1;
	lastchannel = nmic; % microphones to use, as they are numbered
	Fs = 48000;
    
	setup_beacon(10000,'0x62ffdfff',2500,2500);
	pause(0.1)
	EPOCommunications('transmit','A1');
	pause(0.1)
	
	rec = pa_wavrecord(firstchannel, lastchannel, 12000,48e3,0,'asio'); % recorded sample for threshold detection
	
	ind = zeros(1,nmic+1);
	for i = 1:nmic
		ind(i) = find(rec(:,i) >= thresh,1);
		if ind(i) <= 50
			ind(i) = find(rec(ind(i)+4000:end,i) >= thresh,1);
		end
	end
	ind(nmic+1) = min(ind);
	rec = rec(ind(nmic+1)-50:ind(nmic+1)+4000);
	
% 	plot(rec(ind-50:ind+4000));	
	EPOCommunications('transmit','A0');
	closeCom()
end
	