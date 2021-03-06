function [ th ] = turn( turndeg, dir, xbegin, ybegin, maze )
%TURN car makes a turn of inarg degrees
%     turndeg > 0 : left turn
%     turndeg < 0 : right turn

rot = [cos(-dir),-sin(-dir);sin(-dir),cos(-dir)];
posbegin = rot*[xbegin;ybegin];
r = 76;		%turn radius[cm]
dtime = 1.0;

turnsm = ceil(0.0611*abs(turndeg));
if turnsm < 1
	turnsm = 1;
end

if turndeg > 0		%left turn
	steer(200)
	pause(0.2)
	drive(157)
	pause(dtime)
	drive(150)
	turnsm = turnsm - 1;
	[x,y] = position(xbegin,ybegin,0,maze);	%redetermine position
	pos = rot*[x;y];
	th = 90 - (pi/180)*acos((pos(2)-posbegin(2))/r);	%calculate total turned degrees
	while th < turndeg && turnsm > 0		%while not turned enough continue
		drive(157)
		pause(dtime)
		drive(150)
		[x,y] = position(x,y,0,maze);
		turnsm = turnsm - 1;
		pos = rot*[x;y];
		th = 90 - (pi/180)*acos((pos(2)-posbegin(2))/r);
	end
	steer(150)	%steer straight after turn
	
elseif turndeg < 0	%right turn
	steer(100)
	pause(0.2)
	drive(157)
	pause(dtime)
	drive(150)
	turnsm = turnsm - 1;
	[x,y] = position(xbegin,ybegin,0,maze);	%redetermine position
	pos = rot*[x;y];
	th = 90 - (pi/180)*acos((pos(2)-posbegin(2))/r);	%calculate total turned degrees
	while th > turndeg && turnsm > 0		%while not turned enough continue
		drive(157)
		pause(dtime)
		drive(150)
		[x,y] = position(x,y,0,maze);
		turnsm = turnsm - 1;
		pos = rot*[x;y];
		th = 90 - (pi/180)*acos((pos(2)-posbegin(2))/r);
	end
	steer(150)
else				%apparently straight
	th = 0;
end

end

