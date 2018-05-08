cport = 6; % com port to use


sdist = 0.50; % distance to stop at in meters
vroll = 0.55; % speed to aproach the final position [m/s] 0.46 @ 154 | 0.56 @ 155
vmin = 0.15; % speed to stop decelerating at
del = 0.3;%0.2; % delay margin
derr = 0.08;%0.6-sdist; % error margin, to avoid overshoot and oscilation

v = 0; % begin speed
a165 = 1.25; % acceleration with motor at full power
a135 = -6.5; % acceleration with motor full power backwards while moving forwards
% assumed that with motor at 154 with low speeds there is no acceleration,
% nor decelleration

tmp = linspace(0.1,0.2,20);
dos = tmp((sdist-0.29)*100);
clear tmp;

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
drive(155);
v = vroll;
dmar = del*v
while 1
	r = r+1;
	if r>r_val
		if mean(sensors()/100) < sdist + derr + dmar + dos
			drive(150);
			break;
		end
		r = 0;
	end
end
closeCom();
catch
	drive(150);
	pause(0.2);
	closeCom();
end

openCom(8)
drive(155)
pause(50)
stop()