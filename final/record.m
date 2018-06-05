function [ rec ] = record()
%RECORD This function is used to simplify the recording of the 0.25 second
%audio clips and then resize them so that the correct interval is returned.
%   
%	rec			| The [4050 x nmic] array of audio data
	
	%	setup of the threshold and recording values
	nmic = 5;			% Amount of microphones being used
	thresh = 0.01;		% Treshold value to detect when something is transmitted
	lastchannel = nmic; % microphones to use, as they are numbered
% % 	Fs = 48000;
    
% 	setup_beacon(10000,'0x62ffdfff',2500,2500);
% 	pause(0.1)
% 	EPOCommunications('transmit','A1');
% 	pause(0.1)
	
	rec = pa_wavrecord(1, lastchannel, 12000,48e3,0,'asio'); % recorded sample for threshold detection
	
	try
		ind = zeros(nmic+1,1);
		for i = 1:nmic
			ind(i,:) = find(rec(:,i) >= thresh,1);
			if ind(i,:) <= 50
				ind(i,:) = find(rec(ind(i)+4000:end,i) >= thresh,1);
			end
		end
		ind(nmic+1) = min(ind);
		rec = rec(ind(nmic+1,:)-50:ind(nmic+1,:)+4000);
	catch
		rec = rec;
	end
	
% 	plot(rec(ind-50:ind+4000));	
% 	EPOCommunications('transmit','A0');
% 	closeCom()
end
	