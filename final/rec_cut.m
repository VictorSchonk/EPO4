function [outArg] = rec_cut(inArg)
%REC_CUT Function to cut an input of size nmic (5 in our case)
%
%to thecut_length (11000 in our case)
%
%with 50 leading samples
%	from the point at which it gets higher than thresh (0.01 in our case).

	nmic = 5;			% The amount of recorded channels
	thresh = 0.01;		% Treshold value to detect when something is transmitted
	cut_length = 11000;	% length of the cutted up recording
	
	try
		for i = 1:nmic
			ind(i) = find(inArg(:,i) >= thresh,1);
			if ind(i) <= 50
				ind(i) = find(inArg(ind(i)+4000:end,i) >= thresh,1);
			end
		end
		ind(nmic+1) = min(ind);
		outArg = inArg(ind(nmic+1)-100:ind(nmic+1)+cut_length-100,:);
	catch
		outArg = inArg;
	end

end

