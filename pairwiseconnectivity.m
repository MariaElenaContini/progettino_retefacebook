function [importancePwc]=pairwiseconnectivity(Adj,n)
maxcon=(n*(n-1)); 
importancePwc=[];
for i= 1:n
    %rimuovere nodo i
    A_temp= Adj;% copio 
    A_temp(i,:)=0;
    A_temp(:,i)=0;
    dist=graphallshortestpaths(sparse(A_temp)) ;% restituisce la distanza tra i nodi
    %dist(i,j)=inf vuol dire che non c'e cammino tra i e j
    dist(find(dist==inf))=0;
    dist=(dist>0);
    Pwc=sum(sum(dist));
    nPwc=Pwc/maxcon;
    importancePwc=[importancePwc;1-nPwc];
end
% Normalizzazione dei dati
importancePwc=importancePwc./max(importancePwc);
end