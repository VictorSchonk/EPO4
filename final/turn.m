function [ th ] = turn( turndeg, dir, xbegin, ybegin )
%TURN car makes a turn of inarg degrees
%     inarg < 0 : left turn
%     inarg > 0 : right turn
% 
% openCom(3)   %
% pause(0.2)
% steer(200)
% pause(0.2)
% drive(157)  %check
% pause(0.5)  %vary
% drive(150)
% steer(150)
% stop()
x = xbegin;
y = ybegin;
r = 76;		%turn radius[cm]

if turndeg < 0		%left turn
	steer(200)
	pause(0.2)
	drive(157)
	pause(0.5)
	drive(150)
	[x,y,~] = position(x,y,0);	%redetermine position
	th = 90 - (pi/180)*acos((y-ybegin)/r);	%calculate total turned degrees
	while th > turndeg		%while not turned enough continue
		drive(157)
		pause(0.5)
		drive(150)
		[x,y,~] = position(x,y,0);
		th = 90 - (pi/180)*acos((y-ybegin)/r);
	end
	steer(150)	%steer straight after turn
	
elseif turndeg > 0	%right turn
	steer(100)
	pause(0.2)
	drive(157)
	pause(0.5)
	drive(150)
	[x,y,~] = position(x,y,0);	%redetermine position
	th = 90 - (pi/180)*acos((y-ybegin)/r);	%calculate total turned degrees
	while th < turndeg		%while not turned enough continue
		drive(157)
		pause(0.5)
		drive(150)
		[x,y,~] = position(x,y,0);
		th = 90 - (pi/180)*acos((y-ybegin)/r);
	end
	steer(150)
else				%apparently straight
	th = 0;
end

end

