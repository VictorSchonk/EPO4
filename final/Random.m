clear all;
Nbits = 32;
r = 1;
hold on;
for i = 1:2000
    seq(i,:) = randi([0 1],1,Nbits);
    auto(i,:) = conv(seq(i,:),fliplr(seq(i,:)));
        if max(auto(i,:)) >= 25
            y = i
            f(r,:) = fftshift(abs(fft(auto(i,:))));
            r=r+1;
        else
            auto(i,:) = 0;
        end
    plot(auto(i,:));
end

figure;
plot(f);
