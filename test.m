% drive(165)
% pause(3.5)
% drive(135)
% pause(0.5)
% drive(150)
% 
% drive(135)
% pause(1.5)
% drive(165)
% pause(0.3)
% drive(150)
% een comment enzo

D = 53; % cm
q = 0;
sum = 0;
b1 = 0;
b2 = 0;
dq = 0;
i = 1;

while not(q)
	
	tic;
	if sum > 0.0001
		sum = 0;
		[a, b] = sensors();
		disp([a, b]);
		sense(i,:) = [a,b];
		if mean(a,b) < D | b2
			if b2
				drive(150);
				dq = dq + 1;
				if dq > 20
					q = 1;
				end
			else
				drive(135);
				pause(0.4);
				drive(150);
				b2 = 1;
				q = 0;
			end
		elseif mean(a,b) < 150 | b1
			if not(b1)
				drive(135);
				pause(0.2)
				drive(154);
				b1 = 1;
			else
				drive(154);
			end
			q = 0;
		else
			drive(160);
			q = 0;
		end
		i = i+1;
		sum = 0;
	end
	v = toc;
	sum = sum + v;
end

stem(sense);