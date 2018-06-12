function [outArray] = ch_td(ipArg) %,x_co,y_co
%CH_TD Calculate the vector of differences in centimeters from the
%centerlines of all microphone pairs
%
%   ipArg		|	A [Trec*Fs x 5] array. Of the recorded peak from the 5 microphones
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
	
% % 	load('data/reference_05-06-2018_2.mat','x'); % Load the refence signal for channel estimation.
% 	load('data\08-06-2018_mic_1.mat','rec');
	load('data\ref_mic5.mat','ref5');
	x = ref5(:,1);

% 	y_co = 2;
% 	x_co = 4;
% 	
% 	load('data\ref_sig.mat','ref');
% 	if y_co >= x_co % At the side of microphone 3 of the field
% 		x = ref(:,1); % Use the refenece from microphone 1
% 	else % At the side of microphone 1 of the field
% 		x = ref(:,2); % Use the reference from microphone 3
% 	end
	
	h1 = abs(ch3(x,ipArg(:,1)));
	h2 = abs(ch3(x,ipArg(:,2)));
	h3 = abs(ch3(x,ipArg(:,3)));
	h4 = abs(ch3(x,ipArg(:,4)));
	h5 = abs(ch3(x,ipArg(:,5)));
	h = [h1,h2,h3,h4,h5];
	h = h(1:950,:);

	%12
	r12 = ch_td_pair(h(:,1),h(:,2),mf,Fs);
	%13
	r13 = ch_td_pair(h(:,1),h(:,3),mf,Fs);
	%14
	r14 = ch_td_pair(h(:,1),h(:,4),mf,Fs);
	%15
	r15 = ch_td_pair(h(:,1),h(:,5),mf,Fs);
	%23
	r23 = ch_td_pair(h(:,2),h(:,3),mf,Fs);
	%24
	r24 = ch_td_pair(h(:,2),h(:,4),mf,Fs);
	%25
	r25 = ch_td_pair(h(:,2),h(:,5),mf,Fs);
	%34
	r34 = ch_td_pair(h(:,3),h(:,4),mf,Fs);
	%35
	r35 = ch_td_pair(h(:,3),h(:,5),mf,Fs);
	%45
	r45 = ch_td_pair(h(:,4),h(:,5),mf,Fs);
	
	outArray = [r12,r13,r14,r15,r23,r24,r25,r34,r35,r45];

end

