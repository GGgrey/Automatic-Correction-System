%%%%%%%%%%%算出一行中有多少个字符%%%%%%%%%%
function y=lie_slice(ii)
[m,n]=size(ii);
charnum=0;
iii=double(ii);
x=zeros(1,n);
for j=1:n
    for i=1:m
        if(iii(i,j,1)==1)
            x(1,j)=x(1,j)+1;
        end
    end
end
%disp(x);
len=length(x);
for num=1:len-1
    if(x(1,num)==0&&x(1,num+1)~=0)
        charnum=charnum+1;
    end
end
y=charnum;
end