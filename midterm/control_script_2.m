clear;
cport = 6; % com port to use
sdist = 0.40; % [m] distance to stop at in meters
vmin = 0.15; % [m/a] speed to stop decelerating at
del = 0.4; % [s] delay margin
derr = 0.4; % [m] error margin, to avoid overshoot and oscilation

v = 0; % begin speed
a165 = 1.25; % acceleration with motor at full power
a135 = -6.5; % acceleration with motor full power backwards while moving forwards

dm = 3; % 3 for 165 | 2 for 150 | 1 for 135
a = [a135 0 a165]; % acceleration for different motor states
r = 0;
r_val = 15;

openCom(cport);
try
tic;
drive(165);
while 1
	
	v = v+toc*a(dm); % current speed of the vehicle
	tic;
	dmar = del*v; % distance to compensate the delay
	r = r+1;
	if r > r_val
		if min(sensors()/100) < 1.5 % currently the minimal sensor value is used mean is another option
			break;
		end
		r = 0;
	end
end
while 2
	
	v = v+toc*a(dm);
	tic;
	
	
	dmar = del*v; % distance to compensate the delay
	r = r+1;
	if r > r_val
		if v < vmin
			drive(150);
			dm = 2;
		    break;
		elseif mean(sensors()/100) < sdist+derr
			drive(150);
			dm = 2;
			break;
		elseif mean(sensors()/100) < sdist+dmar 
			drive(135);
			dm = 1;
		else
			drive(165);
			dm = 3;
		end
		r = 0;
	end
end

closeCom();
catch
    stop();
end