function drive(inputArg1)
%drive This function takes in input between 135 and 165, to drive the car
%forward or backwards.
%   An input value of 150 corresponds to no driving action. A value of 135
%   corresponds to full speed reverse. And a value of 165 corresponds to
%   full speed forward. This function also limits its inputs to the range
%   of 135 to 165.

	if inputArg1 > 165
		dr = 165;
	elseif inputArg1 < 135
		dr = 135;
	else
		dr = inputArg1;
	end
	EPOCommunications('transmit',sprintf('M%d',dr));

end