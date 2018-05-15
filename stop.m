function [r_val] = stop()
%stop This function stops the car from driving and straightens the wheels.
%After that it returns the status in the command window.
%   

	EPOCommunications('transmit','M150');
	pause(0.05);
	EPOCommunications('transmit','D150');
	pause(0.05);
	r_val = EPOCommunications('transmit','S');
	closeCom();

end

