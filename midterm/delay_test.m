for i = 1:1000
	tic;
	a = EPOCommunications('transmit','S');
	dl(i) = toc;
end