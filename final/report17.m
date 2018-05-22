load('received.mat');

[h,H] = ch3(y1,y2);
t = -length(h)/2:1:(length(h)-1)/2;
plot(t,ifftshift(h));
xlabel('Sample index');
ylabel('Amplitude');
title('Time domain channel estimation');
figure;

ind = find(h == max(h)); % Find the sample with maximal value

% for negative distances.
if ind > 0.5*length(h)
	ind = ind-length(h); 
end

dt = ind/Fs;	% Compute the DTOA
dist = 343*dt;	% Compute distance

% Plotting the signal
subplot(211);
plot(y1);
hold on;
plot(y2);
title('Full signals');
xlabel('Sample in time');
ylabel('Amplitude');
legend('Closest signal','Signal 25 cm further away');
subplot(212);
plot(y1);
hold on;
plot(y2);
title('zoomed in peak to show the delay');
xlabel('Sample in time');
ylabel('Amplitude');
legend('Closest signal','Signal 25 cm further away');
xlim([51500 54000]);

% dt = DTOA(y1,y2,Fs,35000,60000)
% dist = dt*343

% plot(y1);
% hold on;
% plot(y2);