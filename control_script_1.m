q = 0;
velo = 150; % 165 = v_max
st = 150; % 100 => wheels left

%%%%%%%%%%%
% EPOCommunications('open','\\.\COMn');
%%%%%%%%%%%

while not(q)
	k = getkey();
	switch k
		case 'w'
			velo = velo + 2;
		case 'a'
			st = st + 1;
		case 'd'
			st = st - 1;
		case 's'
			velo = velo - 2;
		case 'q'
			q = 1;
		case 'b'
			velo = 150;
			st = 150;
		otherwise
			st = st;
			velo = velo;
	end
	if velo < 135
		velo = 135;
	elseif velo > 165
		velo = 165;
	end
	if q == 1
		stop();
		closeCom();
		break;
	end
	drive(velo);
	steer(st);
	pause(0.1);
end