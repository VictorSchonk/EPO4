function out = sensors()
%SENSORS Summary of this function goes here
%   Detailed explanation goes here
%	Returns value in cm's

	str = EPOCommunications('transmit','Sd');
	st = strsplit(str,'\n');
    clear str;
	s1 = cell2mat(st(1));
	s2 = cell2mat(st(2));
	outputArg1 = str2num(s1(4:end));
	outputArg2 = str2num(s2(4:end));
	
% 	s1 = strsplit(string(st(1)),'L');
% 	s2 = strsplit(string(st(2)),'R');
% 	s1 = strsplit(s1(2),'\n');
% 	s2 = strsplit(s2(2),'\n');
% 	outputArg1 = str2double(s1(1));
% 	outputArg2 = str2double(s2(1));
	out = [outputArg1, outputArg2];
	
end