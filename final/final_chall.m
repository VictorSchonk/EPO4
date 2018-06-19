cport = 5;		% Com port to use.
q = 1;

% log = [x,y,dir] % Variable to keep track of x y position
%
% 	rec = record();		% Record 24000 samples.
% 	times = ch_td(rec);	% Calculate all the times.
% 	pos = loc(times);	% Calculate the position.

%	code: 0xD073CDA6 ??????
setpref('dsp','portaudioHostApi',3) 

d_dist = 50; % distance in cm's to drive
%---- BEGIN OF VARIABLES ----

d_dist = 25; % distance in cm's to drive
steer_error = 2; %Allowed direction deviation before correcting
wp_error = 20;	%Distance from a waypoint when the car stops driving

A = [0 0];		%start position
dir = 90;		%start direction
B = [200 200];	%waypoint one
C = [360 120];	%waypoint two

fc = 10000;
code = '0xD073CDA6';
fb = 3750;
rc = 1250;

%---- END OF VARIABLES ----

figure(1); % figure 1 is the figure to plot the progress of the car on the way
plot([0 460 0 460 230],[0 0 460 460 460],'*k');
xlim([-10 470]);
ylim([-10 470]);
grid on;
hold on;
plot(B(1),B(2),'dm');
plot(C(1),C(2),'dr');
legend('Microphones','Waypoint 1','Waypoint 2');
plot(A(1),A(2),'xb');

try
	
	% SETUP
	openCom(cport);
	setup_beacon(fb,code,fc,rc);
	pause(0.1)
	EPOCommunications('transmit','A1');
	
% 	% FIRST LOCALISATION LOG
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
		plot(pos(1),pos(2),'xb');
		
		th = calc_th(pos(1),pos(2),dir,B(1),B(2));
		turn(th);
		dir = mod((dir+th),360);
	end
	
	% Drive to chechpoint 1 (B)
	while not(q)
		
		[pos(1),pos(2),~] = position(log(end,1),log(end,2),0);
		log(end+1,:) = [pos(1),pos(2),dir];
		plot(pos(1),pos(2),'xb');
		
		st = check_st(pos(1),pos(2),dir,B(1),B(2));
		if abs(st) > steer_error
			alpha = turn(st);
			dir = mod((dir + alpha),360);
			[pos(1),pos(2),~] = position(log(end,1),log(end,2),0);
			log(end+1,:) = [pos(1),pos(2),dir];
			plot(pos(1),pos(2),'xb');
		else
			forward(d_dist);
			[pos(1),pos(2),dir] = position(log(end,1),log(end,2),1);
			log(end+1,:) = [pos(1),pos(2),dir];
			plot(pos(1),pos(2),'xb');
		end
		
		if length(log) > 1000
			log = log(2:end,:);
		end
		
		if sqrt((pos(1)-B(1))^2 + (pos(2)-B(2))^2) < wp_error
			disp('Arrived at the first waypoint! position:');
			disp([pos(1);pos(2)]);
			q = 1;
		end
		
	end
	
% 	input('Press enter to continue to the next waypoint.');
	pause(10); % measuring pause at the waypoint
	q = 0;
	
	% SECCOND TURN
	angC = atan(C(2)/C(1)); % Check angle between m2-m1 and m2-B
	if abs(angC-dir) <= 90 % B in front of A
		th = calc_th(pos(1),pos(2),dir,C(1),C(2));
		turn(th);
		dir = mod((dir+th),360);
	else % C behind B
		turn(180);
		dir = mod((dir + 180),360);
		
		[pos(1),pos(2),~] = position(log(end,1),log(end,2),0);
		log(end+1,:) = [pos(1),pos(2),dir];
		plot(pos(1),pos(2),'xb');
		
		th = calc_th(pos(1),pos(2),dir,C(1),C(2));
		turn(th);
		dir = mod((dir+th),360);
	end
	
	% Drvie to checkpoint 2 (C)
	while not(q)
		
		[pos(1),pos(2),~] = position(log(end,1),log(end,2),0);
		log(end+1,:) = [pos(1),pos(2),dir];
		plot(pos(1),pos(2),'xb');
		
		st = check_st(pos(1),pos(2),dir,C(1),C(2));
		if abs(st) > steer_error
			alpha = turn(st);
			dir = mod((dir + alpha),360);
			[pos(1),pos(2),~] = position(log(end,1),log(end,2),0);
			log(end+1,:) = [pos(1),pos(2),dir];
			plot(pos(1),pos(2),'xb');
		else
			forward(d_dist);
			[pos(1),pos(2),dir] = position(log(end,1),log(end,2),1);
			log(end+1,:) = [pos(1),pos(2),dir];
			plot(pos(1),pos(2),'xb');
		end
		
		if length(log) > 1000
			log = log(2:end,:);
		end
		
		if sqrt((pos(1)-C(1))^2 + (pos(2)-C(2))^2) < wp_error
			disp('Arrived at the destination! position:');
			disp([pos(1);pos(2)]);
			pause(2)
			q = 1;
		end
	end
catch
	% In case of an error
	closeCom();
	error('!!!	Some error occured	!!!');
end