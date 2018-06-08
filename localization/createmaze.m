
mic = [460,  0, 50;
         0,  0, 50;
         0,460, 50;
       460,460, 50;
       230,460, 80];
   
h = 26;

for p=1:115
    for q=1:115
        maze(p,q,:) = [sqrt(sum((mic(1,:)-[4*p-2,4*q-2,h]).^2)) - sqrt(sum((mic(2,:)-[4*p-2,4*q-2,h]).^2));
                       sqrt(sum((mic(1,:)-[4*p-2,4*q-2,h]).^2)) - sqrt(sum((mic(3,:)-[4*p-2,4*q-2,h]).^2));
                       sqrt(sum((mic(1,:)-[4*p-2,4*q-2,h]).^2)) - sqrt(sum((mic(4,:)-[4*p-2,4*q-2,h]).^2));
                       sqrt(sum((mic(1,:)-[4*p-2,4*q-2,h]).^2)) - sqrt(sum((mic(5,:)-[4*p-2,4*q-2,h]).^2));
                       sqrt(sum((mic(2,:)-[4*p-2,4*q-2,h]).^2)) - sqrt(sum((mic(3,:)-[4*p-2,4*q-2,h]).^2));
                       sqrt(sum((mic(2,:)-[4*p-2,4*q-2,h]).^2)) - sqrt(sum((mic(4,:)-[4*p-2,4*q-2,h]).^2));
                       sqrt(sum((mic(2,:)-[4*p-2,4*q-2,h]).^2)) - sqrt(sum((mic(5,:)-[4*p-2,4*q-2,h]).^2));
                       sqrt(sum((mic(3,:)-[4*p-2,4*q-2,h]).^2)) - sqrt(sum((mic(4,:)-[4*p-2,4*q-2,h]).^2));
                       sqrt(sum((mic(3,:)-[4*p-2,4*q-2,h]).^2)) - sqrt(sum((mic(5,:)-[4*p-2,4*q-2,h]).^2));
                       sqrt(sum((mic(4,:)-[4*p-2,4*q-2,h]).^2)) - sqrt(sum((mic(5,:)-[4*p-2,4*q-2,h]).^2))];
    end
end