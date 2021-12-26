function [importanceDegree]=degree(Adj)

degree=transpose(sum(Adj'));

importanceDegree=degree./max(degree);

end