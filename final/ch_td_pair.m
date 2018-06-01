function [outArg] = ch_td_pair(ipArg1,ipArg2,mf,Fs)
%CH_TD_PAIR Seperate channel estimation and distance difference function
%   ipArg1:		Microphone 1 input
%	ipArg2:		Microphone 2 input
%	mf:			Multiplication factor for the treshold
%	Fs:			Sample frequency of ipArg
%
%	outArg:		Output argument in centimeter difference from the
%		centerline of the two microphones.

	h = abs(ch3(ipArg1,ipArg2));	% Calculate the channel estimate from the two input signals
	h = h(1:950);					% Cut to the maximal value due to size of field
	th = (exp(mf*mean(h))-1);		% Calculate the threshold value
	ch = exp(h)-1;					% Exponentially scale the channel estimate
	
	if max(ch) < th
		outArg = 0;							% Output 0 if threshold is not reached
	else
		outArg = find(max(ch))*34300/Fs;	% Output the distance in centimeters from the center of the two microphopnes
	end

end

