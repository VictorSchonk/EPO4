function setup_beacon(fb,code,fc,rc)
%SETUP_BEACON Function to setup the audio beacon and show that it
%functions.
%	setup_beacon(fb,code,fc,rc)
%
%	argument	data type	range(/format)
%	--------------------------------------------------
%	fb			integer		0-65535
%	code		string		0xhhhhhhhh (h = hex digit)
%	fc			integer		0-65535
%	rc			integer		32-65535
%
%   The first input argument is the bit frequency, this should be an
%integer between 0 and 65535.
%
%	The second input argument is the code to be sent, This should be a hex
%value (as a string) in the form of 0xhhhhhhhh (h = hex digit).
%
%	The third input argument is the carrier frequency, this should be an
%integer between 0 and 65535.
%
%	The last (fourth) input argument is the repetition count, this should
%be an integer between 32 and 65535.
%
%
%	used:
%		fb	= 3750e2 (max fc)
%		code= FEDBFF57
%		fc	= 15e3 (max 0.5*fs)
%		rc	= 250 (fb/(clicks per second))

	pause(0.01);
	% Bit freq. 0 ... 65535
	% Input as integer
	EPOCommunications('transmit',sprintf('B%d',fb));
	pause(0.01);
	% Code word 0xhhhhhhhh (h = hex digit)
	% Input as string or character array
	EPOCommunications('transmit',sprintf('C%s',code));
	pause(0.01);
	% Carrier freq 0 ... 65535
	% Input as integer
	EPOCommunications('transmit',sprintf('F%d',fc)); 
	pause(0.01);
	% Repetition count 32 ... 65535
	% Input as integer
	EPOCommunications('transmit',sprintf('R%d',rc)); 
	pause(0.01);

	EPOCommunications('transmit','A1');
	pause(0.2);
	EPOCommunications('transmit','A0');
	pause(0.01);

end

