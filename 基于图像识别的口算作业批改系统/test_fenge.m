Path='D:\Matlab2016a\Matlab_R2016a_win64\workspace\tuxiangyuchuli\';
clc;close all;
[fn,pn,fi]=uigetfile('*.*','choose a picture');
Img=imread([pn fn]);
[~,~,c]=size(Img);
if c==1
   f2= ~im2bw(Img,graythresh(Img));
else
   Img=rgb2gray(imread([pn fn]));
   f2= ~im2bw(Img,graythresh(Img));
end
f=f2;
f=bwareaopen(f,50);
% figure(3);imshow(f);
str=strel('square',2);
% f=imclose(f,str);
% str=strel('line',5,0);
f=imdilate(f,str);
figure(3);imshow(f);

[L,num] = bwlabel(f,8);%得到联通区域数num及矩阵L
Feastats = regionprops(L,'basic');
Area=[Feastats.Area];
b=[Feastats.BoundingBox];
sub=cell(1,num);
figure(1);
for i=1:num
    a=floor(b((i-1)*4+2));
    if a==0
       a=1;
    end
    e=b((i-1)*4+4);
    d=floor(b((i-1)*4+1));
    if d==0
       d=1;
    end
    g=b((i-1)*4+3);
    %sub{1,i}=f2(a:a+e,d:d+g);
    if((e+1)/(g+1)>2&&(e+1)/(g+1)<=3)
        gw1=imresize(f2(a:a+e,d:d+g),[20 14]);
        gw2=zeros(20,3);
        gw3=zeros(20,3);
        gw4=[gw2 gw1 gw3];
        gw5=zeros(4,4);
        gw6=zeros(20,4);
        gw7=zeros(4,20);
        gw8=[gw5 gw7 gw5;gw6 gw4 gw6;gw5 gw7 gw5];
    elseif((e+1)/(g+1)>3)
        gw1=imresize(f2(a:a+e,d:d+g),[20,8]);
        gw2=zeros(20,6);
        gw3=zeros(20,6);
        gw4=[gw2 gw1 gw3];
        gw5=zeros(4,4);
        gw6=zeros(20,4);
        gw7=zeros(4,20);
        gw8=[gw5 gw7 gw5;gw6 gw4 gw6;gw5 gw7 gw5];
    elseif((g+1)/(e+1)>2&&(g+1)/(e+1)<=3)
        gw1=imresize(f2(a:a+e,d:d+g),[14,20]);
        gw2=zeros(3,20);
        gw3=zeros(3,20);
        gw4=[gw2;gw1;gw3];
        gw5=zeros(4,4);
        gw6=zeros(20,4);
        gw7=zeros(4,20);
        gw8=[gw5 gw7 gw5;gw6 gw4 gw6;gw5 gw7 gw5];
    elseif((g+1)/(e+1)>3)
        gw1=imresize(f2(a:a+e,d:d+g),[8,20]);
        gw2=zeros(6,20);
        gw3=zeros(6,20);
        gw4=[gw2;gw1;gw3];
        gw5=zeros(4,4);
        gw6=zeros(20,4);
        gw7=zeros(4,20);
        gw8=[gw5 gw7 gw5;gw6 gw4 gw6;gw5 gw7 gw5];
    elseif((e+1)<=12&&(g+1)<=12)
        gw1=imresize(f2(a:a+e,d:d+g),[5,5]);
        gw2=zeros(5,3);
        gw3=zeros(3,5);
        gw4=zeros(3,3);
        gw5=zeros(20,8);
        gw6=zeros(20,20);
        gw7=zeros(5,20);
        gw70=zeros(3,20);
        gw8=[gw5,gw6;gw2,gw1,gw7;gw4,gw3,gw70];
    else
        gw4=imresize(f2(a:a+e,d:d+g),[20,20]);
        gw5=zeros(4,4);
        gw6=zeros(20,4);
        gw7=zeros(4,20);
        gw8=[gw5 gw7 gw5;gw6 gw4 gw6;gw5 gw7 gw5];
    end
    %subplot(1,num,i);
    figure
    imshow(gw8);
    imwrite(gw8,strcat(Path,'fenge_img',num2str(i),'.bmp'),'bmp');
end
figure,imshow(f)
hold on
for k=1:num
    [r,c]=find(L==k);
    rbar=mean(r);
    cbar=mean(c);
    plot(cbar,rbar,'Marker','o','MarkerEdgeColor','k','MarkerFaceColor','k','MarkerSize',10);
    plot(cbar,rbar,'Marker','*','MarkerEdgecolor','w');
end
