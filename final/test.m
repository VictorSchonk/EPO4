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

hexval = binaryVectorToHex(auto_corr_code);

% ---------------------------------------------------

for k = 1:9
	figure;
	hold on;
	for i = 1:4
		plot(RXXr(k,:,i))
	end
end

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
%	-----------------------------------------
%	|	m2								m3	|
%	|	(0,460)					(460,460)	|
%	|										|
%	|										|
%	|										|
%	|										|
%	|										|
%	|										|
%	|										|
%	|	(0,0)					(460,0)		|
%	|	m1								m4	|


%
%	!!! Open the correct com port !!!
%

%	setup of the threshold and recording values
nmic = 2; % Amount of microphones being used
tresh = 0.004;
th = zeros(nmic,1);
firstchannel = 1;
lastchannel = nmic; % microphones to use, as they are numbered

%	setup of the microphone position matrix to use an analysation function
%	in a simple way
%	x1	x2	x3	x4
%	y1	y2	y3	y4
m1 = [0;0];
m2 = [0;460];
m3 = [460;460];
m4 = [460;0];
ma = [m1,m2,m3,m4];

%	setup of the variable to keep the wile loop running
run = 1;

setup_beacon(10e3,'0x62ffdfff',25e2,25e1);
EPOCommunications('transmit','A1');

while run
	%	Threshold part (1 sample)
	th = pa_wavrecord(firstchannel, lastchannel, 1,48e3,0,'asio'); % recorded sample for threshold detection
	if max(th) >= tresh
		%	Record part (4000 samples)
		th = zeros(nmic,1);
		rec = pa_wavrecord(firstchannel, lastchannel, 4000,48e3,0,'asio'); % recording to analyse
		%	Analysation part
		% >TDOA
		% >half hyperbolic function (see wikipedia)
		% >intersection (take error into account)
	else
		th = zeros(nmic,1);
	end
	
	% Other processes like sensors() and driving the car
	run = 0;
end


EPOCommunications('transmit','A0');

% ---------------------------------------------------

figure;
hold on;
for i = 1:9
	mf = 4;
	h = abs(ch3(RXXr(7,6130:10180,1),RXXr(7,6130:10180,2)))(1:950);
	th = (exp(mf*mean(h(1:950)))-1);
	ch = exp(h)-1;
	plot(ch(1:950));
	hold on;
	line([0;950],[th;th]);
end

% if sample > 950 send NaN

% 1: 5040-9090
% 9: 5650-9700
% 6: 4000-8500
% 7: 6130-10180

% ---------------------------------------------------

load('D:\victor\Documents\Studie\EPO4\git_code\EPO4\final\data\05-06-2018_B.mat');
ipArg = rec;

load('data/reference_05-06-2018_2.mat','x'); % Load the refence signal for channel estimation.
h1 = abs(ch3(x,ipArg(:,1)));
h2 = abs(ch3(x,ipArg(:,2)));
h3 = abs(ch3(x,ipArg(:,3)));
h4 = abs(ch3(x,ipArg(:,4)));
h5 = abs(ch3(x,ipArg(:,5)));
h = [h1,h2,h3,h4,h5];
h = h(1:950,:);

% ---------------------------------------------------
% 				150 150		200 360		400 200		230 230
% position		A			B			C			M
% ch_td		12	-132.25		-32.25		238.41		0.0
% 			13	0.0			-220.47		268.27		0.0
% 			14	94.02		-165.50		58.03		0.0
% 			15	-24.23		-339.67		101.84		-95.27
% 			23	132.25		-188.22		29.86		0.0
% 			24	226.27		-133.26		-180.38		0.0
% 			25	108.02		-307.42		-136.57		-95.27
% 			34	94.02		54.96		-210.24		0.0
% 			35	-24.23		-199.20		-166.42		-95.27
% 			45	-118.25		-174.16		43.81		-95.27

% ---------------------------------------------------


if xa == xb
	
elseif xa > xb
	for th = 1:180
		xtmp = R-R*sin(90-th);
		ytmp = R*cos(90-th);
		
		a1 = radtodeg(atan((xtmp-xb)/(yb-ytmp)));
		if a1 == th
			% steery stuff
			break
		end
	end
elseif xa < xb
	for th = -1:-180
		xtmp = R*sin(90-th)-R;
		ytmp = -R*cos(90-th);
		
		a2 = radtodeg(atan((xtmp-xb)/(yb-ytmp)));
		if a2 == th
			% steery stuff
			break
		end
	end
end

% drivey stuff














