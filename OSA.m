clc,clear,close all;
f=@(x) exp(x);
% g=@(x) sin(4*x) %真实值
syms x f_est tempt;
n=6; %最高次数你来定
%区间为(-1,1)，下面取等距节点
A=zeros(n+1,n+1);fphi=zeros(n+1,1);
pol=sym(zeros(n+1,1));
pol(1)=1;pol(2)=x;
for i =2:n
    pol(i+1)=(2*(i-1)+1)*x*pol(i-1)/((i-1)+1)-(i-1)*pol(i-2)/((i-1)+1);
end

for i =1:n+1
    for j=1:n+1
        A(i,j)=int(pol(i)*pol(j),x,-1,1)
%         if i ~= j
%             A(i,j)=0;
%         else
%             A(i,j)=2/(2*i-1);
%         end
    end
end

for i =1:n+1
    fphi(i)=int(f*pol(i),x,-1,1);
end

c=zeros(n+1,1);
c=A\fphi;

tempt=0;
for i=1:n+1
    f_est=tempt+c(i).*pol(i);
    tempt=f_est;
end

t=-1:0.001:1;y=subs(f_est,x,t);
fig1=plot(t,y);xlabel('x'); ylabel('q(x)');
set(fig1,'LineWidth',2,'markersize',2); set(gca,'FontSize',20);
legend(fig1,'n=6时的拟合函数')


% t=-1:0.001:1;y=subs(abs(f_est-f),x,t);
% fig1=plot(t,y);xlabel('x'); ylabel('Error');
% set(fig1,'LineWidth',2,'markersize',2); set(gca,'FontSize',20);
% legend(fig1,'n=16时拟合函数与原函数误差')
