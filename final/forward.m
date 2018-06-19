function [ ] = forward( dist )
%FORWARD Drive forward a given distance
%   input: dist : distance to drive in cm
%	output: none
v = 48;	%[cm/s] speed of the car for speed input 157
drive(157);
pause(dist/v)
drive(150)

end

