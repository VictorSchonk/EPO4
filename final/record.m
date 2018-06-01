function [ rec ] = record()
%RECORD Summary of this function goes here
%   Detailed explanation goes here
	
	%	setup of the threshold and recording values
	nmic = 5; % Amount of microphones being used
	thresh = 0.002;
	th = zeros(nmic,1);
	firstchannel = 1;
	lastchannel = nmic; % microphones to use, as they are numbered
	Fs = 48000;
    
	rec = pa_wavrecord(firstchannel, lastchannel, 12000,48e3,0,'asio'); % recorded sample for threshold detection
	ind = find(rec >= thresh,1);
	rec = rec(ind-50:ind+4000);
% 	plot(rec(ind-50:ind+4000));	
	



