function[PWC,nPWC]= calcolaPWC(A)

D= graphallshortestpaths(A);

n=length(A);

PWC=0;

for i=1:n

    for j=1:n

        if not(D(i,j)==0)&& not(isinf(D(i,j)))

        PWC=PWC+1;

        end

    end

end

nPWC= PWC/(n^2-n);

end