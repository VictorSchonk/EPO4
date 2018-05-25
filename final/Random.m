Nbits = 32;

hold on;
for i = 1:100
    seq(i,:) = randi([0 1],1,Nbits);
    auto(i,:) = conv(seq(i,:),fliplr(seq(i,:)));
    try
        if (max(auto(i,:)) > 20)
            y = i;
        end
    catch
        auto(i) = 0;
    end
    plot(auto(i,:));
end
