% clc,clear,close all;
% N=30;n=N-1;
% alp=0;bet=0;x=-1:0.01:1;x=reshape(x,length(x),1); %这里reshape可以将x转换为列向量
function Basx=Japoly(N,alp,bet,x)
x=reshape(x,length(x),1);
n=N-1;
% p0=1;p1=(alp+bet+2)*x/2+(alp-bet)/2;
Basx=zeros(length(x),1);
if N==0
    Basx=1;
elseif N==1
    Basx=(alp+bet+2)*x/2+(alp-bet)/2;
else
%   Basx(:,1)=1;Basx(:,2)=(alp+bet+2)/2+(alp-bet)/2;
    p0=1;p1=(alp+bet+2)*x/2+(alp-bet)/2;
    for i=1:n
        an=(2*i+alp+bet+1)*(2*i+alp+bet+2)/(2*(i+1)*(i+alp+bet+1));
        bn=(bet^2-alp^2)*(2*i+alp+bet+1)/(2*(i+1)*(i+alp+bet+1)*(2*i+alp+bet));
        cn=(i+alp)*(i+bet)*(2*i+alp+bet+2)/((i+1)*(i+alp+bet+1)*(2*i+alp+bet));
        Basx=(an*x-bn).*p1-cn*p0;
        p0=p1;p1=Basx;
    end
end