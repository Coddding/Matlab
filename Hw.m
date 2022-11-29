clc,clear,close all;
f=@(x) exp(x);
% g=@(x) sin(4*x) %真实值
syms x f_est tempt;
n=3; %最高次数你来定
%区间为(-1,1)，下面取等距节点
k=10; %节点个数
x_equal=zeros(k+1,1);
x_equal(1)=-1;h=2/(k-1);
for i=2:k+1
    x_equal(i)=x_equal(i-1)+h;
end

A=zeros(n+1,n+1);fphi=zeros(n+1,1);
pol=sym(zeros(n+1,1));
pol(1)=1;pol(2)=x;
for i =3:n+1
    pol(i)=(2*(i-1)+1)*x*pol(i-1)/((i-1)+1)-(i-1)*pol(i-2)/((i-1)+1);
end
%求Ax=f，这里构造A矩阵
for i =1:n+1
    for j=1:n+1
        if i ~= j
            A(i,j)=0;
        else
            A(i,j)=2/(2*i-1);
        end
    end
end

%求f
temp=0;
for i=1:n+1
    for j=1:k+1
        temp=temp+subs(pol(i),x,x_equal(j))*f(x_equal(j));
    end
    fphi(i)=temp;
    temp=0;
end

%求最佳逼近系数c_n
c=zeros(n+1,1);
c=A\fphi;
tempt=0;
for i=1:n+1
    f_est=tempt+c(i).*pol(i);
    tempt=f_est;
end

t=-1:0.01:1;y=subs(f_est,x,t);
plot(t,y)
