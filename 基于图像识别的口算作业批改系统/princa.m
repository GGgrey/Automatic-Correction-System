function [V,S,E]=princa(X)
[m,n]=size(X);
mv=mean(X);
st=std(X);
X=(X-repmat(mv,m,1))./repmat(st,m,1);
R=corrcoef(X);
[V,D]=eig(R);
V=(rot90(V))';
D=rot90(rot90(D));
E=diag(D);
ratio=0;
for k=1:n
    r=E(k)/sum(E);
    ratio=ratio+r;
    if(ratio>=0.9)
        break;
    end
end
S=X*V;
end