p1 = 1;
p2 = 1;

v = 0; % begin speed
vmin = 0.15; % speed to stop decelerating at
a165 = 1.25; % acceleration with motor at full power
a135 = -6.5; % acceleration with motor full power backwards while moving forwards
dist = 0; %
del = 0.15; % delay margin
sdist = 0.40; % distance to stop at in meters
derr = 0.2; % error margin, to avoid overshoot and oscilation
dm = 3; % 3 for 165 | 2 for 150 | 1 for 135
a = [a135 0 a165];

t0 = tic;
drive(165);
while p1
	
	v = toc*a(dm);
	dist = 0.5*v*toc;
	dmar = del*v; % distance to compensate the delay
	
	if min(sensors()/100) < sdist + dmar % currently the minimal sensor value is used mean is another option
		p1 = 0;
	end
	
end
while p2
	
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
		p2 = 0;
	else
		drive(165);
		dm = 3;
	end
	
end