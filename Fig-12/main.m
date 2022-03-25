clc
clear all
X=xlsread('1.xlsx');
load('xy.mat');
rowmin=-6;
colmin=-10;
rowmax=6;
colmax=6;
rowplus=0.1;
colplus=0.1;
aa=(rowmax-rowmin)/rowplus;
bb=(colmax-colmin)/colplus;
TT=zeros(aa,bb);
RR=TT;
[n,m]=size(X);
for i=1:n
    a(i)=X(i,1);
    b(i)=X(i,2);       
    col1(i)=floor((a(i)-colmin)/colplus)+1;
    row1(i)=aa-floor((b(i)-rowmin)/rowplus);
    TT(row1(i),col1(i))=1;
end

newdata=X(1:384,3:4);
[n,m]=size(newdata);
for i=1:n
    a(i)=newdata(i,1);
    b(i)=newdata(i,2);       
    col1(i)=floor((a(i)-colmin)/colplus)+1;
    row1(i)=aa-floor((b(i)-rowmin)/rowplus);
    TT(row1(i),col1(i))=2;
end

newdata1=xy;
[n,m]=size(newdata1);
for i=1:n
    a(i)=newdata1(i,1);
    b(i)=newdata1(i,2); 
    col1(i)=floor((a(i)-colmin)/colplus)+1;
    row1(i)=aa-floor((b(i)-rowmin)/rowplus);
    TT(row1(i),col1(i))=3;
end
figure;hold on
for i=1:1:size(TT,1)
	for j=1:1:size(TT,2)
		if(TT(i,j) == 1)
			xval=floor(j);
			yval=floor(size(TT,1)-i+1);
			plot(j+.5,size(TT,1)-i+1+.5,'.','Color',[237 177 32]/255);
%         elseif(TT(i,j) == 0)
% 			xval=floor(j);
% 			yval=floor(size(TT,1)-i+1);
% 			plot(j+.5,size(TT,1)-i+1+.5,'bx');
		elseif(TT(i,j) == 3)
			xval=floor(j);
			yval=floor(size(TT,1)-i+1);
			plot(j+.5,size(TT,1)-i+1+.5,'.','Color',[19 159 255]/255);
%		else
%			plot(j+.5,size(TT,1)-i+1+.5,'y.');
		end
	end
end


