cport = 3;		% Com port to use.
q = 1;

% log = [x,y,dir] % Variable to keep track of x y position

A = [];
dir = ;
B = [];

try
	
	% SETUP
	openCom(cport);
	setup_beacon(10000,'0x62ffdfff',2500,2500);
	pause(0.1)
	EPOCommunications('transmit','A1');
	
	% FIRST LOCALISATION
	rec = record();		% Record 24000 samples.
	times = ch_td(rec);	% Calculate all the times.
	pos = loc(times);	% Calculate the position.
	log(1) = [pos(1),pos(2),dir];
	
	% FIRST TUrn
	angB = atan(B(2)/B(1));
	if abs(angB-dir) <= 90
		th = calc_th(pos(1),pos(2),dir,B(1),B(2));
		turn(th);
		dir = mod((dir+th),360);
	else
		turn(180);
		dir = mod((dir + 180),360);
		
		rec = record();		% Record 24000 samples.
		times = ch_td(rec);	% Calculate all the times.
		pos = loc(times);	% Calculate the position.
		
		turn(calc_th(pos(1),pos(2),dir,B(1),B(2)));
	end
	
	while not(q)
		
		rec = record();		% Record 24000 samples.
		times = ch_td(rec);	% Calculate all the times.
		pos = loc(times);	% Calculate the position.
		
		% Drivey drivey stuff
		
		break;
		
	end
	
% 	input('Press enter to continue to the next waypoint.');
	q = 0;
	
	while not(q)
		
		rec = record();		% Record 24000 samples.
		times = ch_td(rec);	% Calculate all the times.
		pos = loc(times);	% Calculate the position.
		
		% drivey drivey stuff 2
		
		break;
		
	end
	
% 	rec = record();
	
	EPOCommunications('transmit','A0');
	
	closeCom();
	
catch
	closeCom();
end