%**********PCA************
clear all;
clc;
global scorey
global scorey2

load CCR101.mat;
load CCR101_norm.mat;
X1=CCR101;
%% 
X=X1(1:end,:);

[n,m]=size(X);
 Xb = XStd(X,'标准差标准化');
 Xm = Xb - ones(n,1)*mean(Xb);

for i=1:n
    a(i,1)=1;
end
[pc,score,latent,tsquare] = princomp(Xm);
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

display(['pc numbers：' int2str(kp)]);
display(['Tsquarelimit：' int2str(ts_ctr)]);
display(['SPElimit：' int2str(spe_ctr)]);

%% data for test

Xi=CCR101;
Xi2=CCR101_norm;
    [ni,mi]=size(Xi);
    [ni2,mi2]=size(Xi2);

    Xib = (Xi - ones(ni,1)*mean(X))./ (ones(ni,1)*std(X));
    Xib2 = (Xi2 - ones(ni2,1)*mean(X))./ (ones(ni2,1)*std(X));

    Xip= Xib*pc;
    Xip2= Xib2*pc;
    scorey=Xip(:,1:2);
    scorey2=Xip2(:,1:2);
    figure(1);
    neiwaidian(score(:,1:2),'exp'); %change the color in neiwaidian.m
    title('Confidence ellipse')
    hold on;
   
    XO = Xip(:,1:kp);


