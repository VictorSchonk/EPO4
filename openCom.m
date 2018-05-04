function openCom(inputArg1)
%OPENCOM Summary of this function goes here
%   Detailed explanation goes here

	EPOCommunications('open',sprintf('\\.\COM%d',inputArg1));

end

