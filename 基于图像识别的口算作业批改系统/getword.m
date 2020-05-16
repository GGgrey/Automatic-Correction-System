%%%%%%%%%%用于输出分割出的单个字符(可直接保存到目标文件夹)%%%%%%%%
function y=getword(ii)
Path='D:\Matlab2016a\Matlab_R2016a_win64\workspace\tuxiangyuchuli\'
% persistent iiii;
% if isempty(iiii)
%     iiii=0;
% end
global iiii
[m,n]=size(ii);
wide1=0;
iii=double(ii);
x=zeros(1,n);
getword_lie=lie_slice(ii);
for j=1:n
    for i=1:m
        if(iii(i,j,1)==1)
            x(1,j)=x(1,j)+1;
        end
    end
end

getword_px0=1;
getword_px1=1;
for getword_num=1:getword_lie
    while(x(1,getword_px0)<1&&getword_px0<n)
        getword_px0=getword_px0+1;
    end
    getword_px1=getword_px0;
    while(x(1,getword_px1)>=1&&getword_px1<n)
        getword_px1=getword_px1+1;
    end
    Getword=iii(:,getword_px0:getword_px1,:);
    Getword1=restrict(Getword);
    [gw_m,gw_n]=size(Getword1);
    if(gw_m/gw_n>2&&gw_m/gw_n<=3)
        gw1=imresize(Getword1,[20 14]);
        gw2=zeros(20,3);
        gw3=zeros(20,3);
        gw4=[gw2 gw1 gw3];
        gw5=zeros(4,4);
        gw6=zeros(20,4);
        gw7=zeros(4,20);
        gw8=[gw5 gw7 gw5;gw6 gw4 gw6;gw5 gw7 gw5];
    elseif(gw_m/gw_n>3)
        gw1=imresize(Getword1,[20,8]);
        gw2=zeros(20,6);
        gw3=zeros(20,6);
        gw4=[gw2 gw1 gw3];
        gw5=zeros(4,4);
        gw6=zeros(20,4);
        gw7=zeros(4,20);
        gw8=[gw5 gw7 gw5;gw6 gw4 gw6;gw5 gw7 gw5];
    elseif(gw_n/gw_m>2&&gw_n/gw_m<=3)
        gw1=imresize(Getword1,[14,20]);
        gw2=zeros(3,20);
        gw3=zeros(3,20);
        gw4=[gw2;gw1;gw3];
        gw5=zeros(4,4);
        gw6=zeros(20,4);
        gw7=zeros(4,20);
        gw8=[gw5 gw7 gw5;gw6 gw4 gw6;gw5 gw7 gw5];
    elseif(gw_n/gw_m>3)
        gw1=imresize(Getword1,[8,20]);
        gw2=zeros(6,20);
        gw3=zeros(6,20);
        gw4=[gw2;gw1;gw3];
        gw5=zeros(4,4);
        gw6=zeros(20,4);
        gw7=zeros(4,20);
        gw8=[gw5 gw7 gw5;gw6 gw4 gw6;gw5 gw7 gw5];
    elseif(gw_m<=24&&gw_n<=24)
        gw1=imresize(Getword1,[5,5]);
        gw2=zeros(5,3);
        gw3=zeros(3,5);
        gw4=zeros(3,3);
        gw5=zeros(20,8);
        gw6=zeros(20,20);
        gw7=zeros(5,20);
        gw70=zeros(3,20);
        gw8=[gw5,gw6;gw2,gw1,gw7;gw4,gw3,gw70];
    else
        gw4=imresize(Getword1,[20,20]);
        gw5=zeros(4,4);
        gw6=zeros(20,4);
        gw7=zeros(4,20);
        gw8=[gw5 gw7 gw5;gw6 gw4 gw6;gw5 gw7 gw5];
    end
%   figure,imshow(gw8);
    iiii=iiii+1;
    imwrite(gw8,strcat(Path,'handwrite',num2str(iiii),'.bmp'),'bmp');
    getword_px0=getword_px1;
end
%%%%%%另一种方法%%%%%
%disp(x);
% len=length(x);
% for num=1:len-1
%     if(x(1,num)==0&&x(1,num+1)~=0)
%         wide=num;
%         wide1=0;
%         while sum(ii(:,wide+1))~=0&&wide<=n
%             wide=wide+1;
%             wide1=wide1+1;
%         end
%         y=restrict(imcrop(ii,[num 1 wide1 m]));
%         [mm,nn]=size(y);
%         if(mm/nn>2&&mm/nn<=3)
%             y1=imresize(y,[20 14]);
%             y2=zeros(20,3);
%             y3=zeros(20,3);
%             y4=[y2,y1,y3];
%             y5=zeros(4,4);
%             y6=zeros(20,4);
%             y7=zeros(4,20);
%             y8=[y5 y7 y5;y6 y4 y6;y5 y7 y5];
%         elseif(mm/nn>3)
%             y1=imresize(y,[20 8]);
%             y2=zeros(20,6);
%             y3=zeros(20,6);
%             y4=[y2,y1,y3];
%             y5=zeros(4,4);
%             y6=zeros(20,4);
%             y7=zeros(4,20);
%             y8=[y5 y7 y5;y6 y4 y6;y5 y7 y5];
%         elseif(nn/mm>2&&nn/mm<=3)
%             y1=imresize(y,[14 20]);
%             y2=zeros(3,20);
%             y3=zeros(3,20);
%             y4=[y2;y1;y3];
%             y5=zeros(4,4);
%             y6=zeros(20,4);
%             y7=zeros(4,20);
%             y8=[y5 y7 y5;y6 y4 y6;y5 y7 y5];
%         elseif(nn/mm>3)
%             y1=imresize(y,[8,20]);
%             y2=zeros(6,20);
%             y3=zeros(6,20);
%             y4=[y2;y1;y3];
%             y5=zeros(4,4);
%             y6=zeros(20,4);
%             y7=zeros(4,20);
%             y8=[y5 y7 y5;y6 y4 y6;y5 y7 y5];
%         else
%             y4=imresize(y,[20 20]);
%             y5=zeros(4,4);
%             y6=zeros(20,4);
%             y7=zeros(4,20);
%             y8=[y5 y7 y5;y6 y4 y6;y5 y7 y5];
%         end
%         figure,imshow(y8);
%         iiii=iiii+1;
%         imwrite(y8,strcat(Path,'handwrite',num2str(iiii),'.bmp'),'bmp');
%     end
% end
% end

%%%%%%%%% %得到第一个字符
% [m,n]=size(ii);   
% wide1=0;
% wide2=0;
% while sum(ii(:,wide1+1))~=m&&wide1<n
%     wide1=wide1+1;
% end
% y=char_slice(imcrop(ii,[1 1 wide1 m]));
% end
        