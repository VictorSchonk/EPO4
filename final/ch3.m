function [h,H] = ch3(x,y)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

    div_e = 0.1; % multiplier to calculate epsilon (threshold to discard noise amplification.

    Ny = length(y);
    Nx = length(x);
    L = Ny - Nx + 1;
    
    if Nx == Ny
        Y = fft(y);
        X = fft(x);   % zero padding to manage Ny    [x; zeros(Ny - Nx + 1,1)]
    elseif Ny > Nx
        Y = fft(y);
        X = fft([x; zeros(Ny - Nx,1)]);
    else
        Y = fft([y; zeros(Nx - Ny,1)]);
        X = fft(x);
	end
        
    eps = max(abs(X))*div_e;
    ind = find(abs(X) < eps);
    
    H = Y ./ X;                 % frequency domain deconvolution
	
    test = abs(H);
    test = [test, ifft(H)];
    
% 	for i = 1:length(ind)
% 		ii = ind(i);
% 		H(ii) = 0;
% 	end
    for i = 1:Ny
        if any(i == ind)
            H(i) = 0;
        end
	end
	
    test = [test, abs(H)];
    
    h = ifft(H);
    
    test = [test, h];

end

