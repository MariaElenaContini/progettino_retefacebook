function [importancePwc]=pairwiseconnectivity(Adj,vettore_nodi_piu_collegati)
n=size(Adj,1);
maxcon=(n*(n-1)); 
importancePwc=[];
for i= 1:length(vettore_nodi_piu_collegati)
    %rimuovere nodo i
    A_temp= Adj;% copio 
    A_temp(vettore_nodi_piu_collegati(i),:)=0;
    A_temp(:,vettore_nodi_piu_collegati(i))=0;
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