clear;clc;close all;
%% 引入参数
L=-1;R=1;
N=100;
h=(R-L)/N;
x0=L:h:R;
q=@(x) x.^2;
r=@(x) exp(x);
f=@(x) 1-(1+x.^2).*exp(-x);
tu=@(x) exp(-x);
x=tu(x0);
%% 构建五对角矩阵
a=[2*h-3,r(x0(2:end-1))*h^2+2,3+2*h];
b=[-q(x0(2:end-1))/2*h-1,-4];
c=[4,q(x0(2:end-1))/2*h-1];
d=[zeros(1,N+1-3),1];
e=[-1,zeros(1,N+1-3)];
vf=[0,h^2*f(x0(2:end-1)),0];
%% 求解
A=diag(a)+diag(b,-1)+diag(c,1)+diag(d,-2)+diag(e,2);
% u=A\vf';
u=chase5(a,b,c,d,e,vf);
figure(1)
h1=plot(x0,u);
ylabel('u(x)'); xlabel('x');
set(h1,'LineWidth',2,'markersize',6);set(gca,'FontSize',30);
legend('解函数的图像');
figure(2)
h2=plot(log10(N),log10(abs(x-u)));
ylabel('Error(x)'); xlabel('x');
set(h2,'LineWidth',2,'markersize',6);set(gca,'FontSize',30);
legend('误差图像');