%PCA��T�������޺�SPE���������㺯��
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%����XΪ��׼���������������������������latentΪ��Ԫ�����ģ�alphaΪ����ˮƽ��kΪ��Ԫ����
%���ts_ctrlΪT�������ޣ�spe_ctrlΪSPE������
function [ts_ctrl,spe_ctrl]=PCAThrd(X,latent,alpha,kp)
[n,m]=size(X);

%����F�ֲ���T��������
ts_ctrl=kp*(n-1)/(n-kp)*finv(alpha,kp,n);

% ������̬�ֲ���SPE������
theta=zeros(3,1);
for i=1:3
    for j=kp+1:m
        theta(i)=theta(i)+latent(j)^(i);
    end
end
h0=1-2*theta(1)*theta(3)/(3*theta(2)^2);
spe_ctrl=theta(1)*(norminv(alpha)*(2*theta(2)*h0^2)^0.5/theta(1)+1+theta(2)*h0*(h0-1)/theta(1)^2)^(1/h0);

        