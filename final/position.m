function [xout,yout,dirout] = position(lastx,lasty,calcdir,maze)
%POSITION Calculate the position and direction
%   lastx	|	Last x position in order to calculate direction
%				And to check if location in reasonable
%	lasty	|	Last y position in order to calculate direction
%				And to check if location in reasonable
%	calcdir |	0 not to calculate direction
%				1 to calculate direction
%-----------
%	xout	|	New x position
%	yout	|	New y position
%	dirout	|	Calculated direction with last x,y and new x,y

	rec = record();		% Record 24000 samples.
	times = ch_td(rec,lastx,lasty);	% Calculate all the times.
	[x,y] = loc2(times,maze);	% Calculate the position.
% 	disp(x);
% 	disp(y);
	
	while (x < 0 || x > 460 || y < 0 || y > 460)
		[x,y] =  position(lastx,lasty,calcdir,maze);
		disp(repositioning);
	end
	
	xout = x;
	yout = y;
	
	if calcdir == 1
		if xout == lastx
			if yout > lasty
				dirout = 90;
			elseif yout < lasty
				dirout = 270;
			else
				dirout = 'error';
			end
		elseif xout > lastx
			dirout = mod(radtodeg(atan((yout-lasty)/(xout-lastx))),360);
		elseif xout < lastx
			dirout = mod((180+radtodeg(atan((yout-lasty)/(xout-lastx)))),360);
		else
			dirout = 'error';
		end
	else
		dirout = 'no';
	end

end

