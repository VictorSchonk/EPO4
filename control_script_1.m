q = 0;
v = 150;

while not(q)
	tmp = input();
	switch tmp
		case 'w'
			v = v+1;
		case 'a'
			v = v;
		case 'd'
			v = v;
		case 's'
			v = v-1;
		case 'q'
			q = 1;
		otherwise
			v = v;
	end
	drive(v)
	pause(0.2)
end