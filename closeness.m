function [closeness] = closeness(Adj)
    G=graph(Adj);

    dist=distances(G); 

    closeness=sum(dist, 2);
    closeness= 1./closeness;
    % Normalizzazione dei dati
    closeness= closeness./max(closeness);
end