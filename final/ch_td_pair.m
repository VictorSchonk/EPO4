function [outArg] = ch_td_pair(ipArg1,ipArg2,mf,Fs)
%CH_TD_PAIR Seperate channel estimation and distance difference function
%   ipArg1:		Microphone 1 input
%	ipArg2:		Microphone 2 input
%	mf:			Multiplication factor for the treshold
%	Fs:			Sample frequency of ipArg
%
%	outArg:		Output argument in centimeter difference from the
%		centerline of the two microphones.

    load('data/reference_05-06-2018.mat')
    
	h1 = abs(ch3(x,ipArg1));	% Calculate the channel estimate from the two input signals
	h1 = h1(1:950);					% Cut to the maximal value due to size of field
	th1 = (exp(mf*mean(h1))-1);		% Calculate the threshold value
	ch1 = exp(h1)-1;					% Exponentially scale the channel estimate
	
    h2 = abs(ch3(x,ipArg2));	% Calculate the channel estimate from the two input signals
	h2 = h2(1:950);					% Cut to the maximal value due to size of field
	th2 = (exp(mf*mean(h2))-1);		% Calculate the threshold value
    ch2 = exp(h2)-1;
    
    
    
    % 	figure;
% 	plot(ch);
	
	if (max(ch1) < th1) || (max(ch2) < th2)
		outArg = 0;							% Output 0 if threshold is not reached
    else
        in1 = find(ch1 == max(ch1),1);
        in2 = find(ch2 == max(ch2),1);
		outArg = (in2-in1)*34300/Fs;	% Output the distance in centimeters from the center of the two microphopnes
	end

end