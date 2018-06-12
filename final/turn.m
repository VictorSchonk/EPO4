function [ ] = turn( inarg )
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

if inarg < 0		%left turn
	steer(200)
	pause(0.2)
	drive(157)
	position
elseif inarg > 0	%right turn
	
else				%apparently straight
	
end


end

