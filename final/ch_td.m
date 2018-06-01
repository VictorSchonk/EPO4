function [outArray] = ch_td(ipArg)
%CH_TD Calculate the vector of differences in centimeters from the
%centerlines of all microphone pairs
%   ipArg		|	A 4050x5 array. Of the recorded peak from the 5 microphones
%
%	mf = 4		|	The threshold multiplication value to check if samples are
%					vallid.
%	Fs = 48000	|	The sample frequency. Which is 48000 in the final
%					challenge.
%
%	outArray	|	Array of the difference values in centimeters from the
%					corresponding microphone pairs.
%					(r12,r13,r14,r15,r23,r24,r25,r34,r35,r45)

	mf = 4;
	Fs = 48000;

	%12
	r12 = ch_td_pair(ipArg(:,1),ipArg(:,2),mf,Fs);
	%13
	r13 = ch_td_pair(ipArg(:,1),ipArg(:,3),mf,Fs);
	%14
	r14 = ch_td_pair(ipArg(:,1),ipArg(:,4),mf,Fs);
	%15
	r15 = ch_td_pair(ipArg(:,1),ipArg(:,5),mf,Fs);
	%23
	r23 = ch_td_pair(ipArg(:,2),ipArg(:,3),mf,Fs);
	%24
	r24 = ch_td_pair(ipArg(:,2),ipArg(:,4),mf,Fs);
	%25
	r25 = ch_td_pair(ipArg(:,2),ipArg(:,5),mf,Fs);
	%34
	r34 = ch_td_pair(ipArg(:,3),ipArg(:,4),mf,Fs);
	%35
	r35 = ch_td_pair(ipArg(:,3),ipArg(:,5),mf,Fs);
	%45
	r45 = ch_td_pair(ipArg(:,4),ipArg(:,5),mf,Fs);
	
	outArray = [r12,r13,r14,r15,r23,r24,r25,r34,r35,r45];

end

