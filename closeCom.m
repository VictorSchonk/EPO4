function closeCom()
%CLOSECOM This function can be used to close the COM-port.
%   The closing of the COM-port implemented in a function might be used to
%   improve robustness.

	EPOCommunications('close');

end

