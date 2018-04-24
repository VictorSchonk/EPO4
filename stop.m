function [r_val] = stop()
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

	EPOCommunications('transmit','M150');
	EPOCommunications('transmit','D150');
	r_val = EPOCommunications('transmit','S');

end

