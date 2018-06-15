function [location] = loc2(r, maze)
<<<<<<< HEAD
% Input: een vector met 10 TDOA waardes voor 5 mics in [cm]
=======
% Input: een vector met 10 TDOA waardes voor 5 mics in [cm],
%        maze vector (maze = createmaze(res); % resolutie in [cm],
%                      zie resolutie hieronder)
%
>>>>>>> 3d79ba085db5b14c0342a947944f6b62976e374d
% Output: [x,y] van de car in [cm]
%---------------------------------
res = 4;        % resolutie in [cm], hele deler van 460 aub
res2 = res/2;
<<<<<<< HEAD
%maze = createmaze(res); % resolutie in cm
=======
d = 7;          % narrowed search interval
d2 = 2*d;
>>>>>>> 3d79ba085db5b14c0342a947944f6b62976e374d

r = r(:);
min_error = 10000;
for p=1:(460/20)
    for q=1:(460/20)
        pp = 5*p; qq = 5*q;
        mazetmp = reshape(maze(pp,qq,:),10,1);
        error = rms(mazetmp - r);
        if error < min_error
            min_error = error;
            loctmp = [pp,qq];
        end
    end
end
pindex = [loctmp(1)-d:loctmp(1)+d-1];
qindex = [loctmp(2)-d:loctmp(2)+d-1];
if pindex(1) < 1
    pindex = [1:d2];
elseif pindex(d2) > 115
    pindex = [(116-d2):115];
end
if qindex(1) < 1
    qindex = [1:d2];
elseif qindex(d2) > 115
    qindex = [(116-d2):115];
end
for p = 1:d2
    for q = 1:d2
        mazetmp = reshape(maze(pindex(p),qindex(q),:),10,1);
        error = rms(mazetmp - r);
        if error <= min_error
            min_error = error;
            loctmp = [pindex(p),qindex(q)];
        end
    end
end
location = [res*loctmp(1)-res2, res*loctmp(2)-res2];