function steer(inputArg1)
%steer This function takes an input from 100 to 200. To steer the car.
%   An input value of 100 corresponds to the wheels fully turned to the
%   right. A value of 150 corresponds to the wheels centered. And a value
%   of 200 corresponds to the wheels turned all the way to the left. This
%   function also limits its input to the range of 100 to 200.

	if inputArg1 > 200
		st = 200;
	elseif inputArg1 < 100
		st = 100;
	else
		st = inputArg1;
	end
	EPOCommunications('transmit',sprintf('D%d',st));

end