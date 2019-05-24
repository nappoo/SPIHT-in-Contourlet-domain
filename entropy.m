%The name of this m-file is entropy.m
%x is a data vector
%y=entropy(x) is the entropy of x
%Ramin Eslami

function y = entropy(x)
P=frequency1(x)/length(x);
y=sum(-P.*log2(P));

