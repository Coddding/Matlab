clc,clear,close all;
%vind=2:N; 不用for循环的矩阵构造
%s1=(vind-1).^2./(2*(2*vind-1));
N=15;
s=zeros(N-1,1);
m=s;m1=zeros(N-1,1);
for i =1:N-1
    n=i+1;
    s(i)=((n-1)/2)^2*2/(2*n-1);
    m(i)=((n-1)/2/(2*n-1))^2*(2/(2*n+1)+2/(2*n-3));
    m1(i)=-(n-1)/(2*(2*n-1))*((n+1)/(2*(2*n+3)))*2/(2*n+1);
end
S=diag(s);
M=diag(m)+diag(m1(1:end-2),2)+diag(m1(1:end-2),-2);
%% source vector
NI=N+3;
[xI,wI]=Gauss_Legendre(NI);
fI=(pi^2+1)*sin(pi*xI);
BasI=zeros(NI,N-1);
for i=1:N-1
    BasI(:,i)=(xI+1).*(xI-1)/4.*Japoly(i-1,1,1,xI);
end
vf=BasI'*(fI.*wI);
vc=(S+M)\vf;
xx=-1:0.01:1;xx=reshape(xx,length(xx),1);
Basx=zeros(length(xx),N-1);
for i=1:N-1
    Basx(:,i)=(xx+1).*(xx-1)/4.*Japoly(i-1,1,1,xx);
end
un=Basx*vc;
u=sin(pi*xx);
K=M\S;
P=inv(K);
plot(xx,un,xx,u)