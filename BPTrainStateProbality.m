%% 对积累概率进行BP网络训练

function newstateprob=BPTrainStateProbality(coef,stateprob)
%% 以一层的所有系数来构造BP的输入输出p和t
% 获取测试样本 针对每一个子带系数矩阵构造，调用GetBPInputAndOutput方法获取
p=[];
t=[];
for lev = 2:size(coef,2)
    for dir = 1:1:size(coef{1,lev},2)
        [ep,et] = GetBPInputAndOutput(stateprob{1,1}{1,lev}{1,dir},stateprob{1,1}{1,lev}{1,dir});        
        p=[p ep];
        t=[t et];
    end
end

%% 归一化
[p_train,ps] = mapminmax(p,0,1); %归一化
[t_train,ts] = mapminmax(t,0,1); %归一化

%[p_test,pts] = mapminmax(p_test,0,1);
% p_test =mapminmax('apply',p_test,ps);% 根据训练样本的归一化设置对测试样式进行归一化
p_test=p_train;
%%  对数据进行分组，交叉有效性验证

% [trainSamples,validateSamples,testSamples] = dividevec(p_train,p_train,0.15,0.15);
%% 初始化网络 b
% 隐藏层神经元数量为10，输出层为1
net=newff(minmax(p_train),10);
net.trainParam.epochs=100;	%最大训练次数
net.trainParam.lr=0.05;      %学习速率
net.trainParam.goal=0.00004;%期望误差最小值
%% 开始训练网络
net=train(net,p_train,t_train); 
%保存网络
save net;

%% 验证网络
%an=sim(net,p_train);
an=sim(net,p_test);

an= mapminmax('reverse',an,ts) ; % 以目标向量的归一化设置还原网络输出

%% 还原积累概率为与系数相同的结构
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


