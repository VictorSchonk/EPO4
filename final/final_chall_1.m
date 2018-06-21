cport = 6;		% Com port to use.
q = 0;

% log = [x,y,dir] % Variable to keep track of x y position
%
% 	rec = record();		% Record 24000 samples.
% 	times = ch_td(rec);	% Calculate all the times.
% 	pos = loc(times);	% Calculate the position.

%	code: 0xD073CDA6 ??????
setpref('dsp','portaudioHostApi',3) 

%---- BEGIN OF VARIABLES ----

d_dist = 50; % distance in cm's to drive
steer_error = 2; %Allowed direction deviation before correcting
wp_error = 15;	%Distance from a waypoint when the car stops driving

A = [346 0];		%start position
dir = 90;		%start direction
C = [385 248];	%waypoint one
B = [105 333];	%waypoint two

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
legend('Microphones','Waypoint 1');
plot(A(1),A(2),'xb');

maze = createmaze(4);

try
	
	% SETUP
	openCom(cport);
	setup_beacon(fb,code,fc,rc);
	pause(0.1);
	EPOCommunications('transmit','A1');
	
% 	% FIRST LOCALISATION LOG
	pos = A;
	
	log(1,:) = [pos(1),pos(2),dir];
	
	% FIRST TURN
	angB = atan(B(2)/B(1)); % Check angle between m2-m1 and m2-B
	if abs(angB-dir) <= 90 % B in front of A
		th = calc_th(pos(1),pos(2),dir,B(1),B(2));
		th = turn(th);
		dir = mod((dir+th),360);
	else % B behind A
		th = turn(90);
		dir = mod((dir + th),360);
		
		[pos(1),pos(2),~] = position(log(end,1),log(end,2),0,maze);
		log(end+1,:) = [pos(1),pos(2),dir];
		plot(pos(1),pos(2),'xb');
		
		th = calc_th(pos(1),pos(2),dir,B(1),B(2));
		th = turn(th);
		dir = mod((dir+th),360);
	end
	
	% Drive to chechpoint 1 (B)
	while not(q)
		
		[pos(1),pos(2),~] = position(log(end,1),log(end,2),0,maze);
		log(end+1,:) = [pos(1),pos(2),dir];
		plot(pos(1),pos(2),'xb');
		
		st = check_st(pos(1),pos(2),dir,B(1),B(2));
		if abs(st) > steer_error
			alpha = turn(st);
			dir = mod((dir + alpha),360);
			[pos(1),pos(2),~] = position(log(end,1),log(end,2),0,maze);
			log(end+1,:) = [pos(1),pos(2),dir];
			plot(pos(1),pos(2),'xb');
		else
			forward(d_dist);
			[pos(1),pos(2),dir] = position(log(end,1),log(end,2),1,maze);
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
			break;
		end
		
	end
	
% 	input('Press enter to continue to the next waypoint.');
	pause(10); % measuring pause at the waypoint
	
	closeCom();
	
catch err
	% In case of an error
	closeCom();
	disp(err);
	error('!!!	Some error occured	!!!');
end