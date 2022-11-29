clc,clear,close all;
N=[10,50,100,200]; %N为取区间个数（自由度）
ch=length(N);
for j=1:ch
%解Ax=f
%先算A
L=-1;R=1;
h(j)=(R-L)/N(j);
t=L:h(j):R;
A=zeros(N(j),N(j));vf=zeros(N(j),1);
r=@(x) exp(x);q=@(x) x^2;
f=@(x) 1-(1+x^2)*exp(-x);
al=1;bl=1;ar=1;br=1;cl=0;cr=0;
temp1=zeros(N(j)-2,1);%主对角
temp2=zeros(N(j)-2,1);%下次主对角
temp3=zeros(N(j)-2,1);%上次主对角
for i=1:N(j)-2
    temp1(i)=r(t(i))*h(j)^2+2;
    temp2(i)=-q(t(i))*h(j)/2-1;
    temp3(i)=q(t(i))*h(j)/2-1;
end
A(1,1)=2*al*h(j)-3*bl;A(1,2)=4*bl;A(1,3)=-bl;
A(N(j),N(j)-2)=br;A(N(j),N(j)-1)=-4*br;A(N(j),N(j))=3*br+2*ar*h(j);
vf(1)=h(j)*cl;vf(N(j))=h(j)*cr;
for i=2:N(j)-1
    A(i,i)=temp1(i-1);
    A(i,i-1)=temp2(i-1);
    A(i,i+1)=temp3(i-1);
    vf(i)=f(t(i))*h(j)^2;
end
c=A\vf;
tru=zeros(N(j),1);
ftru=@(x) exp(-x);
for i=1:N(j)
    tru(i)=ftru(t(i+1));
end
err=abs(c-tru);
maxerr(j)=max(err);
end
N=log10(N);
maxerr=log10(maxerr);
figure
fig1=plot(N,maxerr,'or',N,maxerr,'-b');
set(fig1,'markersize',12);
set(fig1,'LineWidth',2,'markersize',10); 
set(gca,'FontSize',30);
xlabel('log_{10}(N)'); ylabel('log_{10}(Error)');
legend('Error','误差收敛曲线')