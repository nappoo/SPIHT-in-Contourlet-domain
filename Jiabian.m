   function Y=Jiabian(X) 
    [m,n]=size(X); 
    Y=zeros(m+2,n+2); 
    for i=1:m+2 
        for j=1:n+2 
            if i==1&j~=1&j~=n+2 
                Y(i,j)=X(1,j-1); 
            elseif j==1&i~=1&i~=m+2 
                    Y(i,j)=X(i-1,1); 
            elseif i~=1&j==n+2&i~=m+2 
                    Y(i,j)=X(i-1,n); 
            elseif i==m+2&j~=1&j~=n+2 
                Y(i,j)=X(m,j-1); 
            elseif i==1&j==1 
                Y(i,j)=X(i,j); 
            elseif i==1&&j==n+2 
                Y(i,j)=X(1,n); 
            elseif i==(m+2)&j==1 
                Y(i,j)=X(m,1); 
            elseif i==m+2&j==n+2 
                Y(i,j)=X(m,n); 
            else 
                Y(i,j)=X(i-1,j-1); 
            end 
         end 
    end 