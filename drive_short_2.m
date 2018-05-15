cport = 6; % com port to use

dbumper = 0.08; % distance between sensors and bumper

sdist = 0.40; % distance to stop at in meters
vroll = 0.45; % speed to aproach the final position [m/s] 0.46 @ 154 | 0.56 @ 155
vmin = 0.15; % speed to stop decelerating at
del = 0.3;%0.2; % delay margin
derr = 0.08;%0.6-sdist; % error margin, to avoid overshoot and oscilation

v = 0; % begin speed
a165 = 1.2; % acceleration with motor at full power
a135 = -6.55; % acceleration with motor full power backwards while moving forwards
% assumed that with motor at 154 with low speeds there is no acceleration,
% nor decelleration

%%% Compensation for unexplained overshoot, lineairly proportional to final
%%% distance
tmp = linspace(0.15,0.3,40); % add 0.05 for short begin dist and substr 0.05 for long begin dist
dos = tmp(int8((sdist-0.29)*100)); %+dbumper
clear tmp;

dm = 3; % 3 for 165 | 2 for 150 | 1 for 135
a = [a135 0 a165]; % acceleration for different motor states
r = 0;
r_val = 15;

try
% openCom(cport);

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
dmar = del*v;
while 1
	r = r+1;
	if r>r_val
		if min(sensors()/100) < sdist + derr + dmar + dos + dbumper
			drive(144);
			break;
		end
		r = 0;
	end
end
pause(0.2);
closeCom();
catch
	pause(0.2);
	drive(150);
	pause(0.2);
	closeCom();
end