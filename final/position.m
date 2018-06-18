function [xout,yout,dirout] = position(lastx,lasty,calcdir)
%POSITION Calculate the position and direction
%   lastx	|	Last x position in order to calculate direction
%				And to check if location in reasonable
%	lasty	|	Last y position in order to calculate direction
%				And to check if location in reasonable
%	calcdir |	0 not to calculate direction
%				1 to calculate direction
%-----------
%	xout	|	New x position
%	yout	|	New y position
%	dirout	|	Calculated direction with last x,y and new x,y

	derr = 70;	%Used to detect if the new position is reasonable 
				%compared to the old position

	%Measure position 5 times to be able to take the average and improve
	%accuracy
	rec1 = record();		% Record 24000 samples.
	times1 = ch_td(rec1,lastx,lasty);	% Calculate all the times.
	[x1,y1,~] = loc2(times1);	% Calculate the position.
	
	rec2 = record();		% Record 24000 samples.
	times2 = ch_td(rec2,lastx,lasty);	% Calculate all the times.
	[x2,y2,~] = loc2(times2);	% Calculate the position.
	
	rec3 = record();		% Record 24000 samples.
	times3 = ch_td(rec3,lastx,lasty);	% Calculate all the times.
	[x3,y3,~] = loc2(times3);	% Calculate the position.
	
	rec4 = record();		% Record 24000 samples.
	times4 = ch_td(rec4,lastx,lasty);	% Calculate all the times.
	[x4,y4,~] = loc2(times4);	% Calculate the position.
	
	rec5 = record();		% Record 24000 samples.
	times5 = ch_td(rec5,lastx,lasty);	% Calculate all the times.
	[x5,y5,~] = loc2(times5);	% Calculate the position.
	
	pos =		[x1,x2,x3,x4,x5;
				 y1,y2,y3,y4,y5];
			 
	for i = 1:5
		if sqrt((pos(i,1)-lastx)^2 + (pos(i,2)-lasty)^2) > derr
			pos(i,1) = 0;
			pos(i,2) = 0;
		end
	end
	
	length = nnz(pos);		%Amount of non-zero coordinates
	vec = nonzeros(pos);	%A vector with all non-zero coordinate values
	
	for i = 1:length/2;
		xpos(i,:) = vec(2*i-1);	%Vector with non-zero x-coordinates
		ypos(:,i) = vec(2*i);	%Vector with non-zero y-coordinates
	end
	
	xpos = xpos.';
	
	xout = sum(xpos)/length(xpos);	%Take the average of the coordinates as
	yout = sum(ypos)/length(ypos);	%output. 
		
	if calcdir
		if xout == lastx
			if yout > lasty
				dirout = 90;
			elseif yout < lasty
				dirout = 270;
			else
				dirout = 'error';
			end
		elseif xout > lastx
			dirout = mod(radtodeg(atan((yout-lasty)/(xout-lastx))),360);
		elseif xout < lastx
			dirout = mod((180+radtodeg(atan((yout-lasty)/(xout-lastx)))),360);
		else
			dirout = 'error';
		end
	else
		dirout = 'no';
	end

end

