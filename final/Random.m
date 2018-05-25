clear all;
close all;
Nbits = 32;
r = 1;
hold on;
for i = 1:8000
    seq(i,:) = randi([0 1],1,Nbits);
    auto(i,:) = conv(seq(i,:),fliplr(seq(i,:)));
<<<<<<< HEAD
    try
        if (max(auto(i,:)) > 20)
            y = i;
=======
        if max(auto(i,:)) >= 25
            y = i
            f(:,r) = fftshift(abs(fft(auto(i,:))));
            r=r+1;
        else
            auto(i,:) = 0;
>>>>>>> 131b5b8d20829024650f4e79449451e8040e69b5
        end
    plot(auto(i,:));
end

figure(2);
plot(f);
