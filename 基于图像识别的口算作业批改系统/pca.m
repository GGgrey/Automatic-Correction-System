function [newX,T,meanValue] = pca(X,CRate)
meanValue=ones(size(X,1),1)*mean(X);
X=X-meanValue;
C=X'*X/(size(X,1)-1);
[V,D]=eig(C);
[dummy,order]=sort(diag(-D));
V=V(:,order);
d=diag(D);
newd=d(order);
sumd=sum(newd);
% for j=1:length(newd)
%     i=sum(newd(1:j,1))/sumd;
%     if i>CRate
%         cols=j;
%         break;
%     end
% end
T=V(:,1:20);
newX=X*T;
end