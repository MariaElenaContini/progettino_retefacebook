function [e]=EigenvalueConnectivity(Adj)
[U,V]=eig((diag(sum(Adj'))-Adj));
n=size(Adj,1);
e=V(2,2)/V(n,n);
end