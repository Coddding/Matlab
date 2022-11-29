clc,clear,close all;
%vind=2:N; 不用for循环的矩阵构造
%s1=(vind-1).^2./(2*(2*vind-1));
N=[6:2:20];
ch=length(N);
maxerr=zeros(ch,1);
for j=1:ch
    s=zeros(N(j)-1,1);
m=s;m1=zeros(N(j)-1,1);
for i =1:N(j)-1
    n=i+1;
    s(i)=((n-1)/2)^2*2/(2*n-1);
    m(i)=((n-1)/2/(2*n-1))^2*(2/(2*n+1)+2/(2*n-3));
    m1(i)=-(n-1)/(2*(2*n-1))*((n+1)/(2*(2*n+3)))*2/(2*n+1);
end
S=diag(s);
M=diag(m)+diag(m1(1:end-2),2)+diag(m1(1:end-2),-2);
%% source vector
NI=N(j)+3;
[xI,wI]=Gauss_Legendre(NI);
fI=(pi^2+1)*sin(pi*xI);
BasI=zeros(NI,N(j)-1);
for i=1:N(j)-1
    BasI(:,i)=(xI+1).*(xI-1)/4.*Japoly(i-1,1,1,xI);
end
vf=BasI'*(fI.*wI);
vc=(S+M)\vf;
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
err=abs(un-u);
maxerr(j)=max(err);
end
N=log10(N);maxerr=log10(maxerr);
% u=sin(pi*xx);
% plot(xx,err)
plot(N,maxerr,'o-')
