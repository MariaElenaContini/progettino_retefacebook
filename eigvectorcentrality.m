function [v]=eigvectorcentrality(A,nodi_importanti)
G=graph(A);
eig_centrality= centrality(G,'eigenvector');
v=[];

for i=1:length(nodi_importanti)
    v=[v;eig_centrality(nodi_importanti(i))];
end
v=v/max(eig_centrality);
end