clear all
close all
clc
%%% Grafo indiretto
ARCHI= importdata('fb-pages-politician_edges.txt');
ARCHI=ARCHI+1;
ntemp= max(ARCHI);
n= max(ntemp(1:2));

Adj= zeros(n,n);

for i= 1:length(ARCHI)
    from=ARCHI(i,1);
    to= ARCHI(i,2);
    Adj(from,to)=1;
    Adj(to,from)=1;
end

G=graph(Adj);
plot(G)

%%% Confronto importanza dei nodi tenendo conto del Pwc e il grado dei nodi

% PWC
importancePwc=[];
maxcon=(n*(n-1)); 

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
figure()
stem(importancePwc)
hold on
% grado dei nodi
grado=[];
importanceGrado=[];
for i=1:n
    grado=[grado,length(find(Adj(i,:)==1))];
    importanceGrado=grado./n;
end
stem(importanceGrado,'r')


