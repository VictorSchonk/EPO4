function [h,H] = ch3(x,y)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

%%% Commented due to prior analysation of the refence signal!!
%     div_e = 0.1;%0.5; % multiplier to calculate epsilon (threshold to discard noise amplification.

    Ny = length(y);
    Nx = length(x);
    
%%% Commented due to prior analysation of the refence signal!!
% 	if max(abs(x)) >= max(abs(y))
% 		epsx = max(abs(x))*div_e;
% 		indx = find(abs(x) < epsx);
% 		for i = 1:length(x)
% 			if any(i == indx)
% 				x(i) = 0;
% 			end
% 		end
% 	else
% 		epsy = max(abs(y))*div_e;
% 		indy = find(abs(y) < epsy);
% 		for i = 1:length(y)
% 			if any(i == indy)
% 				y(i) = 0;
% 			end
% 		end
% 	end
		
	% 	for i = 1:length(ind)
	% 		ii = ind(i);
	% 		H(ii) = 0;
	% 	end
	%   for i = 1:Ny
	%		if any(i == ind)
	%			H(i) = 0;
	%       end
	% 	end
	
	Y = fft(y,max(Nx,Ny));
	X = fft(x,max(Nx,Ny));
    
    H = Y ./ X;                 % frequency domain deconvolution
    h = ifft(H);

end

