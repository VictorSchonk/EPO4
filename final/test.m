syms x1 x2 x3 x4 r12 r13 r14 r23 r24 r34 x d2 d3 d4 lx1 lx2 lx3 lx4

% rij is the tdoa or the distance from the center. 
% xi is the vector with [x;y] as the x and y position of that microphone.
% di are nuisance parameters
% lxi is the length of the vector xi

tic;

A = [2*(x2-x1).' -2*r12 0 0;...
	2*(x3-x1).' 0 -2*r13 0;...
	2*(x4-x1).' 0 0 -2*r14;...
	2*(x3-x2).' 0 -2*r23 0;...
	2*(x4-x2).' 0 0 -2*r24;...
	2*(x4-x3).' 0 0 -2*r34];

y = [x;d2;d3;d4];

B = [r12^2-lx1^2+lx2^2;...
	r13^2-lx1^2+lx3^2;...
	r14^2-lx1^2+lx4^2;...
	r23^2-lx2^2+lx3^2;...
	r24^2-lx2^2+lx4^2;...
	r34^2-lx3^2+lx4^2];

C = inv(A.'*A)*A.';

y = C*B;

toc

% ---------------------------------------------------

load('auto_corr_code_bin.mat')

hexval = binaryVectorToHex(auto_corr_code)

% ---------------------------------------------------

%
%	Samples to be used before end of array 4800
%	intense peak is 700 samples big

%
%	5574 - 9574
% figure
% hold on
% for i = 1:5
% 	plot(RXXr(1,:,i))
% end
% line([5574 5574],[-1 1]);
% line([9574 9574],[-1 1]);
% line([0 12000],[0.004 0.004]);

%
%	Normalising is an option to simplify threshold stuff
%
%	Threshold crossing
%	From then 4000 samples 
%	Compare
%	Repeat

%
%	Needed variables for audio transmission:
%		-Code in hex format
%		-nSamplesRec
%

tresh = 0.004;

run = 1;

while run
	find threshold
	record
	analyse
end
