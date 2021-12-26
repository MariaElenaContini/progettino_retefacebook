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

% PWC
importancePwc=pairwiseconnectivity(Adj,n);

figure()
stem(importancePwc)
hold on

% grado dei nodi
importanceDegree=degree(Adj);

stem(importanceDegree,'r')


