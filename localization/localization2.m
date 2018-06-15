carh = 26;  mich = 50; mic5h = 80;
md = mich - carh;   m5d = mic5h - carh;

N = 7; eps = 10;

car = [229, 229, carh];
m1 = [460, 0, mich];
m2 = [0, 0, mich];
m3 = [0, 460, mich];
m4 = [460, 460, mich];
m5 = [230, 460, mic5h];

d1 = sqrt(sum((car - m1).^2));
d2 = sqrt(sum((car - m2).^2));
d3 = sqrt(sum((car - m3).^2));
d4 = sqrt(sum((car - m4).^2));
d5 = sqrt(sum((car - m5).^2));

r =  [d1 - d2 - 10 + 20*rand(1);
      d1 - d3 - 10 + 20*rand(1);
      d1 - d4 - 10 + 20*rand(1);
      d1 - d5 - 10 + 20*rand(1);
      d2 - d3 - 10 + 20*rand(1);
      d2 - d4 - 10 + 20*rand(1);
      d2 - d5 - 10 + 20*rand(1);
      d3 - d4 - 10 + 20*rand(1);
      d3 - d5 - 10 + 20*rand(1);
      d4 - d5 - 10 + 20*rand(1)];
  
  % Input: een vector met 10 TDOA waardes voor 5 mics in [cm]
% Output: [x,y] van de car in [cm]
%---------------------------------

res = 4; % resolutie in [cm], hele deler van 460 aub
res2 = res/2;
maze = createmaze(res); % resolutie in cm
tic
r = r(:);
min_error = 10000;
for p=1:23
    for q=1:23
        pp = 5*p; qq = 5*q;
        mazetmp = reshape(maze(pp,qq,:),10,1);
        error = rms(mazetmp - r);
        if error < min_error
            min_error = error;
            loctmp = [pp,qq];
        end
    end
end
pindex = [loctmp(1)-7:loctmp(1)+6];
qindex = [loctmp(2)-7:loctmp(2)+6];
if pindex(1) < 1
    pindex = [1:14];
elseif pindex(14) > 115
    pindex = [102:115];
end
if qindex(1) < 1
    qindex = [1:14];
elseif qindex(14) > 115
    qindex = [102:115];
end
for p = 1:14
    for q = 1:14
        mazetmp = reshape(maze(pindex(p),qindex(q),:),10,1);
        error = rms(mazetmp - r);
        if error <= min_error
            min_error = error;
            loctmp = [pindex(p),qindex(q)];
        end
    end
end
location = [4*loctmp(1)-2,4*loctmp(2)-2]
toc
