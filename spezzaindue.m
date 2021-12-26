function [G1,G2]=spezzaindue(A)
L=diag(sum(A'))-A;
[eigVec,eigVal]=eig(L);
secondo_autovettore=eigVec(:,2);
G1=zeros(size(A));
G2=zeros(size(A));

for i=1:length(A)
    for j=1:length(A)
        if A(i,j)>0
            if secondo_autovettore(i)>0 && secondo_autovettore(j)>0
                G1(i,j)=1;
                G1(j,i)=1;
            else
                G2(i,j)=1;
                G2(j,i)=1;
            end
        end
    end
end

end