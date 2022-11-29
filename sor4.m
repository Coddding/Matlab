clear;clc;close all
a=[31 -13 0 0 0 -10 0 0 0;-13 35 -9 0 -11 0 0 0 0;0 -9 31 -10 0 0 0 0 0;0 0 -10 79 -30 0 0 0 -9;0 0 0 -30 57 -7 0 -5 0;0 0 0 0 -7 47 -30 0 0;0 0 0 0 0 -30 41 0 0;0 0 0 0 -5 0 0 27 -2;0 0 0 -9 0 0 0 -2 29];
b=[-15;27;-23;0;-20;12;-7;7;10];
n=length(b)
e=0.000005;
cont=zeros(99,1);
for s=1:99
    k=0;
    w=s/50;
    x=zeros(n,1);
    while(1)
        x_temp=x;
        for i=1:n
            sum=0;
            for j=1:n
                if j==i
                    continue;
                end
                sum=sum+a(i,j)*x(j,1);
            end
            x(i,1)=(1-w)*x(i,1)+w*(b(i,1)-sum)/a(i,i);
        end
        k=k+1;
        if k>=10000
            cont(s,1)=inf;
            break;
        end
        m=x-x_temp;
        max=abs(m(1,1));
        for r=2:n
            if abs(m(r,1))>abs(max)
                max=m(r,1);
            end
        end
        if abs(max)<=e
            cont(s,1)=k;
            break;
        end
    end
end
w=1:99;
plot(w,cont);
