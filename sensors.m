function [outputArg1,outputArg2] = sensors()
%SENSORS Summary of this function goes here
%   Detailed explanation goes here

	str = EPOCommunications('transmit','Sd');
	st = strsplit(str,'U');
	s = st(4:end);
	outputArg1 = s(1);
	outputArg2 = s(2);
	
end

