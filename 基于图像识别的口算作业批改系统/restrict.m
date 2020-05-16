%%%%%%%%%%用于限定文字区域的函数%%%%
function y=restrict(ii)  
[m,n]=size(ii);
top=1;bottom=m;left=1;right=n;
while sum(ii(top,:))==0&&top<m
    top=top+1;
end
while sum(ii(bottom,:))==0&&bottom>=1
    bottom=bottom-1;
end
while sum(ii(:,left))==0&&left<n
    left=left+1;
end
while sum(ii(:,right))==0&&right>=1
    right=right-1;
end
chang=right-left;
kuan=bottom-top;
y=imcrop(ii,[left top chang kuan]);
end
