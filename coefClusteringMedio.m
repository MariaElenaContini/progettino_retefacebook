function [C]=coefClusteringMedio(Adj,G)
degree= sum(Adj');
n=size(Adj,1);
c=zeros(n,1);% coef di clastering dei nodi
for i=1:n 
    vicini_di_i=find(Adj(i,:)==1);
    if length(vicini_di_i)==1
        c(i)=0;
    else
        sub_graph=subgraph(G,vicini_di_i);
        num_c= numedges(sub_graph);
        den_c=degree(i)*(degree(i)-1);
        c(i)= 2*num_c/den_c;
    end
end
C=mean(c);
end 



