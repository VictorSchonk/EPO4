function [outputArg1,outputArg2] = sensors()
%SENSORS Summary of this function goes here
%   Detailed explanation goes here

	str = EPOCommunications('transmit','Sd');
	st = strsplit(str,'U');
	st = st(2:3);
	s1 = strsplit(string(st(1)),'L');
	s2 = strsplit(string(st(2)),'R');
	s1 = strsplit(s1(2),'\n');
	s2 = strsplit(s2(2),'\n');
	outputArg1 = str2double(s1(1));
	outputArg2 = str2double(s2(1));
	
end

