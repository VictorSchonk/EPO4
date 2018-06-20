%Test the function turn using this script.
cport = 6;
openCom(cport)
setup_beacon(3750,'0xD073CDA6',10000,1250);
EPOCommunications('transmit','A1');

maze = createmaze(4);

%120 degrees left, start in middle pointing right
turn(90, 180, 230, 230,maze)

% %90 degrees right, start at A pointing m4
% turn(-90, 45, 150, 150)
% 
% %45 degrees right, start at C pointing down
% turn(-45, 270, 200, 360)
% 
% %45 degrees left, start at C pointing down
% turn(45, 270, 200, 360)
% 
% %180 degrees left, start in middle pointing up
% turn(180, 90, 230, 230)