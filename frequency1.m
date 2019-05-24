%This m-file is called frequency.m
%x is a data vector with nonnegative integer components
%F=frequency(x) is the vector whose components are the
%frequencies with which each symbol in x appears in x,
%from least frequent to most frequent
%by: Ramin Eslami

function F = frequency1(x)
x = sort(x);

j=1; F(1)=1;
for i=2:length(x)
  
    if x(i) == x(i-1)
        F(j)=F(j)+1;
    else
        j=j+1;
        F(j)=1;
    end
    
end

F = sort(F);
