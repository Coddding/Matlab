clc,clear,close all;
N=10:10:200;
r=length(N);
maxerr=zeros(r,1);
err=zeros(r,1);
maxe=zeros(r,1);mine=zeros(r,1);
for j=1:r
tz=zeros(N(j)-1,1);
%解Ax=f
%先算A
L=-pi;R=pi;lamda=1;
h(j)=(R-L)/N(j);
x=L:h(j):R;
%构造等距节点
H1=x(2:end-1)-x(1:end-2);
H2=x(3:end)-x(2:end-1);
Ma=(H1+H2)/3;
Mb=H2(1:end-1)/6;
Sa=1./H1+1./H2;
Sb=-1./H2(1:end-1);
a=Sa+lamda*Ma; %主对角元
b=Sb+lamda*Mb; %次主对角元
%再算vf向量(vector_f)，这里取函数f=sinx
%并且使用梯形公式
f=@(x)sin(x);
temp=f(x(2:end-1));
vf=temp.*(H1+H2)/2;
vf=vf';
%接着，生成矩阵M与S
M=diag(Ma)+diag(Mb,1)+diag(Mb,-1);
S=diag(Sa)+diag(Sb,1)+diag(Sb,-1);
A=S+lamda.*M;
c=A\vf;
% c=Chase(a,b,b,vf);
tru=zeros(N(j)-1,1);
for i=1:N(j)-1
    tru(i)=f(x(i+1))/2;
end
err=abs(c-tru);
maxerr(j)=max(err);
K=M\S;
[V,D]=eig(K);
maxe(j)=max(abs(diag(D)));
mine(j)=min(abs(diag(D)));
end
figure(1)
fig1=plot(log10(N),log10(maxe));