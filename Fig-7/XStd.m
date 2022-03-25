%������׼������
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%����XΪ����������������������indexΪ��׼������
%���X1Ϊ��׼�������������
function [X1]=XStd(X,index)
[n,m]=size(X);
switch index
    case '��׼���׼��'
        BZCData=std(X);
        X1=X./BZCData(ones(n,1),:);
    case '�ܺͱ�׼��'
        SUMData=sum(X);
        X1=X./SUMData(ones(n,1),:);
    case '���ֵ��׼��'
        MAXData=max(X);
        X1=X./MAXData(ones(n,1),:);
    case 'ģ��׼��'
        MOData=sqrt(sum(X.^2));
        X1=X./MOData(ones(n,1),:);
    case '���ı�׼��'
        MEANData=mean(X);
        X1=X-MEANData(ones(n,1),:);
    case '�����׼��'
        MEANData=mean(X);
        TempData1=X-MEANData(ones(n,1),:);
        Temp=minmax(X');
        TempData2=(Temp(:,2)-Temp(:,1))';
        X1=TempData1./TempData2(ones(n,1),:);
    case '�������滯'
        MINData=min(X);
        TempData1=X-MINData(ones(n,1),:);
        Temp=minmax(X');
        TempData2=(Temp(:,2)-Temp(:,1))';
        X1=TempData1./TempData2(ones(n,1),:);
end
