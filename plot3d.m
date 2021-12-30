function [R]=plot3d(A)
n= size(A,1);
L=diag(sum(A'))-A;
[U,V]=eig(L);
R=U(:,[2,3,4]);
figure()
for i=1:n
    for j=1:n
        if A(i,j)>0
            coord_x=[R(i,1),R(j,1)];
            coord_y=[R(i,2),R(j,2)];
            coord_z=[R(i,3),R(j,3)];
            plot3(coord_x,coord_y,coord_z)
            hold on
        end
    end
end
end