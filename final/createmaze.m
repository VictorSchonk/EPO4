function [maze] = createmaze(res)
%createmaze is a function.
%     [maze] = createmaze(res)
%	res = 4 is the only one that works at the moment


mic = [460,  0, 50;
         0,  0, 50;
         0,460, 50;
       460,460, 50;
       230,460, 80];
maze = zeros(460/res,460/res,10);
res2 = res/2;
h = 26;

for p=1:(460/res)
    for q=1:(460/res)
        maze(p,q,:) = [sqrt(sum((mic(1,:)-[res*p-res2,res*q-res2,h]).^2)) - sqrt(sum((mic(2,:)-[res*p-res2,res*q-res2,h]).^2));
                       sqrt(sum((mic(1,:)-[res*p-res2,res*q-res2,h]).^2)) - sqrt(sum((mic(3,:)-[res*p-res2,res*q-res2,h]).^2));
                       sqrt(sum((mic(1,:)-[res*p-res2,res*q-res2,h]).^2)) - sqrt(sum((mic(4,:)-[res*p-res2,res*q-res2,h]).^2));
                       sqrt(sum((mic(1,:)-[res*p-res2,res*q-res2,h]).^2)) - sqrt(sum((mic(5,:)-[res*p-res2,res*q-res2,h]).^2));
                       sqrt(sum((mic(2,:)-[res*p-res2,res*q-res2,h]).^2)) - sqrt(sum((mic(3,:)-[res*p-res2,res*q-res2,h]).^2));
                       sqrt(sum((mic(2,:)-[res*p-res2,res*q-res2,h]).^2)) - sqrt(sum((mic(4,:)-[res*p-res2,res*q-res2,h]).^2));
                       sqrt(sum((mic(2,:)-[res*p-res2,res*q-res2,h]).^2)) - sqrt(sum((mic(5,:)-[res*p-res2,res*q-res2,h]).^2));
                       sqrt(sum((mic(3,:)-[res*p-res2,res*q-res2,h]).^2)) - sqrt(sum((mic(4,:)-[res*p-res2,res*q-res2,h]).^2));
                       sqrt(sum((mic(3,:)-[res*p-res2,res*q-res2,h]).^2)) - sqrt(sum((mic(5,:)-[res*p-res2,res*q-res2,h]).^2));
                       sqrt(sum((mic(4,:)-[res*p-res2,res*q-res2,h]).^2)) - sqrt(sum((mic(5,:)-[res*p-res2,res*q-res2,h]).^2))];
    end
end
end