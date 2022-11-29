clc;clear ;close all;
L=-pi;R=pi;N=10:5:1000;n=length(N);
f=@(x) sin(x);
F=@(x) 1/2.*sin(x);
linE=zeros(1,n);
for i=1:n
   linE(i)=yxy(L,R,N(i),f,F);
end
h=(R-L)./N;
figure(1)
h1=plot(log10(h),log10(linE),'-o')
set(h1,'LineWidth',1,'markersize',9);set(gca,'fontsize',20,'fontname','times');
title('YXY-error');legend('log_{10}Error')
xlabel('lg h');ylabel('lg error')
% figure(2)
% h3=plot(ze(2:end-1),u)
% set(h3,'LineWidth',1,'markersize',9);set(gca,'fontsize',20,'fontname','times');
% legend('szj','True'); title('Max-error')