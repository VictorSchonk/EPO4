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

try
	
	%	setup of the threshold and recording values
	nmic = 2; % Amount of microphones being used
	tresh = 0.002;
	th = zeros(nmic,1);
	firstchannel = 1;
	lastchannel = nmic; % microphones to use, as they are numbered
	
	coputer = 1; % 1 for laptop other for test setup
	Fs = 48000;
	
	if coputer == 1
		tresh = 0.05;
		rec1 = audiorecorder(Fs,24,nmic,0);
	end
	
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
	
	setup_beacon(10000,'0x62ffdfff',2500,250);
	EPOCommunications('transmit','A1');
	
	while run
		switch coputer
			case 1
				recordblocking(rec1,12000/Fs);
				rec = getaudiodata(rec1);
				ind = find(rec >= tresh,1)
% 				plot(rec(ind-50:ind+4000,:));
				plot(rec);
			otherwise
				rec = pa_wavrecord(firstchannel, lastchannel, 12000,48e3,0,'asio'); % recorded sample for threshold detection
				ind = find(rec >= thresh,1);
				plot(rec(ind-50:ind+4000));
		end
		
	
		% Other processes like sensors() and driving the car
		
		if run >= 20 && coputer ~= 1
			run = 0;
		elseif run >= 4
			run = 0;
		else
			run = run + 1	
		end
		
	end
	
	EPOCommunications('transmit','A0');
    closeCom();
	
catch
	EPOCommunications('transmit','A0');
	pause(0.01);
	closeCom();
end