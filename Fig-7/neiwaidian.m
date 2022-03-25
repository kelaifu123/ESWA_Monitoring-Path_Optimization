function neiwaidian(xdat,alpha,distribution)
%UNTITLED �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
global scorey aa bb scorey2
%   ���������������䡢��Բ�������������
%   ConfidenceRegion(xdat,alpha,distribution)
%   xdat�������۲�ֵ����,p*N �� N*p�ľ���p = 1,2 �� 3
%   alpha��������ˮƽ��������ȡֵ����[0,1]��Ĭ��ֵΪ0.05
%   distribution���ַ�����'norm'��'experience'��������ָ�������������õ��ķֲ����ͣ�
%   distribution��ȡֵֻ��Ϊ�ַ���'norm'��'experience'���ֱ��Ӧ��̬�ֲ��;���ֲ�
%   CopyRight��xiezhh��л�л���
%   date��2011.4.14
%
%   example1��x = normrnd(10,4,100,1);
%             ConfidenceRegion(x)
%             ConfidenceRegion(x,'exp')
%   example2��x = mvnrnd([1;2],[1 4;4 25],100);
%             ConfidenceRegion(x)
%             ConfidenceRegion(x,'exp')
%   example3��x = mvnrnd([1;2;3],[3 0 0;0 5 -1;0 -1 1],100);
%             ConfidenceRegion(x)
%             ConfidenceRegion(x,'exp')
% �趨����Ĭ��ֵ
if nargin == 1
    distribution = 'norm';
    alpha = 0.05;
elseif nargin == 2
    if ischar(alpha)
        distribution = alpha;
        alpha = 0.05;
    else
        distribution = 'norm';
    end
end
% �жϲ���ȡֵ�Ƿ����
if ~isscalar(alpha) || alpha>=1 || alpha<=0
    error('alpha��ȡֵ����0��1֮��')
end
if ~strncmpi(distribution,'norm',3) && ~strncmpi(distribution,'experience',3)
    error('�ֲ�����ֻ������̬�ֲ���''norm''������ֲ���''experience''��')
end
% �������ά���Ƿ���ȷ
[m,n] = size(xdat);
[m1,n1]=size(scorey);
n1=max(m1,n1);
p = min(m,n);  % ά��
if ~ismember(p,[1,2,3])
    error('Ӧ����һά����ά����ά��������,������������Ӧ����3')
end
% �������۲�ֵ����ת�ã�ʹ���ж�Ӧ�۲⣬�ж�Ӧ����
if m < n
    xdat = xdat';
end
xm = mean(xdat); % ��ֵ
n = max(m,n);  % �۲�����
% �����������������
switch p
    case 1    % һά���Σ��������䣩
        xstd = std(xdat); % ��׼��
        if strncmpi(distribution,'norm',3)
            lo = xm - xstd*norminv(1-alpha/2,0,1); % ��̬�ֲ�������������
            up = xm + xstd*norminv(1-alpha/2,0,1); % ��̬�ֲ�������������
            %lo = xm - xstd*tinv(1-alpha/2,n-1); % ��̬�ֲ�������������
            %up = xm + xstd*tinv(1-alpha/2,n-1); % ��̬�ֲ�������������
            TitleText = '�������䣨������̬�ֲ���';
        else
            lo = prctile(xdat,100*alpha/2); % ����ֲ�������������
            up = prctile(xdat,100*(1-alpha/2)); % ����ֲ�������������
            TitleText = '�������䣨���ھ���ֲ���';
        end
        % �������������ⲻͬ���ò�ͬ��ɫ�ͷ��Ż�ͼ
        xin = xdat(xdat>=lo & xdat<=up);
        xid = find(xdat>=lo & xdat<=up);
        plot(xid,xin,'.')
        hold on
        xout = xdat(xdat<lo | xdat>up);
        xid = find(xdat<lo | xdat>up);
        plot(xid,xout,'r+')
        h = refline([0,lo]);
        set(h,'color','k','linewidth',2)
        h = refline([0,up]);
        set(h,'color','k','linewidth',2)
        xr = xlim;
        yr = ylim;
        text(xr(1)+range(xr)/20,lo-range(yr)/20,'��������',...
            'color','g','FontSize',15,'FontWeight','bold')
        text(xr(1)+range(xr)/20,up+range(yr)/20,'��������',...
            'color','g','FontSize',15,'FontWeight','bold')
        xlabel('�۲����')
        ylabel('�۲�ֵ')
        title(TitleText)
        hold off
    case 2    % ��ά���Σ�������Բ��
        x = xdat(:,1);
        y = xdat(:,2);    
        plot(xdat);
        s = inv(cov(xdat));  % Э������� 
        xd = xdat-repmat(xm,[n,1]);%��ֵ���Ļ�
        rd = sum(xd*s.*xd,2); 
        if strncmpi(distribution,'norm',3)
            r = chi2inv(1-alpha,p);
            %r = p*(n-1)*finv(1-alpha,p,n-p)/(n-p)/n;
            TitleText = '������Բ��������̬�ֲ���';
        else
            r = prctile(rd,100*(1-alpha));
%             TitleText = '������Բ�����ھ���ֲ���';
%             TitleText = '���͹�������״̬���';
        end
%         plot(x(rd<=r),y(rd<=r),'.','MarkerSize',16)  % ������ɢ��
%         hold on 
%         plot(x(rd>r),y(rd>r),'r+','MarkerSize',10)  % ������ɢ��
%         hold on
%         plot(xm(1),xm(2),'k+');  % ��Բ����
        h = ellipsefig(xm,s,r,1);  % ����������Բ
        [m1,n1]=size(scorey);
        for i=1:m1
            z=(scorey(i,1)-xm(1))^2/aa^2+(scorey(i,2)-xm(2))^2/bb^2;
            if z<1
                
                plot(scorey(i,1),-scorey(i,2),'.','Color',[19 159 255]/255,'MarkerSize',10)
                hold on
            else
                plot(scorey(i,1),-scorey(i,2),'.','Color',[19 159 255]/255,'MarkerSize',10)
                grid on;
                hold on
                
            end
        end
        plot(scorey2(:,1),-scorey2(:,2),'.','Color',[237 177 32]/255,'MarkerSize',10)
        xlabel('PC-1')
        ylabel('PC-2')
%         title(TitleText)
        hold off;
    case 3    % ��ά���Σ���������
        x = xdat(:,1);
        y = xdat(:,2);
        z = xdat(:,3);
        s = inv(cov(xdat));  % Э�������
        xd = xdat-repmat(xm,[n,1]);
        rd = sum(xd*s.*xd,2);
        if strncmpi(distribution,'norm',3)
            r = chi2inv(1-alpha,p);
            %r = p*(n-1)*finv(1-alpha,p,n-p)/(n-p)/n;
            TitleText = '�������򣨻�����̬�ֲ���';
        else
            r = prctile(rd,100*(1-alpha));
            TitleText = '�������򣨻��ھ���ֲ���';
        end
        plot3(x(rd<=r),y(rd<=r),z(rd<=r),'.','Color',[0 114 189],'MarkerSize',16)  % ������ɢ��
        hold on
        plot3(x(rd>r),y(rd>r),z(rd>r),'r+','MarkerSize',10)  % ������ɢ��
        plot3(xm(1),xm(2),xm(3),'k+');  % ��������
        h = ellipsefig(xm,s,r,2);  % ������������
        xlabel('X')
        ylabel('Y')
        zlabel('Z')
        title(TitleText)
        hidden off;
        hold off;
end
%--------------------------------------------------
%   �Ӻ�����������������������Բ������
%--------------------------------------------------
function  h = ellipsefig(xc,P,r,tag)
global aa bb
% ��һ����Բ������(x-xc)'*P*(x-xc) = r
[V, D] = eig(P); 
if tag == 1
    aa = sqrt(r/D(1));
    bb = sqrt(r/D(4));
    t = linspace(0, 2*pi, 60);
    xy = V*[aa*cos(t);bb*sin(t)];  % ������ת
    h = plot(xy(1,:)+xc(1),xy(2,:)+xc(2), 'k', 'linewidth', 2);
    hold on
else
    aa = sqrt(r/D(1,1));
    bb = sqrt(r/D(2,2));
    cc = sqrt(r/D(3,3));
    [u,v] = meshgrid(linspace(-pi,pi,30),linspace(0,2*pi,30));
    x = aa*cos(u).*cos(v);
    y = bb*cos(u).*sin(v);
    z = cc*sin(u);
    xyz = V*[x(:)';y(:)';z(:)'];  % ������ת
    x = reshape(xyz(1,:),size(x))+xc(1);
    y = reshape(xyz(2,:),size(y))+xc(2);
    z = reshape(xyz(3,:),size(z))+xc(3);
    h = mesh(x,y,z);  % ��������������ͼ

end

