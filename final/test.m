syms x1 x2 x3 x4 r12 r13 r14 r23 r24 r34 x d2 d3 d4 lx1 lx2 lx3 lx4

% rij is the tdoa or the distance from the center. 
% xi is the vector with [x;y] as the x and y position of that microphone.
% di are nuisance parameters
% lxi is the length of the vector xi

tic;

A = [2*(x2-x1).' -2*r12 0 0;...
	2*(x3-x1).' 0 -2*r13 0;...
	2*(x4-x1).' 0 0 -2*r14;...
	2*(x3-x2).' 0 -2*r23 0;...
	2*(x4-x2).' 0 0 -2*r24;...
	2*(x4-x3).' 0 0 -2*r34];

y = [x;d2;d3;d4];

B = [r12^2-lx1^2+lx2^2;...
	r13^2-lx1^2+lx3^2;...
	r14^2-lx1^2+lx4^2;...
	r23^2-lx2^2+lx3^2;...
	r24^2-lx2^2+lx4^2;...
	r34^2-lx3^2+lx4^2];

C = inv(A.'*A)*A.';

y = C*B;

toc

% ---------------------------------------------------

load('auto_corr_code_bin.mat')

hexval = binaryVectorToHex(auto_corr_code)

% ---------------------------------------------------

%
%	Samples to be used before end of array 4800
%	intense peak is 700 samples big

%
%	5574 - 9574
% figure
% hold on
% for i = 1:5
% 	plot(RXXr(1,:,i))
% end
% line([5574 5574],[-1 1]);
% line([9574 9574],[-1 1]);
% line([0 12000],[0.004 0.004]);

%
%	Normalising is an option to simplify threshold stuff
%
%	Threshold crossing
%	From then 4000 samples 
%	Compare
%	Repeat

%
%	Needed variables for audio transmission:
%		-Code in hex format
%		-nSamplesRec
%

%	pa_wavrecord(firstchannel, lastchannel, nsamples,samplerate,deviceid,devicetype)
%    - firstchannel	the first input channel to record from
%    - lastchannel  the last input channel to record from
%    - nsamples 	the number of samples to record from each channel
%    - samplerate	the sampling frequency. Default: 44100
%    - deviceid 	the device id to use for INPUT. Default: 0
%    - informat     the desired data type of inputbuffer. Valid types
%                   and the number of bits per sample are as follows:
%    - devicetype   determines which sound driver to use
%        'win'      Windows Multimedia Device
%        'dx'       DirectX DirectSound driver
%        'asio'     ASIO Driver (default)
%    - inputbuffer 	is a variable that will hold the recorded audio, 
%                   running along rows, with a seperate column for 
%                   each channel


%
%	!!! Open the correct com port !!!
%

%	setup of the threshold and recording values
nmic = 4; % Amount of microphones being used
tresh = 0.004;
th = zeros(nmic,1);
firstchannel = 1;
lastchannel = nmic; % microphones to use, as they are numbered

%	setup of the microphone position matrix to use an analysation function
%	in a simple way

run = 1;

while run
	%	Threshold part (1 sample)
	th = pa_wavrecord(firstchannel, lastchannel, 1,48e3,0,'asio'); % recorded sample for threshold detection
	if max(th) >= tresh
		%	Record part (4000 samples)
		th = zeros(nmic,1);
		rec = pa_wavrecord(firstchannel, lastchannel, 4000,48e3,0,'asio'); % recording to analyse
		%	Analysation part
		
	else
		th = zeros(nmic,1);
	end
	
	% Other processes like sensors() and driving the car
	
end






