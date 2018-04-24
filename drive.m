function drive(inputArg1)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

	EPOCommunications('transmit',sprintf('M%d',inputArg1));

end