function [h,dt,dist] = TDOA(y1,y2,Fs)
%TDOA Summary of this function goes here
%   Detailed explanation goes here

	[h,~] = ch3(y1,y2);
% 	t = -length(h)/2:1:(length(h)-1)/2;
% 	plot(t,ifftshift(h));
% 	xlabel('Sample index');
% 	ylabel('Amplitude');
% 	title('Time domain channel estimation');
% 	figure;
	
	ind = find(h == max(h)); % Find the sample with maximal value

	% for negative distances.
	if ind > 0.5*length(h)
		ind = ind-length(h);
	end
	
	dt = ind/Fs;	% Compute the DTOA
	dist = 343*dt;	% Compute distance

end