function [flow1,flow2,bitflow]=getflow(bitflow)
% ���� GETFLOW() ���ڽ�ȡ�������������λ����Ϣ
% ���������bitflow ���� ��ʼΪ������������λ�����ڽ��������Ϊ��һ�������ȡ��ʣ��ı���λ��
% ���������flow ���� �������������λ��������λ��Sn����ϸλ��Rn��
%                 bitflow ���� ���������ȡ��ʣ��ı���λ��

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