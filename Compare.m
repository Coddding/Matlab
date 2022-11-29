clc,clear,close all;
N=[6:2:20]; %N为取区间个数（自由度）
r=length(N);
maxerr1=zeros(r,1);maxerr2=zeros(r,1);
err1=zeros(r,1);
for j=1:r
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
err1=abs(c-tru);
maxerr1(j)=max(err1);
%%

s=zeros(N(j)-1,1);
m=s;m1=zeros(N(j)-1,1);
for i =1:N(j)-1
    n=i+1;
    s(i)=((n-1)/2)^2*2/(2*n-1);
    m(i)=((n-1)/2/(2*n-1))^2*(2/(2*n+1)+2/(2*n-3));
    m1(i)=-(n-1)/(2*(2*n-1))*((n+1)/(2*(2*n+3)))*2/(2*n+1);
end
S1=diag(s);
M1=diag(m)+diag(m1(1:end-2),2)+diag(m1(1:end-2),-2);
%% source vector
NI=N(j)+3;
[xI,wI]=Gauss_Legendre(NI);
fI=(pi^2+1)*sin(pi*xI);
BasI=zeros(NI,N(j)-1);
for i=1:N(j)-1
    BasI(:,i)=(xI+1).*(xI-1)/4.*Japoly(i-1,1,1,xI);
end
vf1=BasI'*(fI.*wI);
vc=(S1+M1)\vf1;
xx=-1:0.01:1;xx=reshape(xx,length(xx),1);
Basx=zeros(length(xx),N(j)-1);
for i=1:N(j)-1
    Basx(:,i)=(xx+1).*(xx-1)/4.*Japoly(i-1,1,1,xx);
end
u=sin(pi*xx);
% tru=zeros(N(j)+1,1);
% for i=1:N(j)+1
%     tru(i)=f(xx(i));
% end
un=Basx*vc;
err2=abs(un-u);
maxerr2(j)=max(err2);

end
N=log10(N);
maxerr1=log10(maxerr1);maxerr2=log10(maxerr2);
figure
fig1=plot(N,maxerr1,'o-',N,maxerr2,'*-');
set(fig1,'markersize',12);
set(fig1,'LineWidth',2,'markersize',10); 
set(gca,'FontSize',30);
xlabel('log_{10}(N)'); ylabel('log_{10}(Error)');
legend('有限元方法','谱方法')


