cport = 6;		% Com port to use.

try
	
	openCom(cport);
	
	
	
	closeCom();
	
catch
	closeCom();
end