cport = 6; % com port to use
sdist = 0.40; % distance to stop at in meters
vroll = 1; % speed to aproach the final position [m/s]
vmin = 0.15; % speed to stop decelerating at
del = 0.15; % delay margin
derr = 0.2; % error margin, to avoid overshoot and oscilation

v = 0; % begin speed
a165 = 1.25; % acceleration with motor at full power
a135 = -6.5; % acceleration with motor full power backwards while moving forwards
% assumed that with motor at 154 with low speeds there is no acceleration,
% nor decelleration

dm = 3; % 3 for 165 | 2 for 150 | 1 for 135
a = [a135 0 a165]; % acceleration for different motor states

openCom(cport);

tic;
drive(165);
while 1
	v = v+toc*a(dm); % current speed of the vehicle
	tic;
	dmar = del*v; % distance to compensate the delay
	
	if min(sensors()/100) < sdist + dmar % currently the minimal sensor value is used mean is another option
		break;
	end
end
drive(135);
pause(abs((v-vroll)/a(1)));
drive(154);
v = vroll;
while 1
	if mean(sensors()/100) < sdist + dmar
		drive(150);
		break;
	end
end
closeCom();