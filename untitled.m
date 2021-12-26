clear all
close all
clc

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

% G=graph(Adj);
% plot(G)
hold on
plot(digraph(Adj))
A=(Adj+Adj')>0;
L=diag(sum(A'))-A;

[eigVec,eigVal]=eig(L);

secondo_autovettore=eigVec(:,2);
POS=[eigVec(:,2),eigVec(:,3)];
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

gplot(A,POS)
hold on
gplot(G1,POS,'r-')
gplot(G2,POS,'g-')

[idx,centroidi]=kmeans(POS,3);

figure()

K1=zeros(size(A));
K2=zeros(size(A));
K3=zeros(size(A));

for i=1:length(A)
    for j=1:length(A)
        if A(i,j)>0
            if idx(i)==1 && idx(j)==1
                K1(i,j)=1;
                K1(j,i)=1;
            elseif idx(i)==2 && idx(j)==2
                K2(i,j)=1;
                K2(j,i)=1;
            elseif idx(i)==3 && idx(j)==3
                K3(i,j)=1;
                K3(j,i)=1;
            end
        end
    end
end

gplot(A,POS)
hold on
gplot(K1,POS,'r-')
gplot(K2,POS,'g-')
gplot(K3,POS,'c-')
NODI_ALBERO=[];
NODI_ALBERO(1).G=A;
numeronodi=1;
padre=[0];

espanso=DAESPANDERE(1);
DAESPANDERE=DAESPANDERE(2:end);

[G1,G2]=spezzaindue(A);
padre=[padre,espanso,espanso];
NODI_ALBERO(numeronodi+1).G=G1;
NODI_ALBERO(numeronodi+2).G=G2;
DAESPANDERE=[DAESPANDERE,numeronodi+1,numeronodi+2];
