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

	R = 76;	% Turn radius in cm's
	ang_err = 0.0017; % Error allowed in the angle
	
	t_rev = 1.5; % time to reverse before trying again (in seconds)
	d_rev = 50; % distance the car reversed (in cm's)
	
	res = 0;
	
	dir = mod(dir,360);
	
	dirc = (dir-90)*pi/180; % To compensate that there is no rotation for dir = 90
	dirm = [cos(dirc),-sin(dirc);sin(dirc),cos(dirc)]; % Rotation matrix
	
% 	figure;
	for th = -180:0.1:0
	
		nt = (90-th)*pi/180;
		tr = th*pi/180;
		tmp1 = [ R-R*cos(tr) ; -R*sin(tr) ];
		tmp2 = dirm*tmp1;
		
		tmp2(1) = tmp2(1) + xa;
		tmp2(2) = tmp2(2) + ya;
		
% 		plot(tmp1(1),tmp1(2),'xb');
% 		hold on;
% 		plot(tmp2(1),tmp2(2),'xr');
% 		plot(xa,ya,'dm');
% 		plot(xb,yb,'dk');
% 		xlim([0 460]);
% 		ylim([0 460]);
		
		if tmp2(1) < 0 || tmp2(2) < 0 || tmp2(1) > 460 || tmp2(2) > 460
			continue;
		end
	
		ang1 = dir*pi/180;
		
		if xb < xa
			angtmpb = mod(atan((tmp2(2)-yb)/(tmp2(1)-xb))+pi,2*pi);
		else
			angtmpb = mod(atan((tmp2(2)-yb)/(tmp2(1)-xb)),2*pi);
		end
		
		
		angpos = -1*(ang1-angtmpb);
		
		
% 		disp('-----------------');
% 		disp(angtmpb*180/pi);
% 		disp(angpos*180/pi);
% 		disp(tr*180/pi);
	
		if angpos >= tr-ang_err && angpos <= tr+ang_err
			res = 1;
			outArg = th;
			break;
		end
	end
	if res ~= 1
		for th = 0:0.1:180
		
			nt = (90-th)*pi/180;
			tr = th*pi/180;
			tmp1 = [ -R+R*cos(tr) ; R*sin(tr) ];
			tmp2 = dirm*tmp1;
			tmp2(1) = tmp2(1) + xa;
			tmp2(2) = tmp2(2) + ya;
		
% 			plot(tmp1(1),tmp1(2),'xb');
% 			hold on;
% 			plot(tmp2(1),tmp2(2),'xr');
% 			plot(xa,ya,'dm');
% 			plot(xb,yb,'dk');
		
			if tmp2(1) < 0 || tmp2(2) < 0 || tmp2(1) > 460 || tmp2(2) > 460
				disp('Reverse and retry turn');
				drive(142);
				pause(t_rev);
				drive(150);
				xch = -d_rev*cos((dir)*pi/180);
				ych = -d_rev*sin((dir)*pi/180);
				outArg = calc_th(xa+xch,ya+ych,dir,xb,yb);
				break;
			end
		
			angtmpb = atan((tmp2(2)-yb)/(tmp2(1)-xb));
		
			angpos = pi-dir*pi/180+angtmpb;
		
			if angpos >= tr-ang_err && angpos <= tr+ang_err
				outArg = th;
				break;
			end
		
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

