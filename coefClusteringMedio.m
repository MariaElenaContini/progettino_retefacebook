function [C]=coefClusteringMedio(A)
n=size(A,1);
c=zeros(n,1);
for i=1:n
    L=0; % i vicini di del nodo i-esimo che sono vicini
    vicini_di_i=find(A(i,:)==1);
    for j=1:length(vicini_di_i)
        vicini_di_j=find(A(vicini_di_i(j),:)==1);
        for k=1:length(vicini_di_j)
            if not(isempty(find(vicini_di_j(k)==vicini_di_i))) 
                L=L+0.5; % perche ogni link è contato due volte
            end
        end
    end
    if L==0
        c(i)=0;
    else
        c(i)=(2*L)/(length(vicini_di_i)*(length(vicini_di_i)-1));
    end
end
C=mean(c);
end