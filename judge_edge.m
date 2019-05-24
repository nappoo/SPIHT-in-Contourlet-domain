function Y=judge_edge(X,n)   %X:每次迭代后PCNN输出的二值图像,如何准确判断边界点是关键 
    [a,b]=size(X); 
    T=Jiabian(X); 
    Y=zeros(a,b); 
    W=zeros(a,b); 
    for i=2:a+1 
        for j=2:b+1 
            if(T(i,j)==1)&((T(i-1,j)==0&T(i+1,j)==0)|(T(i,j-1)==0&T(i,j+1)==0)|(T(i-1,j-1)==0&T(i+1,j+1)==0)|(T(i+1,j-1)==0&T(i-1,j+1)==0)) 
                Y(i-1,j-1)=-n; 
            end 
        end 
    end 