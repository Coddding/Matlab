function [varargout]=Gauss_Chebshev(n)
alpj=zeros(n+1,1);betj=zeros(n,1);
a0=1;
for i=1:n
    ai=2;
    c-1;
    betj(i)=sqrt(ci/(a0*ai));
    a0=ai;
end
An=diag(alpj)+diag(betj,1)+diag(betj,-1);
[Q,D]=eig(An);
varargout{1}=diag(D);
if nargout==1
    return;
end
varargout{2}=2*(Q(1,:).^2)';
end