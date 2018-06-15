function [locatiematrix] = loctestfunction(carf,epsf,epsf2)

%------------------------------------------------%
% TDOA waardes genereren                         %
%------------------------------------------------%
d1 = sqrt(sum((carf - m1).^2));
d2 = sqrt(sum((carf - m2).^2));
d3 = sqrt(sum((carf - m3).^2));
d4 = sqrt(sum((carf - m4).^2));
d5 = sqrt(sum((carf - m5).^2));

r =  [d1 - d2 - epsf + epsf2*rand(1);
      d1 - d3 - epsf + epsf2*rand(1);
      d1 - d4 - epsf + epsf2*rand(1);
      d1 - d5 - epsf + epsf2*rand(1);
      d2 - d3 - epsf + epsf2*rand(1);
      d2 - d4 - epsf + epsf2*rand(1);
      d2 - d5 - epsf + epsf2*rand(1);
      d3 - d4 - epsf + epsf2*rand(1);
      d3 - d5 - epsf + epsf2*rand(1);
      d4 - d5 - epsf + epsf2*rand(1)];
%--------------------------------------------------%
%       LOCALIZATION                               %
%--------------------------------------------------%
locatiematrix(1,:) = carf(Ni,1:2);
locatiematrix(2,:) = [res, eps(Ni)];
tic
r = r(:);
%------------------------------------------------%
% Loc1                                           %
%------------------------------------------------%
rA = -2*r;

A = [2*pos(1,:),  rA(1),      0,      0,      0;
     2*pos(2,:),      0,  rA(2),      0,      0;
     2*pos(3,:),      0,      0,  rA(3),      0;
     2*pos(4,:),      0,      0,      0,  rA(4);
     2*pos(5,:),      0,  rA(5),      0,      0;
     2*pos(6,:),      0,      0,  rA(6),      0;
     2*pos(7,:),      0,      0,      0,  rA(7);
     2*pos(8,:),      0,      0,  rA(8),      0;
     2*pos(9,:),      0,      0,      0,  rA(9);
     2*pos(10,:),     0,      0,      0,  rA(10)];

C = [r(1)^2 - sum((m1).^2) + sum((m2).^2);
     r(2)^2 - sum((m1).^2) + sum((m3).^2);
     r(3)^2 - sum((m1).^2) + sum((m4).^2);
     r(4)^2 - sum((m1).^2) + sum((m5).^2);
     r(5)^2 - sum((m2).^2) + sum((m3).^2);
     r(6)^2 - sum((m2).^2) + sum((m4).^2);
     r(7)^2 - sum((m2).^2) + sum((m5).^2);
     r(8)^2 - sum((m3).^2) + sum((m4).^2);
     r(9)^2 - sum((m3).^2) + sum((m5).^2);
     r(10)^2 - sum((m4).^2) + sum((m5).^2)];
 
location = pinv(A)*C;
location1 = location(1:2).';
locatiematrix(3,:) = location1;
locatiematrix(5,1) = toc;

%------------------------------------------------%
% Loc2                                           %
%------------------------------------------------%
min_error = 10000;
for p = 1:(460/res)
    for q = 1:(460/res)
        mazetmp = reshape(maze(p,q,:),10,1);
        error = rms(mazetmp - r);
        if error < min_error
            min_error = error;
            pos = [res*p-res2,res*q-res2];
        end
    end
end
location2 = pos(:).'
locatiematrix(4,:) = location2;
locatiematrix(5,2) = toc;
end
