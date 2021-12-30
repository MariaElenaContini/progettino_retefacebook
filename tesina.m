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
% Grafo
G=graph(Adj);
plot(G)

d=sum(Adj'); % vettore dei gradi
pd1 = createFit(d); % come si distribuiscono i gradi dei nodi -> dist logaritmica

nodi_importanti=10; 
vettore_nodi_piu_collegati=[];
d_temp=d;
vettore_gradi_max=[];
for k=1:nodi_importanti
    grado_max=max(d_temp); % grado massimo
    nodo=find(grado_max==d); % il nodo di grado massimo
    vettore_nodi_piu_collegati=[vettore_nodi_piu_collegati;nodo];
    vettore_gradi_max=[vettore_gradi_max;grado_max];
    d_temp(nodo)=-1;
end

importancePwc=pairwiseconnectivity(Adj,vettore_nodi_piu_collegati);
importanceDegree=vettore_gradi_max/max(d);

[C,C_mean]=coefClusteringMedio(Adj);
%[R]=plot3d(Adj); 

%N_CLUSTER=
%[CENTER, U, OBJ_FCN] = fcm(Adj, N_CLUSTER)
