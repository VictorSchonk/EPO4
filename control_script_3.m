cport = 6; % com port to use
sdist = 0.50; % distance to stop at in meters
vroll = 0.5; % speed to aproach the final position [m/s]
vmin = 0.15; % speed to stop decelerating at
del = 0.2;%0.2; % delay margin
derr = 0;%0.6-sdist; % error margin, to avoid overshoot and oscilation

v = 0; % begin speed
a165 = 1.3; % acceleration with motor at full power
a135 = -6.5; % acceleration with motor full power backwards while moving forwards
% assumed that with motor at 154 with low speeds there is no acceleration,
% nor decelleration

dm = 3; % 3 for 165 | 2 for 150 | 1 for 135
a = [a135 0 a165]; % acceleration for different motor states
r = 0;
r_val = 15;

try
openCom(cport);

tic;
drive(165);
while 1
	v = v+toc*a(dm); % current speed of the vehicle
	tic;
	dmar = del*v; % distance to compensate the delay
	r = r+1;
	if r > r_val
		if mean(sensors()/100) < 1.5+dmar % currently the minimal sensor value is used mean is another option
			break;
		end
		r = 0;
	end
end
drive(135);
pause(abs((v-vroll)/a(1)));
drive(154);
v = vroll;
while 1
	r = r+1;
	if r>r_val
		if mean(sensors()/100) < sdist + derr
			drive(150);
			break;
		end
		r = 0;
	end
end
closeCom();
catch
	stop();
end