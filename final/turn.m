function [ th ] = turn( turndeg, dir, xbegin, ybegin, maze )
%TURN car makes a turn of inarg degrees
%     turndeg > 0 : left turn
%     turndeg < 0 : right turn

rot = [cos(-dir),-sin(-dir);sin(-dir),cos(-dir)];
posbegin = rot*[xbegin;ybegin];
r = 76;		%turn radius[cm]

if turndeg > 0		%left turn
	steer(200)
	pause(0.2)
	drive(157)
	pause(0.5)
	drive(150)
	[x,y] = position(xbegin,ybegin,0,maze);	%redetermine position
	pos = rot*[x;y];
	th = 90 - (pi/180)*acos((pos(2)-posbegin(2))/r);	%calculate total turned degrees
	while th < turndeg		%while not turned enough continue
		drive(157)
		pause(0.5)
		drive(150)
		[x,y] = position(x,y,0,maze);
		pos = rot*[x;y];
		th = 90 - (pi/180)*acos((pos(2)-posbegin(2))/r);
	end
	steer(150)	%steer straight after turn
	
elseif turndeg < 0	%right turn
	steer(100)
	pause(0.2)
	drive(157)
	pause(0.5)
	drive(150)
	[x,y] = position(x,y,0,maze);	%redetermine position
	pos = rot*[x;y];
	th = 90 - (pi/180)*acos((pos(2)-posbegin(2))/r);	%calculate total turned degrees
	while th > turndeg		%while not turned enough continue
		drive(157)
		pause(0.5)
		drive(150)
		[x,y] = position(x,y,0,maze);
		pos = rot*[x;y];
		th = 90 - (pi/180)*acos((pos(2)-posbegin(2))/r);
	end
	steer(150)
else				%apparently straight
	th = 0;
end

end

