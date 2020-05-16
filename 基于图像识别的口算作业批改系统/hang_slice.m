 %%%%%%%%%%%用于算出字符行数的函数%%%%%%%%
function y=hang_slice(ii)
[m,n,p]=size(ii);
iii=double(ii);
hangshu=0;
x=zeros(m,1);
for i=1:m
    for j=1:n
        if(iii(i,j,1)==1)
            x(i,1)=x(i,1)+1;    
        end
    end
end
len=length(x);
for h=1:len-1
    if(x(h,1)==0&&x(h+1,1)~=0)
        hangshu=hangshu+1;
    end
end
y=hangshu;
end