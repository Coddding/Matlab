clc,clear,close all;
n=100;L=-1;R=1;
h=(R-L)/n;
t=L:h:R;
A=zeros(n,n);vf=zeros(n,1);
r=@(x) exp(x);q=@(x) x^2;
f=@(x) 1-(1+x^2)*exp(-x);
al=1;bl=0;ar=1;br=0;cl=exp(1);cr=1/exp(1);
temp1=zeros(n-2,1);%主对角
temp2=zeros(n-2,1);%下次主对角
temp3=zeros(n-2,1);%上次主对角
for i=1:n-2
    temp1(i)=r(t(i))*h^2+2;
    temp2(i)=-q(t(i))*h/2-1;
    temp3(i)=q(t(i))*h/2-1;
end
A(1,1)=2*al*h-3*bl;A(1,2)=4*bl;A(1,3)=-bl;
A(n,n-2)=br;A(n,n-1)=-4*br;A(n,n)=3*br+2*ar*h;
vf(1)=h*cl;vf(n)=h*cr;
for i=2:n-1
    A(i,i)=temp1(i-1);
    A(i,i-1)=temp2(i-1);
    A(i,i+1)=temp3(i-1);
    vf(i)=f(t(i))*h^2;
end
u=Chase(diag(A),diag(A,-1),diag(A,1),vf);
fig=plot(t(1:end-1),u)
set(fig,'LineWidth',2,'markersize',2);set(gca,'FontSize',30);
xlabel('x');ylabel('y');
legend(fig,'数值解函数')