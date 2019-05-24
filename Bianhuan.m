 function Y=Bianhuan(X) 
    [m,n]=size(X); 
    Y=zeros(m+2,n+2); 
    for i=1:m+2 
        for j=1:n+2 
            if i==1||j==1||i==m+2||j==n+2 
                Y(i,j)=0; 
            else         
                Y(i,j)=X(i-1,j-1); 
            end 
        end 
    end 