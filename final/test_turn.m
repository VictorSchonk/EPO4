%Test the function turn using this script.
cport = ;
openCom(cport)
setup_beacon(10000,'0xFEDBFF57',2500,2500);

%120 degrees left, start in middle pointing right
turn(120, 0, 230, 230)

%90 degrees right, start at A pointing m4
turn(-90, 45, 150, 150)

%45 degrees right, start at C pointing down
turn(-45, 270, 200, 360)

%45 degrees left, start at C pointing down
turn(45, 270, 200, 360)

%180 degrees left, start in middle pointing up
turn(180, 90, 230, 230)