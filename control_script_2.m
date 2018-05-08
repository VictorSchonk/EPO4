sdist = 0.40; % distance to stop at in meters
vmin = 0.15; % speed to stop decelerating at
del = 0.15; % delay margin
derr = 0.2; % error margin, to avoid overshoot and oscilation

v = 0; % begin speed
a165 = 1.25; % acceleration with motor at full power
a135 = -6.5; % acceleration with motor full power backwards while moving forwards

dm = 3; % 3 for 165 | 2 for 150 | 1 for 135
a = [a135 0 a165]; % acceleration for different motor states

t0 = tic;
drive(165);
while 1
	
	v = toc*a(dm); % current speed of the vehicle
	dmar = del*v; % distance to compensate the delay
	
	if min(sensors()/100) < sdist + dmar % currently the minimal sensor value is used mean is another option
		break;
	end
	
end
while 2
	
	v = v+toc*a(dm);
	tic;
	
	dmar = del*v; % distance to compensate the delay
	
	if v < vmin
		drive(150);
		dm = 2;
	elseif mean(sensors()/100) < sdist+dmar 
		drive(135);
		dm = 1;
	elseif mean(sensors()/100) < sdist+derr
		drive(150);
		dm = 2;
		break;
	else
		drive(165);
		dm = 3;
	end
	
end