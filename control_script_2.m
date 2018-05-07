p1 = 1;
p2 = 1;

v = 0; % begin speed
a165 = 1.25; % acceleration with motor at full power
dist = 0; %
del = 0.15; % delay margin
sdist = 0.40; % distance to stop at in meters

t0 = tic;
drive(165);
while p1
	
	v = toc*a165;
	dist = 0.5*v*toc;
	dmar = del*v;
	
	if sensors() < sdist + dmar
		
	else
		drive(165);
	end
	
end