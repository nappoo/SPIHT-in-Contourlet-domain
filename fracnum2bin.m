function [binlist,qLpoint]=fracnum2bin(num,qLevel)
% 函数 FRACNUM2BIN() 根据精细扫描对应的权位 N ，将任意的十进制正数转换为二进制数，
% 包括带有任意位小数的十进制数。Matlab中的函数 dec2bin()、dec2binvec()只能将十
% 进制数的整数部分转换为二进制表示，对小数部分则不转换。
%
% 输入参数：num —— 非负的十进制数
%                 qLevel —— 量化转换精度，也可以是精细扫描对应的权位 N
% 输出参数：biLSP —— 二进制表示列表
%                 Np —— 权位N与最高权位的距离，N 也是本级编码阈值的指数

intBin=dec2binvec(num);
% 首先用Matlab函数dec2binvec()获取整数部分的二进制表示intBin，低位在前，高位在后
intBin=intBin(end:-1:1);
% 根据个人习惯，将二进制表示转换为高位在前，低位在后
lenIB=length(intBin);
% 求出二进制表示的长度
decpart=num-floor(num);
% 求出小数部分
decBin=[];
% 小数部分的二进制表示初始化为空表

% 根据量化精度要求输出总的二进制表示列表
if (qLevel+1)>lenIB
% 如果量化精度高于整数部分的二进制码长，则输出为零值列表
    binlist=zeros(1,qLevel+1);
    qLpoint=1;
elseif qLevel>=0
% 如果量化精度在整数权位，则输出整数部分的二进制表示intBin
% 不需转换小数部分，同时输出量化精度与最高权位的距离Np
    binlist=intBin;
    binlist(lenIB-qLevel+1:end)=0;
    qLpoint=lenIB-qLevel;
elseif qLevel<0
% 如果量化精度在小数权位，则需转换小数部分
    N=-1;
    while N>=qLevel
    % 小数部分的转换只需进行到量化精度处
        res=decpart-2^N;
        if res==0
            decBin=[decBin,1];
            decBin(end+1:-qLevel)=0;
            % 如果小数部分的转换完成时仍未达到量化精度所在的权位，则补零
            break;
        elseif res>0
            decBin=[decBin,1];
            decpart=res;
            N=N-1;
        else
            decBin=[decBin,0];
            N=N-1;
        end
    end
    binlist=[intBin,decBin];
    qLpoint=lenIB-qLevel;
    % 输出整数部分和小数部分的二进制表示intBin,decBin，以及量化精度与最高权位的距离Np
end
end