%% �Ի��۸��ʽ���BP����ѵ��

function newstateprob=BPTrainStateProbality(coef,stateprob)
%% ��һ�������ϵ��������BP���������p��t
% ��ȡ�������� ���ÿһ���Ӵ�ϵ�������죬����GetBPInputAndOutput������ȡ
p=[];
t=[];
for lev = 2:size(coef,2)
    for dir = 1:1:size(coef{1,lev},2)
        [ep,et] = GetBPInputAndOutput(stateprob{1,1}{1,lev}{1,dir},stateprob{1,1}{1,lev}{1,dir});        
        p=[p ep];
        t=[t et];
    end
end

%% ��һ��
[p_train,ps] = mapminmax(p,0,1); %��һ��
[t_train,ts] = mapminmax(t,0,1); %��һ��

%[p_test,pts] = mapminmax(p_test,0,1);
% p_test =mapminmax('apply',p_test,ps);% ����ѵ�������Ĺ�һ�����öԲ�����ʽ���й�һ��
p_test=p_train;
%%  �����ݽ��з��飬������Ч����֤

% [trainSamples,validateSamples,testSamples] = dividevec(p_train,p_train,0.15,0.15);
%% ��ʼ������ b
% ���ز���Ԫ����Ϊ10�������Ϊ1
net=newff(minmax(p_train),10);
net.trainParam.epochs=100;	%���ѵ������
net.trainParam.lr=0.05;      %ѧϰ����
net.trainParam.goal=0.00004;%���������Сֵ
%% ��ʼѵ������
net=train(net,p_train,t_train); 
%��������
save net;

%% ��֤����
%an=sim(net,p_train);
an=sim(net,p_test);

an= mapminmax('reverse',an,ts) ; % ��Ŀ�������Ĺ�һ�����û�ԭ�������

%% ��ԭ���۸���Ϊ��ϵ����ͬ�Ľṹ
nindex=1;
for lev = 2:size(coef,2)
    for dir = 1:1:size(coef{1,lev},2)
        em=[];
        [cm,cn]=size(coef{1,lev}{1,dir});
        for k=1:cm
           em=[em;an(1,nindex:(nindex+cn-1))];
           nindex=nindex+cn;
        end
        stateprob{1,1}{1,lev}{1,dir}=em;
    end
end
newstateprob=stateprob;


