cport = 5;		% Com port to use.
q = 1;

% log = [x,y,dir] % Variable to keep track of x y position
%
% 	rec = record();		% Record 24000 samples.
% 	times = ch_td(rec);	% Calculate all the times.
% 	pos = loc(times);	% Calculate the position.

d_dist = 25; % distance in cm's to drive

A = [0 0];
dir = 90;
B = [200 200];

try
	
	% SETUP
	openCom(cport);
	setup_beacon(10000,'0x62ffdfff',2500,2500);
	pause(0.1)
	EPOCommunications('transmit','A1');
	
	% FIRST LOCALISATION
	[pos(1),pos(2),~] = position(A(1),A(2),0);
	log(1,:) = [pos(1),pos(2),dir];
	
	% FIRST TURN
	angB = atan(B(2)/B(1)); % Check angle between m2-m1 and m2-B
	if abs(angB-dir) <= 90 % B in front of A
		th = calc_th(pos(1),pos(2),dir,B(1),B(2));
		turn(th);
		dir = mod((dir+th),360);
	else % B behind A
		turn(180);
		dir = mod((dir + 180),360);
		
		[pos(1),pos(2),~] = position(log(end,1),log(end,2),0);
		log(end+1,:) = [pos(1),pos(2),dir];
		
		th = calc_th(pos(1),pos(2),dir,B(1),B(2));
		turn(th);
		dir = mod((dir+th),360);
	end
	
	% Drive to chechpoint 1 (B)
	while not(q)
		
		[pos(1),pos(2),~] = position(log(end,1),log(end,2),0);
		log(end+1,:) = [pos(1),pos(2),dir];
		
		st = check_st(pos(1),pos(2),dir,B(1),B(2));
		if st ~= 0
			turn(st);
			dir = mod((dir + st),360);
			[pos(1),pos(2),~] = position(log(end,1),log(end,2),0);
			log(end+1,:) = [pos(1),pos(2),dir];
		else
			forward(d_dist);
			[pos(1),pos(2),dir] = position(log(end,1),log(end,2),1);
			log(end+1,:) = [pos(1),pos(2),dir];
		end
		
		% Drivey drivey stuff
		
		if length(log) > 1000
			log = log(2:end,:);
		end
	end
	
	input('Press enter to continue to the next waypoint.');
	q = 0;
	
	% Drvie to checkpoint 2 (C)
	while not(q)
		
		rec = record();		% Record 24000 samples.
		times = ch_td(rec);	% Calculate all the times.
		pos = loc(times);	% Calculate the position.
		
		% drivey drivey stuff 2
		
		break;
		
	end
	
	% Stop things at end of challenge
	EPOCommunications('transmit','A0');
	closeCom();
	
catch
	% In case of an error
	closeCom();
end