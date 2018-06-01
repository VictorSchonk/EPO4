function pos(1:3) = loc(d12, d13, d14, d15, d23, d24, d25, d34, d35, d45)
% Hier komt een hele mooie beschrijving

carh = 26;  mich = 50; mic5h = 80;
md = mich - carh;   m5d = mic5h - carh;

car = [230.01, 100, carh];
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

r =  [d1 - d2;
      d1 - d3;
      d1 - d4;
      d1 - d5;
      d2 - d3;
      d2 - d4;
      d2 - d5;
      d3 - d4;
      d3 - d5;
      d4 - d5];

pos =  [-460,   0,  0;  %2-1
        -460, 460,  0;  %3-1
           0, 460,  0;  %4-1
        -230, 460, 30;  %5-1
           0, 460,  0;  %3-2
         460, 460,  0;  %4-2
         230, 460, 30;  %5-2
         460,   0,  0;  %4-3
         230,   0, 30;  %5-3
        -230,   0, 30]; %5-4

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
 
 pos = (inv(transpose(A)*A))*transpose(A)*C;
end