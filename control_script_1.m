q = 0;
velo = 150; % 165 = v_max
steer = 150; % 100 => wheels left

while not(q)
	k = input('Control the car','s');
	switch k
		case 'w'
			velo = velo + 2;
		case 'a'
			steer = steer + 1;
		case 'd'
			steer = steer - 1;
		case 's'
			velo = velo - 2;
		case 'q'
			q = 1;
		otherwise
			if steer > 150
				steer = steer - 1;
			elseif steer < 150
				steer = steer + 1;
			end
			if velo > 150
				velo = velo - 1;
			elseif velo < 150
				velo = velo + 1;
			end
	end
	if q == 1
		stop();
		break;
	end
	pause(0.1);
end