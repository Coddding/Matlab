clc;clear ; close all;
L=-1;R=1;N=100;h=(R-L)/N;
ze=L+h:h:R-h;n=length(ze);
%qx=x^2
%rx=e^x
%fx=1-(1+x^2)e^-x
b=zeros(1,n);a=b;c=b;
fx=@(x) 1-(1+x.^2).*exp(-x);
fz=@(x) exp(-x);%真解 

tic
f=fx(ze).*h^2;f1=fz(ze);
b=(2+exp(ze).*(h^2));
c=h/2.*ze.^2-1; 
a=-(h/2.*ze.^2+1);
a(1)=0;c(n)=0;
b(1)=(exp(ze(1))*h^2+2+(1/2*ze(1)^2*h+1)*4/(2*h-3));
c(1)=1/2*ze(1)^2*h-1-(1/2*ze(1)^2*h+1)/(2*h-3);
a(n)=(-1/(2*h+3)*(1/2*ze(n)^2*h-1)-(1/2*ze(n)^2*h+1));
b(n)=(1/2*ze(n)^2*h-1)*(4/(3+2*h))+(exp(ze(n))*h^2+2);
% x=tirzg(a,b,c,f)
A=diag(b)+diag(a(2:end),-1)+diag(c(1:end-1),1);

x=A\f';
toc


figure(1)
h1=plot(ze,x,'o'); hold on
set(h1,'LineWidth',2,'markersize',9);set(gca,'fontsize',20,'fontname','times');
h2=plot(ze,f1)
set(h2,'LineWidth',1,'markersize',9);set(gca,'fontsize',20,'fontname','times');
legend('szj','True')
title('ANS')
figure(2)
h3=plot(ze,abs(x-f1'))
set(h3,'LineWidth',2,'markersize',9);set(gca,'fontsize',20,'fontname','times');
legend('abs-error')
title('ERROR')
% 
% u=tirzg(a,b,c,f);
% plot(ze,u,'-o',ze,f1)