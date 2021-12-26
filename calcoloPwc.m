function [Pwc,nPwc] = calcoloPwc(A)
n=size(A,1);
Pwc=0;
D=graphallshortestpaths(A); % matrice stessa dim di A dove ci viene indicata la lunghezza del cammino minimo 
% tra due nodi (NB il caso Inf vuol dire che è disconnesso)
for i=1:n
    for j=1:n
        if not(D(i,j)==0) || isinf(D(i,j))
            Pwc=Pwc+1;
        end
    end
end
nPwc=Pwc/(n^2-n);
end