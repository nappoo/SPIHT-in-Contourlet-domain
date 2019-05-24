% function newstateprob=PCNNTrainStateProbality(coef,stateprob,~)
%% 循环处理不同尺度、方向的子带
function S=PCNN(X) 
    %X:输入的灰度图像,Edge:检测到的一些边界点,Numberofaera则表明了在各次迭代时激活的块区域 
%     clear; 
%     clc; 
%     I=imread('lena1.bmp'); 
    [Xa,Ya]=size(X); 
%     subplot(1,2,1); 
    %imshow(I); 
    %X=double(I); 
    %X=double(imread('lena.bmp')); 
    Weight=[0.707 1 0.707;1 0 1;0.707 1 0.707];   %此可权值矩阵的选取原则(或者根据)是什么? 
    
%     Beta=0.5; %ini 0.32

    Yuzhi=0.5;%0.6 
    Decay=0.5; %ini 0.31
    [a,b]=size(X); 
    Threshold=zeros(a,b); 
    S=zeros(a+2,b+2); 
    B=zeros(a,b);   %标记样板,表明该pixel是否被激活过; 
    Y=zeros(a,b); 
    Edge=zeros(a,b);Numberofaera=zeros(a,b);Numberofaera_1=zeros(a,b); 
    Num_1=0;Num=0; 
    n=1; 
    while(sum(sum(B))~=Xa*Ya)   %若采用128*128的图像，须注意。 
        for i0=2:a+1 
            for i1=2:b+1 
                V=[S(i0-1,i1-1) S(i0-1,i1) S(i0-1,i1+1); 
                    S(i0,i1-1) S(i0,i1) S(i0,i1+1); 
                    S(i0+1,i1-1) S(i0+1,i1) S(i0+1,i1+1)];  
                L=sum(sum(V.*Weight)); 
                F=X(i0-1,i1-1);
                Beta=0;
                for i=1:3
                    for j=1:3
                        Beta=Beta+exp(-(V(2,2)-V(i,j))^2)/100;%shuyuanyang  sailency+clarity
                    end
                end
                Beta=(Beta-1)/8;
                U=double(F)*(1+Beta*double(L)); 
                if U>=Threshold(i0-1,i1-1)||Threshold(i0-1,i1-1)<=0.3%0.5
                    T(i0-1,i1-1)=1;    
                    Threshold(i0-1,i1-1)=Yuzhi; 
                    Y(i0-1,i1-1)=1; 
                    if n==1 
                        B(i0-1,i1-1)=0;   %避免第一次全部激发造成的影响 
                    else 
                        B(i0-1,i1-1)=1;  %已发射过的标记 
                        Threshold(i0-1,i1-1)=1000;%相当于不会被第二次激活 
                    end  
                else 
                    T(i0-1,i1-1)=0;  
                    Y(i0-1,i1-1)=0; 
                end 
            end 
        end 
    Threshold(find(B~=1))=exp(-Decay)*Threshold(find(B~=1)); 
    %被激活过的像不再参与迭代过程 
    if n~=1 
        Edge=Edge+judge_edge(Y,n); 
        Y(find(Edge<0))=0;   %边界点被置零,Y本来是激发的像素,现在边界被置零, 
                             %也不能说白激发了,B矩阵有纪录!当然下次就休想再被激发 
        [Numberofaera_1,Num_1]=bwlabel(Y,4); 
        for i=1:a 
            for j=1:b 
                if Numberofaera_1(i,j)~=0 
                     Numberofaera_1(i,j)=Numberofaera_1(i,j)+Num;       
                end 
            end 
        end 
        Numberofaera=Numberofaera+Numberofaera_1; 
        Num=Num_1; 
    end 
    if n==1 
        S=zeros(a+2,b+2); 
    else 
        S=Bianhuan(T); 
    end 
    n=n+1; 
    end  %while