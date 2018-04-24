function drive(inputArg1)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

	if inputArg1 > 165
		dr = 165;
	elseif inputArg1 < 135
		dr = 135
	else
		dr = inputArg1
	end
	EPOCommunications('transmit',sprintf('M%d',dr));

end