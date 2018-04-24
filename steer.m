function steer(inputArg1)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

	if inputArg1 > 200
		st = 200;
	elseif inputArg1 < 100
		st = 100;
	else
		st = inputArg1;
	end
	EPOCommunications('transmit',sprintf('D%d',st));

end