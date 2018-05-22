function openCom(inputArg1)
%OPENCOM Summary of this function goes here
%   Detailed explanation goes here

	s1 = '\\.\COM0';
	s1(8) = int2str(inputArg1);
	EPOCommunications('open',s1);
	%sprintf('\\.\COM%d',inputArg1)

end

