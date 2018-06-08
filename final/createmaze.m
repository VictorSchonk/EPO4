function [maze] = createmaze(res)
mic = [460,  0, 50;
         0,  0, 50;
         0,460, 50;
       460,460, 50;
       230,460, 80];
maze = zeros(115,115,10);
res2 = res/2;
h = 26;

for p=1:115
    for q=1:115
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