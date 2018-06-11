function [outArg] = calc_th(xa,ya,dir,xb,yb)
%CALC_TH Calculate the angle to turn for a straight path from A to B
%   
%	xa		|	X-position of point A
%	ya		|	Y-position of point A
%	dir		|	direction in which the car is standing.
%				0	= right
%				90	= up
%				180	= left
%				270 = down
%	xb		|	X-position of point B
%	yb		|	Y-position of point B
%---------------------------------------------------------
%	outArg	|	The angle in degrees to turn in order to drive straight to point B

R = 80;	% Turn radius in cm's

dirc = dir-90; % To compensate that there is no rotation for dir = 90
dirm = [cos(dirc),-sin(dirc);sin(dirc),cos(dirc)]; % Rotation matrix

for th = -180:180
	
	tmp1 = [sign(th)*(R-R*sin(90-th));sign(th)*(r*cos(90-th))];
	tmp2 = dirm*tmp1;
	tmp2(1) = tmp2(1) + xa;
	tmp2(2) = tmp2(2) + ya;
	
	angpos = radtodeg(atan((yb-tmp2(2))/(tmp2(1)-xb)));
	
	if angpos == th
		outArg = th;
		break
	end
	
end


% -----------------------------
% if xa == xb
% 	
% elseif xa > xb
% 	for th = 1:180
% 		xtmp = R-R*sin(90-th);
% 		ytmp = R*cos(90-th);
% 		
% 		a1 = radtodeg(atan((xtmp-xb)/(yb-ytmp)));
% 		if a1 == th
% 			% steery stuff
% 			break
% 		end
% 	end
% elseif xa < xb
% 	for th = -1:-180
% 		xtmp = R*sin(90-th)-R;
% 		ytmp = -R*cos(90-th);
% 		
% 		a2 = radtodeg(atan((xtmp-xb)/(yb-ytmp)));
% 		if a2 == th
% 			% steery stuff
% 			break
% 		end
% 	end
% end
% -----------------------------


end

