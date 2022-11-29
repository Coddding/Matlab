clc,clear, close all

A=[31 -13 0 0 0 -10 0 0 0;
   -13 35 -9 0 -11 0 0 0 0;
   0 -9 31 -10 0 0 0 0 0;
   0 0 -10 79 -30 0 0 0 -9;
   0 0 0 -30 57 -7 0 -5 0;
   0 0 0 0 -7 47 -30 0 0;
   0 0 0 0 0 -30 41 0 0 ;
   0 0 0 0 -5 0 0 27 -2;
   0 0 0 -9 0 0 0 -2 29];
b=[-15; 27; -23; 0; -20; 12; -7; 7; 10];
n=length(b);
x=zeros(n,1);
c=zeros(1,n);
d=0;

for i=1:n-1
    max=abs(A(i,i));
    m=i;
    for j=i+1:n
        if max<abs(A(j,i))
            max=abs(A(j,j));
            m=j;
        end
    end

    if(m~=i)
        for k=i:n
            c(k)=A(i,k);
            A(i,k)=A(m,k);
            A(m,k)=c(k);
        end
        d=b(i);
        b(i)=b(m);
        b(m)=d;
    end

    for k=i+1:n
        for j=i+1:n
            A(k,j)=A(k,j)-A(i,j)*A(k,i)/A(i,i);
        end
        b(k)=b(k)-b(i)* A(k,i)/A(i,i);
        A(k,i)=0;
    end
end

x(n)=b(n)/A(n,n);

for i=n-1:-1:1
    sum=0;
    for j=i+1:n
        sum=sum+A(i,j)*x(j);
    end
    x(i)=(b(i)-sum)/A(i,i);
end

x

