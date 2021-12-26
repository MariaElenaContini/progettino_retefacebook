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

% CENTRALITA' PWC
% dipende da quanto il grafo rimane connesso se elimino quel nodo
importancePwc=pairwiseconnectivity(Adj,n);

figure()
stem(importancePwc)
hold on

% CENTRALITA' DI GRADO:
% dipende dal grado del nodo, quando piu è grande il suo grado tanto più il
% nodo è importante
importanceDegree=degree(Adj);

stem(importanceDegree,'r')

% CENTRALITA' rispetto alla CLOSENESS
% indica quanto un nodo è vicino agli altri nodi della rete

% CENTRALITA' con metodo degli AUTOVETTORI
% un nodo è tanto piu importante tanto è collegato a nodi altrettanto importanti 

% CENTRALITA DI POSIZIONE
% permette di determinare il nodo che occupa la posizione piu centrale
% nella rete di modo che se deve mandare informazioni a tutti gli altri
% nodi lo farà nel minor tempo possibile
