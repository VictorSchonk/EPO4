function [outArg] = check_st(xin1,yin1,xin2,yin2,dirin)
%CHECK_ST Check how much steering is needed
%   xin1	|	X position of vehicle
%	yin1	|	y position of vehicle
%	xin2	|	x position of target
%	yin2	|	y position of target
%	dirin	|	direction of the vehicle
%				0	= right
%				90	= up
%				180	= left
%				270 = down
%-----------
%	outarg	|	Degrees to steer. Between -180 and 180
%				positive => left  turn
%				negative => right turn

	dx = xin2-xin1;
	dy = yin2-yin1;
	
	if xin1 == xin2
		if yin1 == yin2
			% ERROR
		elseif yin1 > yin2
			ang1 = 270;
		elseif yin2 > yin1
			ang1 = 90;
		end
	elseif xin1 > xin2
		ang1 = mod((180+radtodeg(dy/dx)),360);
	elseif xin2 > xin1
		ang1 = mod((radtodeg(dy/dx)),360);
	end
	
	outArg = ang1 - dirin;

end

