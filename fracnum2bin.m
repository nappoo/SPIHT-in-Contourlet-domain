function [binlist,qLpoint]=fracnum2bin(num,qLevel)
% ���� FRACNUM2BIN() ���ݾ�ϸɨ���Ӧ��Ȩλ N ���������ʮ��������ת��Ϊ����������
% ������������λС����ʮ��������Matlab�еĺ��� dec2bin()��dec2binvec()ֻ�ܽ�ʮ
% ����������������ת��Ϊ�����Ʊ�ʾ����С��������ת����
%
% ���������num ���� �Ǹ���ʮ������
%                 qLevel ���� ����ת�����ȣ�Ҳ�����Ǿ�ϸɨ���Ӧ��Ȩλ N
% ���������biLSP ���� �����Ʊ�ʾ�б�
%                 Np ���� ȨλN�����Ȩλ�ľ��룬N Ҳ�Ǳ���������ֵ��ָ��

intBin=dec2binvec(num);
% ������Matlab����dec2binvec()��ȡ�������ֵĶ����Ʊ�ʾintBin����λ��ǰ����λ�ں�
intBin=intBin(end:-1:1);
% ���ݸ���ϰ�ߣ��������Ʊ�ʾת��Ϊ��λ��ǰ����λ�ں�
lenIB=length(intBin);
% ��������Ʊ�ʾ�ĳ���
decpart=num-floor(num);
% ���С������
decBin=[];
% С�����ֵĶ����Ʊ�ʾ��ʼ��Ϊ�ձ�

% ������������Ҫ������ܵĶ����Ʊ�ʾ�б�
if (qLevel+1)>lenIB
% ����������ȸ����������ֵĶ������볤�������Ϊ��ֵ�б�
    binlist=zeros(1,qLevel+1);
    qLpoint=1;
elseif qLevel>=0
% �����������������Ȩλ��������������ֵĶ����Ʊ�ʾintBin
% ����ת��С�����֣�ͬʱ����������������Ȩλ�ľ���Np
    binlist=intBin;
    binlist(lenIB-qLevel+1:end)=0;
    qLpoint=lenIB-qLevel;
elseif qLevel<0
% �������������С��Ȩλ������ת��С������
    N=-1;
    while N>=qLevel
    % С�����ֵ�ת��ֻ����е��������ȴ�
        res=decpart-2^N;
        if res==0
            decBin=[decBin,1];
            decBin(end+1:-qLevel)=0;
            % ���С�����ֵ�ת�����ʱ��δ�ﵽ�����������ڵ�Ȩλ������
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
    % ����������ֺ�С�����ֵĶ����Ʊ�ʾintBin,decBin���Լ��������������Ȩλ�ľ���Np
end
end