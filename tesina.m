clear all
close all
clc
%%% Grafo indiretto
ARCHI= importdata('fb-pages-politician_edges.txt');
ARCHI=ARCHI+1;
ntemp= max(ARCHI);
n= max(ntemp(1:2));

nodi=importdata('fb-pages-politician_nodes.txt');
Name=nodi.textdata(2:end,2);
ID=nodi.data;
T=table(Name,ID); % tabella dei nomi

Adj= zeros(n,n);

for i= 1:length(ARCHI)
    from=ARCHI(i,1);
    to= ARCHI(i,2);
    Adj(from,to)=1;
    Adj(to,from)=1;
end
% Grafo
figure()
G=graph(Adj);
plot(G)

degree=sum(Adj'); % vettore dei gradi

mean_degree=mean(degree);
max_degree=max(degree);
min_degree=min(degree);

link= G.numedges;
density=(2*link)/(n*(n-1));
%% Diametri
d=distances(G);
x=1:n;
diam_i= max(d(x,:));
figure()
hist(diam_i)

%% Distribuzione del grafo
figure()
pd1 = createFit(degree); % come si distribuiscono i gradi dei nodi -> dist logaritmica

%% Confronto importanza dei nodi
nodi_importanti=15; 
vettore_nodi_piu_collegati=[];
d_temp=degree;
vettore_gradi_max=[];
Nomi_nodi=[];
for k=1:nodi_importanti
    grado_max=max(d_temp); % grado massimo
    nodo=find(grado_max==degree); % il nodo di grado massimo
    vettore_nodi_piu_collegati=[vettore_nodi_piu_collegati;nodo];
    vettore_gradi_max=[vettore_gradi_max;grado_max];
    id=find(nodo==T.ID);
    Nomi_nodi=[Nomi_nodi;T.Name(id)];
    d_temp(nodo)=-1;
end
importancePwc=pairwiseconnectivity(Adj,vettore_nodi_piu_collegati);
importanceDegree=vettore_gradi_max/max(degree);

[closeness] = closeness(Adj);
closeness_nodi_piu_collegati=[];

for i=1:length(vettore_nodi_piu_collegati)
    closeness_nodi_piu_collegati=[closeness_nodi_piu_collegati;closeness(vettore_nodi_piu_collegati(i))];
end

[eig_centrality]=eigvectorcentrality(Adj,vettore_nodi_piu_collegati);


% TABELLA per il confronto dei dati ottenuti:
confronto_importanza=table(Nomi_nodi,importanceDegree,importancePwc,closeness_nodi_piu_collegati,eig_centrality);
x=[1:1:nodi_importanti];
figure()
plot(x,importanceDegree,'-r')
hold on
plot(x,importancePwc,'-b')
plot(x,closeness_nodi_piu_collegati,'-g')
plot(x,eig_centrality,'-k')
axis([1 10 0 1.5]);
ylabel('Valore');
xlabel('Nodo');

%% Elimino i nodi più importanti:

vettore_centri=[find(importanceDegree==1);find(importancePwc==1);...
    find(closeness_nodi_piu_collegati==1);find(eig_centrality==1)];
figure()
highlight(plot(G),vettore_centri(3),'NodeColor','r','MarkerSize',10)

vettori_nodi=[];
figure()
hold on
for i=1:length(vettore_centri)
    subplot(2,2,i)
    G_copy=G;
    G_copy=rmnode(G_copy,vettore_nodi_piu_collegati(vettore_centri(i)));
    plot(G_copy)
end
%% Connettività del grafo
% Coefficiente di clustering Medio e il rapporto lamba due/ lamba n
[c]=coefClusteringMedio(Adj,G);
[e]=EigenvalueConnectivity(Adj);

%% Clustering kmeans 

% Verifichiamo il numero ottimo per effetuare un clustering kmeans
eva = evalclusters(ARCHI,'kmeans','CalinskiHarabasz','KList',1:6);

[idx,C] = kmeans(ARCHI,3);
figure()

plot(ARCHI(idx==1,1),ARCHI(idx==1,2),'r.','MarkerSize',12)

hold on

plot(ARCHI(idx==2,1),ARCHI(idx==2,2),'b.','MarkerSize',12)

plot(ARCHI(idx==3,1),ARCHI(idx==3,2),'g-','MarkerSize',12)

plot(C(:,1),C(:,2),'kx','MarkerSize',15,'LineWidth',3)

legend('Cluster 1','Cluster 2','Cluster 3','Centroids','Location','NW')

title 'Cluster Assignments and Centroids'

hold off
%% Spanning tree a partire dai
figure()
hold on
for i=1:length(vettore_centri)
    subplot(2,2,i)
    tree=shortestpathtree(G,vettore_nodi_piu_collegati(vettore_centri(i)));
    plot(tree)
end

