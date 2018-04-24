function steer(inputArg1)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

	EPOCommunications('transmit',sprintf('D%d',inputArg1));

end