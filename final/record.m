function [ rec_out ] = record()
%RECORD This function is used to simplify the recording of the 0.25 second
%audio clips and then resize them so that the correct interval is returned.
%   
%	rec			| The [4050 x nmic] array of audio data
	
% % 	nmic = 5;			% Amount of microphones being used
% % 	Fs = 48000;
	
	rec = pa_wavrecord(1, 5, 24000,48e3,0,'asio'); % recorded sample for threshold detection
	
	rec_out = rec_cut(rec);
	
end
	