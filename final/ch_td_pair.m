function [outArg] = ch_td_pair(h1,h2,mf,Fs,binc1,binc2)
%CH_TD_PAIR Seperate channel estimation and distance difference function
%   h1:			First channel estimation
%	h2:			Second channel estimation
%	mf:			Multiplication factor for the treshold
%	Fs:			Sample frequency of ipArg
%	binc1:		Center of the bin to look at for signal h1
%	binc2:		Center of the bin to look at for signal h2
%
%	outArg:		Output argument in centimeter difference from the
%		centerline of the two microphones.

	binw = 100; % Half the bin width to look at
	
	beg1 = round(binc1-binw);
	if beg1 < 1
		beg1 = 1;
	end
	end1 = round(binc1+binw);
	if end1 > 950
		end1 = 950;
	end
	beg2 = round(binc2-binw);
	if beg2 < 1
		beg2 = 1;
	end
	end2 = round(binc2+binw);
	if end2 > 950
		end2 = 950;
	end
    
% 	h1 = abs(ch3(x,ipArg1));			% Calculate the channel estimate from the two input signals
% 	h1 = h1(1:950);						% Cut to the maximal value due to size of field
	th1 = (exp(mf*mean(h1))-1);		% Calculate the first threshold value
	ch1 = exp(h1)-1;				% Exponentially scale the first channel estimate

	
%   h2 = abs(ch3(x,ipArg2));			% Calculate the channel estimate from the two input signals
% 	h2 = h2(1:950);						% Cut to the maximal value due to size of field
	th2 = (exp(mf*mean(h2))-1);		% Calculate the second threshold value
    ch2 = exp(h2)-1;				% Exponentially scale the second channel estimate
	
% 	figure;
% 	plot(linspace(beg1,end1,end1-beg1+1),ch1(beg1:end1));
% 	hold on;
% 	plot(linspace(beg2,end2,end2-beg2+1),ch2(beg2:end2));
% 	xlim([0 950]);
	
	if (max(ch1) < th1) || (max(ch2) < th2)
		outArg = 0;							% Output 0 if threshold is not reached
    else
        in1 = find(ch1(beg1:end1) == max(ch1(beg1:end1)),1) + beg1;
        in2 = find(ch2(beg2:end2) == max(ch2(beg2:end2)),1) + beg2;
		outArg = (in2-in1)*34300/Fs;	% Output the distance in centimeters from the center of the two microphopnes
	end

end