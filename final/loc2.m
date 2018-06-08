function [location] = loc2(r)
% Input: een vector met 10 TDOA waardes voor 5 mics in [cm]
% Output: [x,y] van de car in [cm]
%---------------------------------
% maze = createmaze(4); % resolutie in cm

min_error = 10000;
for p=1:115
    for q=1:115
        mazetmp = [maze(p,q,1);maze(p,q,2);maze(p,q,3);maze(p,q,4);
        maze(p,q,5);maze(p,q,6);maze(p,q,7);maze(p,q,8);maze(p,q,9);maze(p,q,10)];
        error = rms(mazetmp - r);
        if error < min_error
            min_error = error;
            pos = [4*p-2,4*q-2];
        end
    end
end
location = pos;
end