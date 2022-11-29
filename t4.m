%% 时间-空间中心差分求解
clc;clear;close all;
%预设
J=40;h=0.05;
sita=0.0012;
x=[-1:h:1];
N=100;
U0=zeros(1,J+1);
U1=U0;UE=U0;
U0=1-x.^2;
A=diag(ones(J-2,1),1)-2*diag(ones(J-1,1))+diag(ones(J-2,1),-1);
lambda=sita/(h^2);
c=1;
I=diag(ones(J-1,1));
%% 迭代
for i=1:N
    t=i*sita;
    for j=2:J
        U1(j)=U0(j)+lambda*(U0(j+1)-2*U0(j)+U0(j-1))+exp(-t)*(1+x(j)^2)*sita;     
    end
%     U1(2:end-1)=(diag(ones(J-1,1))+c*lambda*A)*U0(2:end-1)'+exp(-t)*(I+x(2:end-1).^2);
    U0=U1;U1=U1.*0;
    UE=exp(-t)*(1-x.^2);   
end
subplot(3,1,1)
plot(x,U0)
subplot(3,1,2)
plot(x,UE)
subplot(3,1,3)
plot(x,abs(U0-UE))





