clc;clear ; close all;
% exp(x)
n=13;
n2=436;
%计算n2维勒让德节点和权
[a,w]=GLe(n2);
%右侧计算时要用到勒让德的值
le=Le(n,a');
%等式右侧
b=zeros(n+1,1);
for i=1:n+1
    b(i)=w*(exp(a).*le(i,:)');
end
%求解
c=(1:2:2*n+1)'.*b/2;
x0=-0.99:0.01:0.99;
%网格点的勒让德值
y0=Le(n,x0);
%组装
yn0=diag(c)*y0;
yn=sum(yn0,1);
%绘图
figure(1)
plot(x0,yn,'LineWidth',2,'markersize',6);
% set(h1,);set(gca,'FontSize',20);
title('对e^x的最小二乘拟合')
set(gca,'FontSize',20);
figure(2)
plot(x0,abs(yn-exp(x0)),'LineWidth',2,'markersize',6);
title('对e^x的最小二乘拟合误差图像')
set(gca,'FontSize',20);

% exp(1)-exp(-1)

% %sin(4x)
n=28;
n2=51;
%计算n2维勒让德节点和权
[a,w]=GLe(n2);
%右侧计算时要用到勒让德的值
le=Le(n,a');
%等式右侧
b=zeros(n+1,1);
for i=1:n+1
    b(i)=w*(sin(4*a).*le(i,:)');
end
%求解
c=(1:2:2*n+1)'.*b/2;
x0=-0.99:0.01:0.99;
%网格点的范德蒙值
y0=Le(n,x0);
%组装
yn0=diag(c)*y0;
yn=sum(yn0,1);% %绘图
figure(3)
plot(x0,yn,'LineWidth',2,'markersize',6);
title('对sin(4x)的最小二乘拟合')
set(gca,'FontSize',20);
figure(4)
plot(x0,abs(yn-sin(4*x0)),'LineWidth',2,'markersize',6);
title('对sin(4x)的最小二乘拟合误差图像')
set(gca,'FontSize',20);