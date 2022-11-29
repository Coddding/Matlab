clc,clear,close all;
tic
L=-1;R=1;T=1;
N=50;K=5000; %N空间差分，T时间差分
hx=(R-L)/N;ht=T/K;
u0=@(x) 1-x.^2;
f=@(x,t) exp(-t).*(1+x.^2);
f_true=@(x,t) exp(-t).*(1-x.^2);

A=diag(ones(N-2,1),1)-2*diag(ones(N-1,1))+diag(ones(N-2,1),-1);
x=hx*(1:N-1)'-1; 
u=u0(x);
%% index=1时用欧拉格式；index=2用向后欧拉格式
index=1;
FE=(eye(N-1)+ht/hx.^2*A); %欧拉方法矩阵
BE=(eye(N-1)-ht/hx.^2*A); %向后欧拉方法矩阵
for i =1:K
    if index==1
        u=FE*u+ht*f(x,(i-1)*ht);
    elseif index==2
        u=BE\(u+ht*f(x,i*ht));
    end
end

%取真解
kongxi=0.001;Va=40;
U0=zeros(1,Va+1);
U1=U0;UE=U0;
U0=1-x.^2;
for i=1:N
    t=T;%取t=1时刻的空间
%     t=i*kongxi;
%     for j=2:Va
%         U1(j)=U0(j)+kongxi*(U0(j+1)-2*U0(j)+U0(j-1))/hx^2+exp(-t)*(1+x(j)^2)*kongxi;
%     end
%     U0=U1;U1=0;
    UE=exp(-t)*(1-x.^2); 
end
% [V,M]=eig()
figure(1)
fig1=plot(x,u);
set(fig1,'markersize',12);
xlabel('x'); ylabel('u');
set(fig1,'LineWidth',2,'markersize',2); set(gca,'FontSize',40);
legend(fig1,'数值解')

figure(2)
% fig2=plot(x,log10(abs(u-f_true(x,t))));
fig2=plot(x,abs(u-f_true(x,t)));
set(fig2,'markersize',12);
xlabel('x'); ylabel('Error');
set(fig2,'LineWidth',2,'markersize',2); set(gca,'FontSize',40);
legend(fig2,'误差')
% ut=zeros(N-1,1);ut(1)=u0;
% for i=2:N-1
%     ut(i)=ut(i-1)+ht*f(ut(i-1),t);
% end
toc
po=toc