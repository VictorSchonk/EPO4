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