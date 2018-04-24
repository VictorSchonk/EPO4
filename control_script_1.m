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
		otherwise
			if st > 150
				st = st - 1;
			elseif st < 150
				st = st + 1;
			end
			if velo > 150
				velo = velo - 1;
			elseif velo < 150
				velo = velo + 1;
			end
	end
	if st < 100
		st = 100;
	elseif st > 200
		st = 200;
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
	steer(steer);
	pause(0.1);
end