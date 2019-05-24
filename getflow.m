function [flow1,flow2,bitflow]=getflow(bitflow)
% 函数 GETFLOW() 用于截取本级解码所需的位流信息
% 输入参数：bitflow —— 初始为编码器的输入位流，在解码过程中为上一级解码截取后剩余的编码位流
% 输出参数：flow —— 本级解码所需的位流（排序位流Sn、精细位流Rn）
%                 bitflow —— 本级解码截取后剩余的编码位流

flow1=[];
flow2=[];
i=1;
if length(find(bitflow==9))>1
    while bitflow(i)~=9
        flow1(i)=bitflow(i);
        i=i+1;
    end
    bitflow(1:i)=[];
    i=1;
    while bitflow(i)~=9
        flow2(i)=bitflow(i);
        i=i+1;
    end
    bitflow(1:i)=[];
elseif length(find(bitflow==9))==1
    while bitflow(i)~=9
        flow1(i)=bitflow(i);
        i=i+1;
    end
    bitflow(1:i)=[];
    flow2=bitflow(1:end);
    bitflow=[];
else
    flow1=bitflow(1:end);
    flow2=[];
    bitflow=[];
end

if isempty(bitflow)
    bitflow=[];
end
end