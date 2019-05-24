% function newstateprob=PCNNTrainStateProbality(coef,stateprob,~)
%% ѭ������ͬ�߶ȡ�������Ӵ�
function S=PCNN(X) 
    %X:����ĻҶ�ͼ��,Edge:��⵽��һЩ�߽��,Numberofaera��������ڸ��ε���ʱ����Ŀ����� 
%     clear; 
%     clc; 
%     I=imread('lena1.bmp'); 
    [Xa,Ya]=size(X); 
%     subplot(1,2,1); 
    %imshow(I); 
    %X=double(I); 
    %X=double(imread('lena.bmp')); 
    Weight=[0.707 1 0.707;1 0 1;0.707 1 0.707];   %�˿�Ȩֵ�����ѡȡԭ��(���߸���)��ʲô? 
    
%     Beta=0.5; %ini 0.32

    Yuzhi=0.5;%0.6 
    Decay=0.5; %ini 0.31
    [a,b]=size(X); 
    Threshold=zeros(a,b); 
    S=zeros(a+2,b+2); 
    B=zeros(a,b);   %�������,������pixel�Ƿ񱻼����; 
    Y=zeros(a,b); 
    Edge=zeros(a,b);Numberofaera=zeros(a,b);Numberofaera_1=zeros(a,b); 
    Num_1=0;Num=0; 
    n=1; 
    while(sum(sum(B))~=Xa*Ya)   %������128*128��ͼ����ע�⡣ 
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
                        B(i0-1,i1-1)=0;   %�����һ��ȫ��������ɵ�Ӱ�� 
                    else 
                        B(i0-1,i1-1)=1;  %�ѷ�����ı�� 
                        Threshold(i0-1,i1-1)=1000;%�൱�ڲ��ᱻ�ڶ��μ��� 
                    end  
                else 
                    T(i0-1,i1-1)=0;  
                    Y(i0-1,i1-1)=0; 
                end 
            end 
        end 
    Threshold(find(B~=1))=exp(-Decay)*Threshold(find(B~=1)); 
    %������������ٲ���������� 
    if n~=1 
        Edge=Edge+judge_edge(Y,n); 
        Y(find(Edge<0))=0;   %�߽�㱻����,Y�����Ǽ���������,���ڱ߽类����, 
                             %Ҳ����˵�׼�����,B�����м�¼!��Ȼ�´ξ������ٱ����� 
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