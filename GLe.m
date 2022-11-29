function [a,w]=GLe(n)
bet=zeros(1,n);
for i=1:n
    bet(i)=sqrt(i^2/(4*i^2-1));
end
An=diag(bet,1)+diag(bet,-1);
[Q,D]=eig(An);
%D是特征值，也就是零点
a=zeros(n+1,1);
for i=1:n+1
    a(i)=D(i,i);
end
w=Q(1,:).^2*2;
