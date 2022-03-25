%样本标准化函数
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%输入X为样本矩阵（行向量样本），index为标准化方法
%输出X1为标准化后的样本矩阵
function [X1]=XStd(X,index)
[n,m]=size(X);
switch index
    case '标准差标准化'
        BZCData=std(X);
        X1=X./BZCData(ones(n,1),:);
    case '总和标准化'
        SUMData=sum(X);
        X1=X./SUMData(ones(n,1),:);
    case '最大值标准化'
        MAXData=max(X);
        X1=X./MAXData(ones(n,1),:);
    case '模标准化'
        MOData=sqrt(sum(X.^2));
        X1=X./MOData(ones(n,1),:);
    case '中心标准化'
        MEANData=mean(X);
        X1=X-MEANData(ones(n,1),:);
    case '级差标准化'
        MEANData=mean(X);
        TempData1=X-MEANData(ones(n,1),:);
        Temp=minmax(X');
        TempData2=(Temp(:,2)-Temp(:,1))';
        X1=TempData1./TempData2(ones(n,1),:);
    case '级差正规化'
        MINData=min(X);
        TempData1=X-MINData(ones(n,1),:);
        Temp=minmax(X');
        TempData2=(Temp(:,2)-Temp(:,1))';
        X1=TempData1./TempData2(ones(n,1),:);
end
