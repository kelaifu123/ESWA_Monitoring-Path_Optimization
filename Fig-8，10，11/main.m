%**********PCA算法************
clear;clc;
global scorey
global scorey2

%% 测试使用
load CCR18.mat;%fig 8
load ccr18_low.mat; %fig 10
%load ccr18_high.mat; %fig 11

X1=CCR18;
%% 
    X=X1(1:end,:);

[n,m]=size(X);
 Xb = XStd(X,'标准差标准化');
 Xm = Xb - ones(n,1)*mean(Xb);

for i=1:n
    a(i,1)=1;
end
[pc,score,latent,tsquare] = princomp(Xm); %pc：负载矩阵，score：得分向量，latent：特征值矩阵

percent =0.85;
latent_sum=0;
block=0;
for i=1:m
    latent_sum=latent_sum+latent(i);
    if latent_sum/sum(latent) >= percent & block==0;
        kp=i;
        block=1;
    end
end

alpha = 0.95;
[ts_ctr,spe_ctr] = PCAThrd(Xm,latent,alpha,kp);

display(['主元个数：' int2str(kp)]);
display(['T方统计量控制限：' int2str(ts_ctr)]);
display(['SPE统计量控制限：' int2str(spe_ctr)]);


Xi=CCR18;
 Xi2=ccr18_low;

    [ni,mi]=size(Xi);
    [ni2,mi2]=size(Xi2);

    Xib = (Xi - ones(ni,1)*mean(X))./ (ones(ni,1)*std(X));
    Xib2 = (Xi2 - ones(ni2,1)*mean(X))./ (ones(ni2,1)*std(X));

    Xip= Xib*pc;
    Xip2= Xib2*pc;
    scorey=Xip(:,1:2);
    scorey2=Xip2(:,1:2);
    figure(1);
neiwaidian(score(:,1:2),'exp');
title('Confidence ellipse')
hold on;

