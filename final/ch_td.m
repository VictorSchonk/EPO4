function [outArray] = ch_td(ipArg,x_co,y_co) %,
%CH_TD Calculate the vector of differences in centimeters from the
%centerlines of all microphone pairs
%
%   ipArg		|	A [Trec*Fs x 5] array. Of the recorded peak from the 5 microphones
%	x_co		|	Last x coordinate
%	y_co		|	Last y coordinate
%---------------
%	mf = 4		|	The threshold multiplication value to check if samples are
%					vallid.
%	Fs = 48000	|	The sample frequency. Which is 48000 in the final
%					challenge.
%---------------
%	outArray	|	Array of the difference values in centimeters from the
%					corresponding microphone pairs.
%					(r12,r13,r14,r15,r23,r24,r25,r34,r35,r45)

	mf = 3;
	Fs = 48000;
	
	%Distance from the last location to each microphone
	d1 = sqrt((460-x_co)^2 + (y_co)^2);
	d2 = sqrt(x_co^2 + y_co^2);
	d3 = sqrt((x_co)^2 + (460-y_co)^2);
	d4 = sqrt((460-x_co)^2 + (460-y_co)^2);
	d5 = sqrt((230-x_co)^2 + (460-y_co)^2);
	d = [d1,d2,d3,d4,d5];
	for i = 1:5
		if d(i) == min(d)
			n = i;
		end
	end
	
	%Determine bin mid to look for channel peak
	for i = 1:5
		if i == n
			b(i) = 90;
		else
			b(i) = 90 + d(i)*Fs/34300;
		end
	end
	
% REFERENCE SIGNAL FOR CHANNEL ESTIMATION
	micn = 3;
	load('data\refref3.mat','refref');
	x = squeeze(refref(:,micn));

	tic;
	h1 = abs(ch3(x,squeeze(ipArg(:,1))));
	h2 = abs(ch3(x,squeeze(ipArg(:,2))));
	h3 = abs(ch3(x,squeeze(ipArg(:,3))));
	h4 = abs(ch3(x,squeeze(ipArg(:,4))));
	h5 = abs(ch3(x,squeeze(ipArg(:,5))));
	h = [h1,h2,h3,h4,h5];
	clear h1 h2 h3 h4 h5;
	h = h(1:950,:);
	plot(h);
toc
	%12
	r12 = ch_td_pair(h(:,2),h(:,1),mf,Fs,b(2),b(1));
	%13
	r13 = ch_td_pair(h(:,3),h(:,1),mf,Fs,b(3),b(1));
	%14
	r14 = ch_td_pair(h(:,4),h(:,1),mf,Fs,b(4),b(1));
	%15
	r15 = ch_td_pair(h(:,5),h(:,1),mf,Fs,b(5),b(1));
	%23
	r23 = ch_td_pair(h(:,3),h(:,2),mf,Fs,b(3),b(2));
	%24
	r24 = ch_td_pair(h(:,4),h(:,2),mf,Fs,b(4),b(2));
	%25
	r25 = ch_td_pair(h(:,5),h(:,2),mf,Fs,b(5),b(2));
	%34
	r34 = ch_td_pair(h(:,4),h(:,3),mf,Fs,b(4),b(3));
	%35
	r35 = ch_td_pair(h(:,5),h(:,3),mf,Fs,b(5),b(3));
	%45
	r45 = ch_td_pair(h(:,5),h(:,4),mf,Fs,b(5),b(4));
	
	outArray = [r12,r13,r14,r15,r23,r24,r25,r34,r35,r45];

end

