I=imread('100.jpg');
figure(1);
imshow(I);
[m,n,p]=size(I);
for i=1:m
    for j=1:n
        if(I(i,j,:)>=90)
            I(i,j,:)=255;
        end
    end
end
figure(2)
imshow(I);
imwrite(I,'100.bmp','bmp');

IMG=imread('yinshuaziti_demo2.jpg');
level=graythresh(IMG);
IMG1=im2bw(IMG,level);
IMG1=(IMG1~=1);
IMG2=bwareaopen(IMG1,50);
[m,n,p]=size(IMG2);
disp(m);
disp(n);
disp(p);
figure(3);
imshow(IMG2);
IMG2=(IMG2~=1);
imwrite(IMG2,'yinshuaziti_demo3.jpg','jpg');

img=imread('continue.png');
imwrite(img,'continue.jpg','jpg');

img1=imread('kousuanti_demo2.jpg');
I=rgb2gray(img1);%灰度处理
figure(1);
imshow(img1);
img2=diedai_yuzhi(img1);
figure(2);
imshow(img2);%二值化
I1=double(I);
w=fspecial('laplacian',0);%laplacian锐化
I2=imfilter(I,w,'replicate');  
I3=I-I2;
figure(3);
imshow(I3);
w=fspecial('sobel');%sobel锐化
I4=imfilter(img1,w);
I4=img1-I4;
figure(4);
imshow(I4);



Path='D:\Matlab2016a\Matlab_R2016a_win64\workspace\tuxiangyuchuli\'
Image_show=imread('yuanshi.bmp');
Image_bw=imread('YS.bmp');
axes(handles.axes9);
imshow(Image_show);
[Image_bw_m,Image_bw_n]=size(Image_bw);
Image_bw1=double(Image_bw);
[bw_a,bw_b]=find(Image_bw==1);
bw_a_min=min(bw_a);%78
bw_a_max=max(bw_a);%502
bw_b_min=min(bw_b);%113     216
bw_b_max=max(bw_b);%1143    1201
caculate=zeros(20,20);
bw_left=0;
bw_left1=0;
bw_right1=0;
bw_right2=0;
for bw_jj_1=1:Image_bw_n
    flag=0;
    while(sum(Image_bw(:,bw_jj_1))==0&&sum(Image_bw(:,bw_jj_1+1))~=0)
        bw_left=bw_jj_1; %112
        flag=1;
        break;
    end
    if flag==1
        break;
    end
end
%disp(bw_left);%112最左边界   215
bw_sign1=0;
for bw_ij=bw_left:Image_bw_n
    bw_sign=0;
    while(sum(Image_bw(:,bw_ij+bw_sign))==0)
        bw_sign=bw_sign+1;
    end
    if(bw_sign>=20)
        bw_sign1=bw_ij+1;
        break;
    end
end
%disp(bw_sign1);%555
bw_right=round((bw_b_max-bw_b_min)/2)+bw_left;
%disp(bw_right)%中间点  
for bw_jj_2=bw_right:Image_bw_n
    flag=0;
    while(sum(Image_bw(:,bw_jj_2))==0&&sum(Image_bw(:,bw_jj_2+1))~=0)
        bw_left1=bw_jj_2;
        flag=1;
        break;
    end
    if flag==1
        break;
    end
end
%disp(bw_left1);%707右侧左边界     
for bw_jj_3=bw_left1-1:-1:1
    flag=0;
    while(sum(Image_bw(:,bw_jj_3))==0&&sum(Image_bw(:,bw_jj_3-1))~=0)
        bw_right1=bw_jj_3;
        flag=1;
        break;
    end
    if flag==1
        break;
    end
end
%disp(bw_right1);%515左侧右边界
for bw_jj=Image_bw_n:-1:1
    flag=0;
    while(sum(Image_bw(:,bw_jj))==0&&sum(Image_bw(:,bw_jj-1))~=0)
      bw_right2=bw_jj;
      flag=1;
      break;
    end
    if flag==1
        break;
    end
end
%disp(bw_right2);
matrix_bw_1=zeros(Image_bw_m,1);
matrix_bw_2=zeros(Image_bw_n,1);
for bw_i=1:Image_bw_m
    for bw_j=1:Image_bw_n
        if(Image_bw1(bw_i,bw_j)==1);
            matrix_bw_1(bw_i,1)=matrix_bw_1(bw_i,1)+1;
        end
    end
end
for bw_j=1:Image_bw_n
    for bw_i=1:Image_bw_m
        if(Image_bw1(bw_i,bw_j)==1);
            matrix_bw_2(bw_j,1)=matrix_bw_2(bw_j,1)+1;
        end
    end
end
% figure,plot(1:Image_bw_m,matrix_bw_1);
% figure,plot(1:Image_bw_n,matrix_bw_2);
kongyu1=Image_bw_n-bw_b_max
kongyu2=bw_left1-bw_sign1;
kongyu=min(kongyu1,kongyu2);
bw_px0=1;
bw_px1=1;
bw_px2=1;
bw_px3=1;
bw_hang_num=hang_slice(Image_bw);
for i=1:bw_hang_num%4
    while(matrix_bw_1(bw_px0,1)<1&&bw_px0<=Image_bw_m)
        bw_px0=bw_px0+1;
    end
    bw_px1=bw_px0;
    while(matrix_bw_1(bw_px1,1)>=1&&bw_px1<=Image_bw_m)
        bw_px1=bw_px1+1;
    end
    bw_fenge1=Image_bw(bw_px0-1:bw_px1+1,1:bw_sign1+1);
    bw_fenge2=Image_bw(bw_px0-1:bw_px1+1,bw_sign1+1:Image_bw_n);
    if(kongyu>80)
        line([bw_left,bw_sign1+80],[bw_px0,bw_px0],'color','b');
        line([bw_left,bw_sign1+80],[bw_px1,bw_px1],'color','b');
        line([bw_left1,bw_b_max+80],[bw_px0,bw_px0],'color','b');
        line([bw_left1,bw_b_max+80],[bw_px1,bw_px1],'color','b');
        line([bw_left,bw_left],[bw_px0,bw_px1],'color','b');
        line([bw_sign1+80,bw_sign1+80],[bw_px0,bw_px1],'color','b');
        line([bw_left1,bw_left1],[bw_px0,bw_px1],'color','b');
        line([bw_b_max+80,bw_b_max+80],[bw_px0,bw_px1],'color','b');
    else
        line([bw_left,bw_sign1+kongyu],[bw_px0,bw_px0],'color','b');
        line([bw_left,bw_sign1+kongyu],[bw_px1,bw_px1],'color','b');
        line([bw_left1,bw_b_max+kongyu],[bw_px0,bw_px0],'color','b');
        line([bw_left1,bw_b_max+kongyu],[bw_px1,bw_px1],'color','b');
        line([bw_left,bw_left],[bw_px0,bw_px1],'color','b');
        line([bw_sign1+kongyu,bw_sign1+kongyu],[bw_px0,bw_px1],'color','b');
        line([bw_left1,bw_left1],[bw_px0,bw_px1],'color','b');
        line([bw_b_max+kongyu,bw_b_max+kongyu],[bw_px0,bw_px1],'color','b');
    end
    %figure,imshow(bw_fenge);
    imwrite(bw_fenge1,strcat(Path,strcat('bw',num2str(i+i-1)),'.bmp'),'bmp');
    imwrite(bw_fenge2,strcat(Path,strcat('bw',num2str(i+i)),'.bmp'),'bmp');
    bw_px0=bw_px1;
end
h=getframe(handles.axes9);
imwrite(h.cdata,'jisuantichuli.bmp','bmp');
global iiii
iiii=0;
for i=1:bw_hang_num*2%%对输入图像分割保存
    caculate_image=strcat('bw',num2str(i),'.bmp');
    caculate_image_path=[Path caculate_image];
    caculate_Image=imread(caculate_image_path);
    getword(caculate_Image);
end
caculate_1=1;
caculate_2=0;
caculate_count=0;
caculate=zeros(20,20);
for caculate_i=1:bw_hang_num*2%8     %%将识别的字符存放于矩阵中,每个式子按列存放于矩阵中%%
    caculate_image1=strcat('bw',num2str(caculate_i),'.bmp');
    caculate_image_path1=[Path caculate_image1];
    caculate_Image1=imread(caculate_image_path1);
    caculate_lie=lie_slice(caculate_Image1);
    caculate_jj=0;
    for caculate_j=caculate_1:caculate_lie+caculate_2
        caculate_image_input=strcat('handwrite',num2str(caculate_j),'.bmp');
        caculate_image_input_path=[Path caculate_image_input];
        caculate_image_Input=imread(caculate_image_input_path);
        caculate_jj=caculate_jj+1;
        caculate(caculate_i,caculate_jj)=yinshua_num_out(caculate_image_Input);   
        caculate_count=caculate_count+1;
    end
    caculate_1=caculate_count+1;
    caculate_2=caculate_count;
end
disp(caculate);
for caculate_i=1:bw_hang_num*2
    caculate_image11=strcat('bw',num2str(caculate_i),'.bmp');
    caculate_image_path11=[Path caculate_image11];
    caculate_Image11=imread(caculate_image_path11);
    caculate_Lie=lie_slice(caculate_Image11);
    flag1=0
    for caculate_j=1:caculate_Lie
        if(caculate(caculate_i,caculate_j)==14&&flag1==0)
            caculate_label=caculate_j;
            flag1=1;
        end
    end
    caculate_label1=0;
    for caculate_j=caculate_label+1:caculate_Lie
        if(caculate(caculate_i,caculate_j)==15)
            caculate_label1=caculate_j;
        end
    end
    if(caculate_label1==0)
        for caculate_jj=caculate_label+1:caculate_Lie
            caculate(caculate_i,caculate_jj)=0;
        end
    else
        for caculate_j=caculate_label+1:caculate_label1-1
            caculate(caculate_i,caculate_j)=0;
        end
        for caculate_j=caculate_label1+1:caculate_Lie
            caculate(caculate_i,caculate_j)=0;
        end
    end
end
disp(caculate);
caculate_iiii=0;
for caculate_iii=1:bw_hang_num*2 %%将手写体字符存放于矩阵中%%
    caculate_image2=strcat('bw',num2str(caculate_iii),'.bmp');
    caculate_image_path2=[Path caculate_image2];
    caculate_Image2=imread(caculate_image_path2);
    caculate_lie1=lie_slice(caculate_Image2);
    flag2=0;
    for caculate_jjj=1:caculate_lie1
        if(caculate(caculate_iii,caculate_jjj)==14&&flag2==0)
            caculate_j4=caculate_jjj;
            flag2=1;
        end
    end
    flag=0;
    for caculate_jjj=caculate_j4+1:caculate_lie1
        if(caculate(caculate_iii,caculate_jjj)==15)
            flag=1;
            caculate_j5=caculate_jjj;
            caculator1=caculate_j5-caculate_j4-1;
            caculator2=caculate_lie1-caculate_j5;
        end
    end
    if(flag==0)
        caculator=caculate_lie1-caculate_j4;
        for caculate_ij=1:caculator
            caculate_result=strcat('handwrite',num2str(caculate_ij+caculate_j4+caculate_iiii),'.bmp');
            caculate_result_path=[Path caculate_result];
            caculate_Result=imread(caculate_result_path);
            caculate(caculate_iii,caculate_j4+caculate_ij)=handwrite_num_out(caculate_Result);
        end
        caculate_iiii=caculate_iiii+caculate_lie1;
    end
    if(flag==1)
        caculator1=caculate_j5-caculate_j4-1;
        caculator2=caculate_lie1-caculate_j5;
        for caculate_ij=1:caculator1
            caculate_result=strcat('handwrite',num2str(caculate_ij+caculate_j4+caculate_iiii),'.bmp');
            caculate_result_path=[Path caculate_result];
            caculate_Result=imread(caculate_result_path);
            caculate(caculate_iii,caculate_ij+caculate_j4)=handwrite_num_out(caculate_Result);
        end
        for caculate_ji=1:caculator2
            caculate_result=strcat('handwrite',num2str(caculate_ji+caculate_j5+caculate_iiii),'.bmp');
            caculate_result_path=[Path caculate_result];
            caculate_Result=imread(caculate_result_path);
            caculate(caculate_iii,caculate_ji+caculate_j5)=handwrite_num_out(caculate_Result);
        end
        caculate_iiii=caculate_iiii+caculate_lie1;
    end
end
disp(caculate);%存储数字与符号
abc=zeros(20,10);
abc1=zeros(20,10);
abc2=zeros(20,10);
abc3=zeros(20,10);
jkl=zeros(20,10);
jkl1=zeros(20,10);
jkl2=zeros(20,10);
result_ghi=zeros(20,10);
fuhao=zeros(1,bw_hang_num*2);
for output_i=1:bw_hang_num*2
    caculate_image3=strcat('bw',num2str(output_i),'.bmp');
    caculate_image_path3=[Path caculate_image3];
    caculate_Image3=imread(caculate_image_path3);
    caculate_lie2=lie_slice(caculate_Image3);%每个算式的字符个数
    for output_j=1:20
        if(caculate(output_i,output_j)==10||caculate(output_i,output_j)==11||caculate(output_i,output_j)==12||caculate(output_i,output_j)==13)
            fuhao(1,output_i)=fuhao(1,output_i)+1;
        end
    end
end
for output_i=1:bw_hang_num*2
    caculate_image3=strcat('bw',num2str(output_i),'.bmp');
    caculate_image_path3=[Path caculate_image3];
    caculate_Image3=imread(caculate_image_path3);
    caculate_lie2=lie_slice(caculate_Image3);
    if(fuhao(1,output_i)==1)
        for output_j=1:caculate_lie2
            if(caculate(output_i,output_j)==10||caculate(output_i,output_j)==11||caculate(output_i,output_j)==12||caculate(output_i,output_j)==13)
                output_j1=output_j;%找出符号位置
                jkl1(output_i,1)=caculate(output_i,output_j);
            end
            if(caculate(output_i,output_j)==14)
                output_j3=output_j;%找等号位置
            end
        end
        for output_jj=1:output_j1-1
            if(caculate(output_i,output_jj)==15)
                output_j2=output_jj;
                for output_jjj=1:output_j2-1
                    abc(output_i,output_jjj)=caculate(output_i,output_jjj)*10^((output_j2-1)-output_jjj);
                end
                for output_jjj=output_j2+1:output_j1-1
                    abc(output_i,output_jjj)=caculate(output_i,output_jjj)*10^(output_j2-output_jjj);
                end
            else
                abc(output_i,output_jj)=caculate(output_i,output_jj)*10^(output_j1-1-output_jj);
            end
        end
        for output_jjjj=output_j1+1:output_j3-1
            if(caculate(output_i,output_jjjj)==15)
                output_j4=output_jjjj;
                for output_jjjjj=output_j1+1:output_j4-1
                    abc1(output_i,output_jjjjj-output_j1)=caculate(output_i,output_jjjjj)*10^(output_j4-output_jjjjj-1);
                end
                for output_jjjjj=output_j4+1:output_j3-1
                    abc1(output_i,output_jjjjj-output_j1)=caculate(output_i,output_jjjjj)*10^(output_j4-output_jjjjj);
                end
            else
                abc1(output_i,output_jjjj-output_j1)=caculate(output_i,output_jjjj)*10^(output_j3-1-output_jjjj);
            end
        end
        for output_jjjj=output_j3+1:caculate_lie2
            if(caculate(output_i,output_jjjj)==15)
                output_j5=output_jjjj;
                for output_jjjjj=output_j3+1:output_j5-1
                    result_ghi(output_i,output_jjjjj-output_j3)=caculate(output_i,output_jjjjj)*10^(output_j5-1-output_jjjjj);
                end
                for output_jjjjj=output_j5+1:caculate_lie2
                    result_ghi(output_i,output_jjjjj-output_j3)=caculate(output_i,output_jjjjj)*10^(output_j5-output_jjjjj);
                end
            else
                result_ghi(output_i,output_jjjj-output_j3)=caculate(output_i,output_jjjj)*10^(caculate_lie2-output_jjjj);
            end
        end
    elseif(fuhao(1,output_i)==2)
        output_a=0;
        output_b=0;
        for output_j=1:caculate_lie2
            if(caculate(output_i,output_j)==16)
                output_a=output_j;%找到左括号位置
            end
            if(caculate(output_i,output_j)==17)
                output_b=output_j;%找到右括号位置
            end
            if(caculate(output_i,output_j)==14)
                output_d=output_j;%找到等号的位置
            end
        end
        if(output_a~=0&&output_b~=0)
            for output_j=output_a+1:output_b-1
                if(caculate(output_i,output_j)==10||caculate(output_i,output_j)==11||caculate(output_i,output_j)==12||caculate(output_i,output_j)==13)
                    output_c=output_j;%找到括号中的符号位置
                    jkl1(output_i,1)=caculate(output_i,output_j);
                end
            end
        end
        if(output_a==0&&output_b==0)
            chengfa=0;
            chufa=0;
            jiafa=0;
            jianfa=0;
            for output_j=1:caculate_lie2
                if(caculate(output_i,output_j)==14)
                    output_deng=output_j;
                end
                if(caculate(output_i,output_j)==10)
                    jiafa=jiafa+1;
                    output_jia=output_j;
                end
                if(caculate(output_i,output_j)==11)
                    jianfa=jianfa+1;
                    output_jian=output_j;
                end
                if(caculate(output_i,output_j)==12)
                    chengfa=chengfa+1;
                    output_cheng=output_j;
                end
                if(caculate(output_i,output_j)==13)
                    chufa=chufa+1;
                    output_chu=output_j;
                end
            end
            if(chengfa==2)
                for output_jj=1:output_cheng-1
                    if(caculate(output_i,output_jj)==12)
                        output_cheng1=output_jj;
                        jkl1(output_i,1)=caculate(output_i,output_cheng1);
                        jkl(output_i,1)=caculate(output_i,output_cheng);
                    end
                end
                for output_jjj=1:output_cheng1-1
                    if(caculate(output_i,output_jjj)==15)
                        output_h1=output_jjj;
                        for output_jjjj=1:output_h1-1
                            abc(output_i,output_jjjj)=caculate(output_i,output_jjjj)*10^(output_h1-1-output_jjjj);
                        end
                        for output_jjjj=output_h1+1:output_cheng1-1
                            abc(output_i,output_jjjj)=caculate(output_i,output_jjjj)*10^(output_h1-output_jjjj);
                        end
                    else
                        abc(output_i,output_jjj)=caculate(output_i,output_jjj)*10^(output_cheng1-1-output_jjj);
                    end
                end
                for output_jjj=output_cheng1+1:output_cheng-1
                    if(caculate(output_i,output_jjj)==15)
                        output_h2=output_jjj;
                        for output_jjjj=output_cheng1+1:output_h2-1
                            abc1(output_i,output_jjjj-output_cheng1)=caculate(output_i,output_jjjj)*10^(output_h2-1-output_jjjj);
                        end
                        for output_jjjj=output_h2+1:output_cheng-1
                            abc1(output_i,output_jjjj-output_cheng1)=caculate(output_i,output_jjjj)*10^(output_h2-output_jjjj);
                        end
                    else
                        abc1(output_i,output_jjj-output_cheng1)=caculate(output_i,output_jjj)*10^(output_cheng-1-output_jjj);
                    end
                end
                for output_jjj=output_cheng+1:output_deng-1
                    if(caculate(output_i,output_jjj)==15)
                        output_h3=output_jjj;
                        for output_jjjj=output_cheng+1:output_h3-1
                            abc2(output_i,output_jjjj-output_cheng)=caculate(output_i,output_jjjj)*10^(output_h3-1-output_jjjj);
                        end
                        for output_jjjj=output_h3+1:output_deng-1
                            abc2(output_i,output_jjjj-output_cheng)=caculate(output_i,output_jjjj)*10^(output_h3-output_jjjj);
                        end
                    else
                        abc2(output_i,output_jjj-output_cheng)=caculate(output_i,output_jjj)*10^(output_deng-1-output_jjj);
                    end
                end
                for output_jjj=output_deng+1:caculate_lie2
                    if(caculate(output_i,output_jjj)==15)
                        output_h4=output_jjj;
                        for output_jjjj=output_deng+1:output_h4-1
                            result_ghi(output_i,output_jjjj-output_deng)=caculate(output_i,output_jjjj)*10^(output_h4-1-output_jjjj);
                        end
                        for output_jjjj=output_h4+1:caculate_lie2
                            result_ghi(output_i,output_jjjj-output_deng)=caculate(output_i,output_jjjj)*10^(output_h4-output_jjjj);
                        end
                    else
                        result_ghi(output_i,output_jjj-output_deng)=caculate(output_i,output_jjj)*10^(caculate_lie2-output_jjj);
                    end
                end 
            elseif(chufa==2)
                for output_jj=1:output_chu-1
                    if(caculate(output_i,output_jj)==13)
                        output_chu1=output_jj;
                        jkl1(output_i,1)=caculate(output_i,output_chu1);
                        jkl(output_i,1)=caculate(output_i,output_chu);
                    end
                end
                for output_jjj=1:output_chu1-1
                    if(caculate(output_i,output_jjj)==15)
                        output_h5=output_jjj;
                        for output_jjjj=1:output_h5-1
                            abc(output_i,output_jjjj)=caculate(output_i,output_jjjj)*10^(output_h5-1-output_jjjj);
                        end
                        for output_jjjj=output_h5+1:output_chu1-1
                            abc(output_i,output_jjjj)=caculate(output_i,output_jjjj)*10^(output_h5-output_jjjj);
                        end
                    else
                        abc(output_i,output_jjj)=caculate(output_i,output_jjj)*10^(output_chu1-1-output_jjj);
                    end
                end
                for output_jjj=output_chu1+1:output_chu-1
                    if(caculate(output_i,output_jjj)==15)
                        output_h6=output_jjj;
                        for output_jjjj=output_chu1+1:output_h6-1
                            abc1(output_i,output_jjjj-output_chu1)=caculate(output_i,output_jjjj)*10^(output_h6-1-output_jjjj);
                        end
                        for output_jjjj=output_h6+1:output_chu-1
                            abc1(output_i,output_jjjj-output_chu1)=caculate(output_i,output_jjjj)*10^(output_h6-output_jjjj);
                        end
                    else
                        abc1(output_i,output_jjj-output_chu1)=caculate(output_i,output_jjj)*10^(output_chu-1-output_jjj);
                    end
                end
                for output_jjj=output_chu+1:output_deng-1
                    if(caculate(output_i,output_jjj)==15)
                        output_h7=output_jjj;
                        for output_jjjj=output_chu+1:output_h7-1
                            abc2(output_i,output_jjjj-output_chu)=caculate(output_i,output_jjjj)*10^(output_h7-1-output_jjjj);
                        end
                        for output_jjjj=output_h7+1:output_deng-1
                            abc2(output_i,output_jjjj-output_chu)=caculate(output_i,output_jjjj)*10^(output_h7-output_jjjj);
                        end
                    else
                        abc2(output_i,output_jjj-output_chu)=caculate(output_i,output_jjj)*10^(output_deng-1-output_jjj);
                    end
                end
                for output_jjj=output_deng+1:caculate_lie2
                    if(caculate(output_i,output_jjj)==15)
                        output_h8=output_jjj;
                        for output_jjjj=output_deng+1:output_h8-1
                            result_ghi(output_i,output_jjjj-output_deng)=caculate(output_i,output_jjjj)*10^(output_h8-1-output_jjjj);
                        end
                        for output_jjjj=output_h8+1:caculate_lie2
                            result_ghi(output_i,output_jjjj-output_deng)=caculate(output_i,output_jjjj)*10^(output_h8-output_jjjj);
                        end
                    else
                        result_ghi(output_i,output_jjj-output_deng)=caculate(output_i,output_jjj)*10^(caculate_lie2-output_jjj);
                    end
                end
            elseif(chengfa==1&&chufa==1)
                if(output_cheng>output_chu)
                    jkl1(output_i,1)=caculate(output_i,output_chu);
                    jkl(output_i,1)=caculate(output_i,output_cheng);
                else
                    jkl1(output_i,1)=caculate(output_i,output_cheng);
                    jkl(output_i,1)=caculate(output_i,output_chu);
                end
                if(output_cheng>output_chu)
                    for output_jjj=1:output_chu-1
                        if(caculate(output_i,output_jjj)==15)
                            output_q1=output_jjj;
                            for output_jjjj=1:output_q1-1
                                abc(output_i,output_jjjj)=caculate(output_i,output_jjjj)*10^(output_q1-1-output_jjjj);
                            end
                            for output_jjjj=output_q1+1:output_chu-1
                                abc(output_i,output_jjjj)=caculate(output_i,output_jjjj)*10^(output_q1-output_jjjj);
                            end
                        else
                            abc(output_i,output_jjj)=caculate(output_i,output_jjj)*10^(output_chu-1-output_jjj);
                        end
                    end
                    for output_jjj=output_chu+1:output_cheng-1
                        if(caculate(output_i,output_jjj)==15)
                            output_q2=output_jjj;
                            for output_jjjj=output_chu+1:output_q2-1
                                abc1(output_i,output_jjjj-output_chu)=caculate(output_i,output_jjjj)*10^(output_q2-1-output_jjjj);
                            end
                            for output_jjjj=output_q2+1:output_cheng-1
                                abc1(output_i,output_jjjj-output_chu)=caculate(output_i,output_jjjj)*10^(output_q2-output_jjjj);
                            end
                        else
                            abc1(output_i,output_jjj-output_chu)=caculate(output_i,output_jjj)*10^(output_cheng-1-output_jjjj);
                        end
                    end
                    for output_jjj=output_cheng+1:output_deng-1
                        if(caculate(output_i,output_jjj)==15)
                            output_q3=output_jjj;
                            for output_jjjj=output_cheng+1:output_q3-1
                                abc2(output_i,output_jjjj-output_cheng)=caculate(output_i,output_jjjj)*10^(output_q3-1-output_jjjj);
                            end
                            for output_jjjj=output_q3+1:output_deng-1
                                abc2(output_i,output_jjjj-output_cheng)=caculate(output_i,output_jjjj)*10^(output_q3-output_jjjj);
                            end
                        else
                            abc2(output_i,output_jjj-output_cheng)=caculate(output_i,output_jjj)*10^(output_deng-1-output_jjj);
                        end
                    end
                    for output_jjj=output_deng+1:caculate_lie2
                        if(caculate(output_i,output_jjj)==15)
                            output_q4=output_jjj;
                            for output_jjjj=output_deng+1:output_q4-1
                                result_ghi(output_i,output_jjjj-output_deng)=caculate(output_i,output_jjjj)*10^(output_q4-1-output_jjjj);
                            end
                            for output_jjjj=output_q4+1:caculate_lie2
                                result_ghi(output_i,output_jjjj-output_deng)=caculate(output_i,output_jjjj)*10^(output_q4-output_jjjj);
                            end
                        else
                            result_ghi(output_i,output_jjj-output_deng)=caculate(output_i,output_jjj)*10^(caculate_lie2-output_jjj);
                        end
                    end
                else
                    for output_jjj=1:output_cheng-1
                        if(caculate(output_i,output_jjj)==15)
                            output_q1=output_jjj;
                            for output_jjjj=1:output_q1-1
                                abc(output_i,output_jjjj)=caculate(output_i,output_jjjj)*10^(output_q1-1-output_jjjj);
                            end
                            for output_jjjj=output_q1+1:output_cheng-1
                                abc(output_i,output_jjjj)=caculate(output_i,output_jjjj)*10^(output_q1-output_jjjj);
                            end
                        else
                            abc(output_i,output_jjj)=caculate(output_i,output_jjj)*10^(output_cheng-1-output_jjj);
                        end
                    end
                    for output_jjj=output_cheng+1:output_chu-1
                        if(caculate(output_i,output_jjj)==15)
                            output_q2=output_jjj;
                            for output_jjjj=output_cheng+1:output_q2-1
                                abc1(output_i,output_jjjj-output_cheng)=caculate(output_i,output_jjjj)*10^(output_q2-1-output_jjjj);
                            end
                            for output_jjjj=output_q2+1:output_chu-1
                                abc1(output_i,output_jjjj-output_cheng)=caculate(output_i,output_jjjj)*10^(output_q2-output_jjjj);
                            end
                        else
                            abc1(output_i,output_jjj-output_cheng)=caculate(output_i,output_jjj)*10^(output_chu-1-output_jjjj);
                        end
                    end
                    for output_jjj=output_chu+1:output_deng-1
                        if(caculate(output_i,output_jjj)==15)
                            output_q3=output_jjj;
                            for output_jjjj=output_chu+1:output_q3-1
                                abc2(output_i,output_jjjj-output_chu)=caculate(output_i,output_jjjj)*10^(output_q3-1-output_jjjj);
                            end
                            for output_jjjj=output_q3+1:output_deng-1
                                abc2(output_i,output_jjjj-output_chu)=caculate(output_i,output_jjjj)*10^(output_q3-output_jjjj);
                            end
                        else
                            abc2(output_i,output_jjj-output_chu)=caculate(output_i,output_jjj)*10^(output_deng-1-output_jjj);
                        end
                    end
                    for output_jjj=output_deng+1:caculate_lie2
                        if(caculate(output_i,output_jjj)==15)
                            output_q4=output_jjj;
                            for output_jjjj=output_deng+1:output_q4-1
                                result_ghi(output_i,output_jjjj-output_deng)=caculate(output_i,output_jjjj)*10^(output_q4-1-output_jjjj);
                            end
                            for output_jjjj=output_q4+1:caculate_lie2
                                result_ghi(output_i,output_jjjj-output_deng)=caculate(output_i,output_jjjj)*10^(output_q4-output_jjjj);
                            end
                        else
                            result_ghi(output_i,output_jjj-output_deng)=caculate(output_i,output_jjj)*10^(caculate_lie2-output_jjj);
                        end
                    end
                end
            elseif(jiafa==2)
                for output_jj=1:output_jia-1
                    if(caculate(output_i,output_jj)==10)
                        output_jia1=output_jj
                        jkl1(output_i,1)=caculate(output_i,output_jia1);
                        jkl(output_i,1)=caculate(output_i,output_jia);
                    end
                end
                for output_jjj=1:output_jia1-1
                    if(caculate(output_i,output_jjj)==15)
                        output_w1=output_jjj;
                        for output_jjjj=1:output_w1-1
                            abc(output_i,output_jjjj)=caculate(output_i,output_jjjj)*10^(output_w1-1-output_jjjj);
                        end
                        for output_jjjj=output_w1+1:output_jia1-1
                            abc(output_i,output_jjjj)=caculate(output_output_jjjj)*10^(output_w1-output_jjjj);
                        end
                    else
                        abc(output_i,output_jjj)=caculate(output_i,output_jjj)*10^(output_jia1-1-output_jjj);
                    end
                end
                for output_jjj=output_jia1+1:output_jia-1
                    if(caculate(output_i,output_jjj)==15)
                        output_w2=output_jjj;
                        for output_jjjj=output_jia1+1:output_w2-1
                            abc1(output_i,output_jjjj-output_jia1)=caculate(output_i,output_jjjj)*10^(output_w2-1-output_jjjj);
                        end
                        for output_jjjj=output_w2+1:output_jia-1
                            abc1(output_i,output_jjjj-output_jia1)=caculate(output_i,output_jjjj)*10^(output_w2-output_jjjj);
                        end
                    else
                        abc1(output_i,output_jjj-output_jia1)=caculate(output_i,output_jjj)*10^(output_jia-1-output_jjj);
                    end
                end
                for output_jjj=output_jia+1:output_d-1
                    if(caculate(output_i,output_jjj)==15)
                        output_w3=output_jjj;
                        for output_jjjj=output_jia+1:output_w3-1
                            abc2(output_i,output_jjjj-output_jia)=caculate(output_i,output_jjjj)*10^(output_w3-1-output_jjjj);
                        end
                        for output_jjjj=output_w3+1:output_d-1
                            abc2(output_i,output_jjjj-output_jia)=caculate(output_i,output_jjjj)*10^(output_w3-output_jjjj);
                        end
                    else
                        abc2(output_i,output_jjj-output_jia)=caculate(output_i,output_jjj)*10^(output_d-1-output_jjj);
                    end
                end
                for output_jjj=output_d+1:caculate_lie2
                    if(caculate(output_i,output_jjj)==15)
                        output_w4=output_jjj;
                        for output_jjjj=output_deng+1:output_w4-1
                            result_ghi(output_i,output_jjjj-output_deng)=caculate(output_i,output_jjjj)*10^(output_w4-1-output_jjjj);
                        end
                        for output_jjjj=output_w4+1:caculate_lie2
                            result_ghi(output_i,output_jjjj-output_deng)=caculate(output_i,output_jjjj)*10^(output_w4-output_jjjj);
                        end
                    else
                        result_ghi(output_i,output_jjj-output_d)=caculate(output_i,output_jjj)*10^(caculate_lie2-output_jjj);
                    end
                end
            elseif(jianfa==2)
                for output_jj=1:output_jian-1
                    if(caculate(output_i,output_jj)==10)
                        output_jian1=output_jj
                        jkl1(output_i,1)=caculate(output_i,output_jian1);
                        jkl(output_i,1)=caculate(output_i,output_jian);
                    end
                end
                for output_jjj=1:output_jian1-1
                    if(caculate(output_i,output_jjj)==15)
                        output_e1=output_jjj;
                        for output_jjjj=1:output_e1-1
                            abc(output_i,output_jjjj)=caculate(output_i,output_jjjj)*10^(output_e1-1-output_jjjj);
                        end
                        for output_jjjj=output_e1+1:output_jian1-1
                            abc(output_i,output_jjjj)=caculate(output_output_jjjj)*10^(output_e1-output_jjjj);
                        end
                    else
                        abc(output_i,output_jjj)=caculate(output_i,output_jjj)*10^(output_jian1-1-output_jjj);
                    end
                end
                for output_jjj=output_jian1+1:output_jian-1
                    if(caculate(output_i,output_jjj)==15)
                        output_e2=output_jjj;
                        for output_jjjj=output_jian1+1:output_e2-1
                            abc1(output_i,output_jjjj-output_jian1)=caculate(output_i,output_jjjj)*10^(output_e2-1-output_jjjj);
                        end
                        for output_jjjj=output_e2+1:output_jian-1
                            abc1(output_i,output_jjjj-output_jian1)=caculate(output_i,output_jjjj)*10^(output_e2-output_jjjj);
                        end
                    else
                        abc1(output_i,output_jjj-output_jian1)=caculate(output_i,output_jjj)*10^(output_jian-1-output_jjj);
                    end
                end
                for output_jjj=output_jian+1:output_deng-1
                    if(caculate(output_i,output_jjj)==15)
                        output_e3=output_jjj;
                        for output_jjjj=output_jian+1:output_e3-1
                            abc2(output_i,output_jjjj-output_jian)=caculate(output_i,output_jjjj)*10^(output_e3-1-output_jjjj);
                        end
                        for output_jjjj=output_e3+1:output_deng-1
                            abc2(output_i,output_jjjj-output_jian)=caculate(output_i,output_jjjj)*10^(output_e3-output_jjjj);
                        end
                    else
                        abc2(output_i,output_jjj-output_jian)=caculate(output_i,output_jjj)*10^(output_deng-1-output_jjj);
                    end
                end
                for output_jjj=output_deng+1:caculate_lie2
                    if(caculate(output_i,output_jjj)==15)
                        output_e4=output_jjj;
                        for output_jjjj=output_deng+1:output_e4-1
                            result_ghi(output_i,output_jjjj-output_deng)=caculate(output_i,output_jjjj)*10^(output_e4-1-output_jjjj);
                        end
                        for output_jjjj=output_e4+1:caculate_lie2
                            result_ghi(output_i,output_jjjj-output_deng)=caculate(output_i,output_jjjj)*10^(output_e4-output_jjjj);
                        end
                    else
                        result_ghi(output_i,output_jjj-output_deng)=caculate(output_i,output_jjjj)*10^(caculate_lie2-output_jjj);
                    end
                end
            elseif(jiafa==1&&jianfa==1)
                if(output_jia>output_jian)
                    jkl1(output_i,1)=caculate(output_i,output_jian);
                    jkl(output_i,1)=caculate(output_i,output_jia);
                else
                    jkl1(output_i,1)=caculate(output_i,output_jia);
                    jkl(output_i,1)=caculate(output_i,output_jian);
                end
                if(output_jia>output_jian)
                    for output_jjj=1:output_jian-1
                        if(caculate(output_i,output_jjj)==15)
                            output_q1=output_jjj;
                            for output_jjjj=1:output_q1-1
                                abc(output_i,output_jjjj)=caculate(output_i,output_jjjj)*10^(output_q1-1-output_jjjj);
                            end
                            for output_jjjj=output_q1+1:output_jian-1
                                abc(output_i,output_jjjj)=caculate(output_i,output_jjjj)*10^(output_q1-output_jjjj);
                            end
                        else
                            abc(output_i,output_jjj)=caculate(output_i,output_jjj)*10^(output_jian-1-output_jjj);
                        end
                    end
                    for output_jjj=output_jian+1:output_jia-1
                        if(caculate(output_i,output_jjj)==15)
                            output_q2=output_jjj;
                            for output_jjjj=output_jian+1:output_q2-1
                                abc1(output_i,output_jjjj-output_jian)=caculate(output_i,output_jjjj)*10^(output_q2-1-output_jjjj);
                            end
                            for output_jjjj=output_q2+1:output_jia-1
                                abc1(output_i,output_jjjj-output_jian)=caculate(output_i,output_jjjj)*10^(output_q2-output_jjjj);
                            end
                        else
                            abc1(output_i,output_jjj-output_jian)=caculate(output_i,output_jjj)*10^(output_jia-1-output_jjjj);
                        end
                    end
                    for output_jjj=output_jia+1:output_deng-1
                        if(caculate(output_i,output_jjj)==15)
                            output_q3=output_jjj;
                            for output_jjjj=output_jia+1:output_q3-1
                                abc2(output_i,output_jjjj-output_jia)=caculate(output_i,output_jjjj)*10^(output_q3-1-output_jjjj);
                            end
                            for output_jjjj=output_q3+1:output_deng-1
                                abc2(output_i,output_jjjj-output_jia)=caculate(output_i,output_jjjj)*10^(output_q3-output_jjjj);
                            end
                        else
                            abc2(output_i,output_jjj-output_jia)=caculate(output_i,output_jjj)*10^(output_deng-1-output_jjj);
                        end
                    end
                    for output_jjj=output_deng+1:caculate_lie2
                        if(caculate(output_i,output_jjj)==15)
                            output_q4=output_jjj;
                            for output_jjjj=output_deng+1:output_q4-1
                                result_ghi(output_i,output_jjjj-output_deng)=caculate(output_i,output_jjjj)*10^(output_q4-1-output_jjjj);
                            end
                            for output_jjjj=output_q4+1:caculate_lie2
                                result_ghi(output_i,output_jjjj-output_deng)=caculate(output_i,output_jjjj)*10^(output_q4-output_jjjj);
                            end
                        else
                            result_ghi(output_i,output_jjj-output_deng)=caculate(output_i,output_jjj)*10^(caculate_lie2-output_jjj);
                        end
                    end
                else
                    for output_jjj=1:output_jia-1
                        if(caculate(output_i,output_jjj)==15)
                            output_q1=output_jjj;
                            for output_jjjj=1:output_q1-1
                                abc(output_i,output_jjjj)=caculate(output_i,output_jjjj)*10^(output_q1-1-output_jjjj);
                            end
                            for output_jjjj=output_q1+1:output_jia-1
                                abc(output_i,output_jjjj)=caculate(output_i,output_jjjj)*10^(output_q1-output_jjjj);
                            end
                        else
                            abc(output_i,output_jjj)=caculate(output_i,output_jjj)*10^(output_jia-1-output_jjj);
                        end
                    end
                    for output_jjj=output_jia+1:output_jian-1
                        if(caculate(output_i,output_jjj)==15)
                            output_q2=output_jjj;
                            for output_jjjj=output_jia+1:output_q2-1
                                abc1(output_i,output_jjjj-output_jia)=caculate(output_i,output_jjjj)*10^(output_q2-1-output_jjjj);
                            end
                            for output_jjjj=output_q2+1:output_jian-1
                                abc1(output_i,output_jjjj-output_jia)=caculate(output_i,output_jjjj)*10^(output_q2-output_jjjj);
                            end
                        else
                            abc1(output_i,output_jjj-output_jia)=caculate(output_i,output_jjj)*10^(output_chu-1-output_jjjj);
                        end
                    end
                    for output_jjj=output_jian+1:output_deng-1
                        if(caculate(output_i,output_jjj)==15)
                            output_q3=output_jjj;
                            for output_jjjj=output_jian+1:output_q3-1
                                abc2(output_i,output_jjjj-output_jian)=caculate(output_i,output_jjjj)*10^(output_q3-1-output_jjjj);
                            end
                            for output_jjjj=output_q3+1:output_deng-1
                                abc2(output_i,output_jjjj-output_jian)=caculate(output_i,output_jjjj)*10^(output_q3-output_jjjj);
                            end
                        else
                            abc2(output_i,output_jjj-output_jian)=caculate(output_i,output_jjj)*10^(output_deng-1-output_jjj);
                        end
                    end
                    for output_jjj=output_deng+1:caculate_lie2
                        if(caculate(output_i,output_jjj)==15)
                            output_q4=output_jjj;
                            for output_jjjj=output_deng+1:output_q4-1
                                result_ghi(output_i,output_jjjj-output_deng)=caculate(output_i,output_jjjj)*10^(output_q4-1-output_jjjj);
                            end
                            for output_jjjj=output_q4+1:caculate_lie2
                                result_ghi(output_i,output_jjjj-output_deng)=caculate(output_i,output_jjjj)*10^(output_q4-output_jjjj);
                            end
                        else
                            result_ghi(output_i,output_jjj-output_deng)=caculate(output_i,output_jjj)*10^(caculate_lie2-output_jjj);
                        end
                    end
                end
            elseif(chengfa==1&&jiafa==1)
                if(output_cheng>output_jia)
                    jkl1(output_i,1)=caculate(output_i,output_cheng);
                    jkl(output_i,1)=caculate(output_i,output_jia);
                else
                    jkl1(output_i,1)=caculate(output_i,output_cheng);
                    jkl(output_i,1)=caculate(output_i,output_jia);
                end
                if(output_cheng>output_jia)
                    for output_jjj=1:output_jia+1:output_cheng-1
                        if(caculate(output_i,output_jjj)==15)
                            output_q1=output_jjj;
                            for output_jjjj=output_jia+1:output_q1-1
                                abc(output_i,output_jjjj-output_jia)=caculate(output_i,output_jjjj)*10^(output_q1-1-output_jjjj);
                            end
                            for output_jjjj=output_q1+1:output_cheng-1
                                abc(output_i,output_jjjj-output_jia)=caculate(output_i,output_jjjj)*10^(output_q1-output_jjjj);
                            end
                        else
                            abc(output_i,output_jjj-output_jia)=caculate(output_i,output_jjj)*10^(output_cheng-1-output_jjj);
                        end
                    end
                    for output_jjj=output_cheng+1:output_deng-1
                        if(caculate(output_i,output_jjj)==15)
                            output_q2=output_jjj;
                            for output_jjjj=output_cheng+1:output_q2-1
                                abc1(output_i,output_jjjj-output_cheng)=caculate(output_i,output_jjjj)*10^(output_q2-1-output_jjjj);
                            end
                            for output_jjjj=output_q2+1:output_deng-1
                                abc1(output_i,output_jjjj-output_cheng)=caculate(output_i,output_jjjj)*10^(output_q2-output_jjjj);
                            end
                        else
                            abc1(output_i,output_jjj-output_cheng)=caculate(output_i,output_jjj)*10^(output_deng-1-output_jjjj);
                        end
                    end
                    for output_jjj=1:output_jia-1
                        if(caculate(output_i,output_jjj)==15)
                            output_q3=output_jjj;
                            for output_jjjj=1:output_q3-1
                                abc(output_i,output_jjjj)=caculate(output_i,output_jjjj)*10^(output_q3-1-output_jjjj);
                            end
                            for output_jjjj=output_q3+1:output_jia-1
                                abc(output_i,output_jjjj)=caculate(output_i,output_jjjj)*10^(output_q3-output_jjjj);
                            end
                        else
                            abc(output_i,output_jjj)=caculate(output_i,output_jjj)*10^(output_jia-1-output_jjj);
                        end
                    end
                    for output_jjj=output_deng+1:caculate_lie2
                        if(caculate(output_i,output_jjj)==15)
                            output_q4=output_jjj;
                            for output_jjjj=output_deng+1:output_q4-1
                                result_ghi(output_i,output_jjjj-output_deng)=caculate(output_i,output_jjjj)*10^(output_q4-1-output_jjjj);
                            end
                            for output_jjjj=output_q4+1:caculate_lie2
                                result_ghi(output_i,output_jjjj-output_deng)=caculate(output_i,output_jjjj)*10^(output_q4-output_jjjj);
                            end
                        else
                            result_ghi(output_i,output_jjj-output_deng)=caculate(output_i,output_jjj)*10^(caculate_lie2-output_jjj);
                        end
                    end
                else
                    for output_jjj=1:output_cheng-1
                        if(caculate(output_i,output_jjj)==15)
                            output_q1=output_jjj;
                            for output_jjjj=1:output_q1-1
                                abc(output_i,output_jjjj)=caculate(output_i,output_jjjj)*10^(output_q1-1-output_jjjj);
                            end
                            for output_jjjj=output_q1+1:output_cheng-1
                                abc(output_i,output_jjjj)=caculate(output_i,output_jjjj)*10^(output_q1-output_jjjj);
                            end
                        else
                            abc(output_i,output_jjj)=caculate(output_i,output_jjj)*10^(output_cheng-1-output_jjj);
                        end
                    end
                    for output_jjj=output_cheng+1:output_jia-1
                        if(caculate(output_i,output_jjj)==15)
                            output_q2=output_jjj;
                            for output_jjjj=output_cheng+1:output_q2-1
                                abc1(output_i,output_jjjj-output_cheng)=caculate(output_i,output_jjjj)*10^(output_q2-1-output_jjjj);
                            end
                            for output_jjjj=output_q2+1:output_jia-1
                                abc1(output_i,output_jjjj-output_cheng)=caculate(output_i,output_jjjj)*10^(output_q2-output_jjjj);
                            end
                        else
                            abc1(output_i,output_jjj-output_cheng)=caculate(output_i,output_jjj)*10^(output_jia-1-output_jjjj);
                        end
                    end
                    for output_jjj=output_jia+1:output_deng-1
                        if(caculate(output_i,output_jjj)==15)
                            output_q3=output_jjj;
                            for output_jjjj=output_jia+1:output_q3-1
                                abc2(output_i,output_jjjj-output_jia)=caculate(output_i,output_jjjj)*10^(output_q3-1-output_jjjj);
                            end
                            for output_jjjj=output_q3+1:output_deng-1
                                abc2(output_i,output_jjjj-output_jia)=caculate(output_i,output_jjjj)*10^(output_q3-output_jjjj);
                            end
                        else
                            abc2(output_i,output_jjj-output_jia)=caculate(output_i,output_jjj)*10^(output_deng-1-output_jjj);
                        end
                    end
                    for output_jjj=output_deng+1:caculate_lie2
                        if(caculate(output_i,output_jjj)==15)
                            output_q4=output_jjj;
                            for output_jjjj=output_deng+1:output_q4-1
                                result_ghi(output_i,output_jjjj-output_deng)=caculate(output_i,output_jjjj)*10^(output_q4-1-output_jjjj);
                            end
                            for output_jjjj=output_q4+1:caculate_lie2
                                result_ghi(output_i,output_jjjj-output_deng)=caculate(output_i,output_jjjj)*10^(output_q4-output_jjjj);
                            end
                        else
                            result_ghi(output_i,output_jjj-output_deng)=caculate(output_i,output_jjj)*10^(caculate_lie2-output_jjj);
                        end
                    end
                end
            elseif(chengfa==1&&jianfa==1)
                if(output_cheng>output_jian)
                    jkl1(output_i,1)=caculate(output_i,output_cheng);
                    jkl(output_i,1)=caculate(output_i,output_jian);
                else
                    jkl1(output_i,1)=caculate(output_i,output_cheng);
                    jkl(output_i,1)=caculate(output_i,output_jian);
                end
                if(output_cheng>output_jian)
                    for output_jjj=output_jian+1:output_cheng-1
                        if(caculate(output_i,output_jjj)==15)
                            output_q1=output_jjj;
                            for output_jjjj=output_jian+1:output_q1-1
                                abc(output_i,output_jjjj-output_jian)=caculate(output_i,output_jjjj)*10^(output_q1-1-output_jjjj);
                            end
                            for output_jjjj=output_q1+1:output_cheng-1
                                abc(output_i,output_jjjj-output_jian)=caculate(output_i,output_jjjj)*10^(output_q1-output_jjjj);
                            end
                        else
                            abc(output_i,output_jjj-output_jian)=caculate(output_i,output_jjj)*10^(output_cheng-1-output_jjj);
                        end
                    end
                    for output_jjj=output_cheng+1:output_deng-1
                        if(caculate(output_i,output_jjj)==15)
                            output_q2=output_jjj;
                            for output_jjjj=output_cheng+1:output_q2-1
                                abc1(output_i,output_jjjj-output_cheng)=caculate(output_i,output_jjjj)*10^(output_q2-1-output_jjjj);
                            end
                            for output_jjjj=output_q2+1:output_deng-1
                                abc1(output_i,output_jjjj-output_cheng)=caculate(output_i,output_jjjj)*10^(output_q2-output_jjjj);
                            end
                        else
                            abc1(output_i,output_jjj-output_cheng)=caculate(output_i,output_jjj)*10^(output_deng-1-output_jjjj);
                        end
                    end
                    for output_jjj=1:output_jian-1
                        if(caculate(output_i,output_jjj)==15)
                            output_q3=output_jjj;
                            for output_jjjj=1:output_q3-1
                                abc2(output_i,output_jjjj)=caculate(output_i,output_jjjj)*10^(output_q3-1-output_jjjj);
                            end
                            for output_jjjj=output_q3+1:output_jian-1
                                abc2(output_i,output_jjjj)=caculate(output_i,output_jjjj)*10^(output_q3-output_jjjj);
                            end
                        else
                            abc2(output_i,output_jjj)=caculate(output_i,output_jjj)*10^(output_jian-1-output_jjj);
                        end
                    end
                    for output_jjj=output_deng+1:caculate_lie2
                        if(caculate(output_i,output_jjj)==15)
                            output_q4=output_jjj;
                            for output_jjjj=output_deng+1:output_q4-1
                                result_ghi(output_i,output_jjjj-output_deng)=caculate(output_i,output_jjjj)*10^(output_q4-1-output_jjjj);
                            end
                            for output_jjjj=output_q4+1:caculate_lie2
                                result_ghi(output_i,output_jjjj-output_deng)=caculate(output_i,output_jjjj)*10^(output_q4-output_jjjj);
                            end
                        else
                            result_ghi(output_i,output_jjj-output_deng)=caculate(output_i,output_jjj)*10^(caculate_lie2-output_jjj);
                        end
                    end
                else
                    for output_jjj=1:output_cheng-1
                        if(caculate(output_i,output_jjj)==15)
                            output_q1=output_jjj;
                            for output_jjjj=1:output_q1-1
                                abc(output_i,output_jjjj)=caculate(output_i,output_jjjj)*10^(output_q1-1-output_jjjj);
                            end
                            for output_jjjj=output_q1+1:output_cheng-1
                                abc(output_i,output_jjjj)=caculate(output_i,output_jjjj)*10^(output_q1-output_jjjj);
                            end
                        else
                            abc(output_i,output_jjj)=caculate(output_i,output_jjj)*10^(output_cheng-1-output_jjj);
                        end
                    end
                    for output_jjj=output_cheng+1:output_jian-1
                        if(caculate(output_i,output_jjj)==15)
                            output_q2=output_jjj;
                            for output_jjjj=output_cheng+1:output_q2-1
                                abc1(output_i,output_jjjj-output_cheng)=caculate(output_i,output_jjjj)*10^(output_q2-1-output_jjjj);
                            end
                            for output_jjjj=output_q2+1:output_jian-1
                                abc1(output_i,output_jjjj-output_cheng)=caculate(output_i,output_jjjj)*10^(output_q2-output_jjjj);
                            end
                        else
                            abc1(output_i,output_jjj-output_cheng)=caculate(output_i,output_jjj)*10^(output_jian-1-output_jjjj);
                        end
                    end
                    for output_jjj=output_jian+1:output_deng-1
                        if(caculate(output_i,output_jjj)==15)
                            output_q3=output_jjj;
                            for output_jjjj=output_jian+1:output_q3-1
                                abc2(output_i,output_jjjj-output_jian)=caculate(output_i,output_jjjj)*10^(output_q3-1-output_jjjj);
                            end
                            for output_jjjj=output_q3+1:output_deng-1
                                abc2(output_i,output_jjjj-output_jian)=caculate(output_i,output_jjjj)*10^(output_q3-output_jjjj);
                            end
                        else
                            abc2(output_i,output_jjj-output_jian)=caculate(output_i,output_jjj)*10^(output_deng-1-output_jjj);
                        end
                    end
                    for output_jjj=output_deng+1:caculate_lie2
                        if(caculate(output_i,output_jjj)==15)
                            output_q4=output_jjj;
                            for output_jjjj=output_deng+1:output_q4-1
                                result_ghi(output_i,output_jjjj-output_deng)=caculate(output_i,output_jjjj)*10^(output_q4-1-output_jjjj);
                            end
                            for output_jjjj=output_q4+1:caculate_lie2
                                result_ghi(output_i,output_jjjj-output_deng)=caculate(output_i,output_jjjj)*10^(output_q4-output_jjjj);
                            end
                        else
                            result_ghi(output_i,output_jjj-output_deng)=caculate(output_i,output_jjj)*10^(caculate_lie2-output_jjj);
                        end
                    end
                end
            elseif(chufa==1&&jiafa==1)
                if(output_chu>output_jia)
                    jkl1(output_i,1)=caculate(output_i,output_chu);
                    jkl(output_i,1)=caculate(output_i,output_jia);
                else
                    jkl1(output_i,1)=caculate(output_i,output_chu);
                    jkl(output_i,1)=caculate(output_i,output_jia);
                end
                if(output_chu>output_jia)
                    for output_jjj=output_jia+1:output_chu-1
                        if(caculate(output_i,output_jjj)==15)
                            output_q1=output_jjj;
                            for output_jjjj=output_jia+1:output_q1-1
                                abc(output_i,output_jjjj-output_jia)=caculate(output_i,output_jjjj)*10^(output_q1-1-output_jjjj);
                            end
                            for output_jjjj=output_q1+1:output_chu-1
                                abc(output_i,output_jjjj-output_jia)=caculate(output_i,output_jjjj)*10^(output_q1-output_jjjj);
                            end
                        else
                            abc(output_i,output_jjj-output_jia)=caculate(output_i,output_jjj)*10^(output_chu-1-output_jjj);
                        end
                    end
                    for output_jjj=output_chu+1:output_deng-1
                        if(caculate(output_i,output_jjj)==15)
                            output_q2=output_jjj;
                            for output_jjjj=output_chu+1:output_q2-1
                                abc1(output_i,output_jjjj-output_chu)=caculate(output_i,output_jjjj)*10^(output_q2-1-output_jjjj);
                            end
                            for output_jjjj=output_q2+1:output_deng-1
                                abc1(output_i,output_jjjj-output_chu)=caculate(output_i,output_jjjj)*10^(output_q2-output_jjjj);
                            end
                        else
                            abc1(output_i,output_jjj-output_chu)=caculate(output_i,output_jjj)*10^(output_deng-1-output_jjjj);
                        end
                    end
                    for output_jjj=1:output_jia-1
                        if(caculate(output_i,output_jjj)==15)
                            output_q3=output_jjj;
                            for output_jjjj=1:output_q3-1
                                abc2(output_i,output_jjjj)=caculate(output_i,output_jjjj)*10^(output_q3-1-output_jjjj);
                            end
                            for output_jjjj=output_q3+1:output_jia-1
                                abc2(output_i,output_jjjj)=caculate(output_i,output_jjjj)*10^(output_q3-output_jjjj);
                            end
                        else
                            abc2(output_i,output_jjj)=caculate(output_i,output_jjj)*10^(output_jia-1-output_jjj);
                        end
                    end
                    for output_jjj=output_deng+1:caculate_lie2
                        if(caculate(output_i,output_jjj)==15)
                            output_q4=output_jjj;
                            for output_jjjj=output_deng+1:output_q4-1
                                result_ghi(output_i,output_jjjj-output_deng)=caculate(output_i,output_jjjj)*10^(output_q4-1-output_jjjj);
                            end
                            for output_jjjj=output_q4+1:caculate_lie2
                                result_ghi(output_i,output_jjjj-output_deng)=caculate(output_i,output_jjjj)*10^(output_q4-output_jjjj);
                            end
                        else
                            result_ghi(output_i,output_jjj-output_deng)=caculate(output_i,output_jjj)*10^(caculate_lie2-output_jjj);
                        end
                    end
                else
                    for output_jjj=1:output_chu-1
                        if(caculate(output_i,output_jjj)==15)
                            output_q1=output_jjj;
                            for output_jjjj=1:output_q1-1
                                abc(output_i,output_jjjj)=caculate(output_i,output_jjjj)*10^(output_q1-1-output_jjjj);
                            end
                            for output_jjjj=output_q1+1:output_chu-1
                                abc(output_i,output_jjjj)=caculate(output_i,output_jjjj)*10^(output_q1-output_jjjj);
                            end
                        else
                            abc(output_i,output_jjj)=caculate(output_i,output_jjj)*10^(output_chu-1-output_jjj);
                        end
                    end
                    for output_jjj=output_chu+1:output_jian-1
                        if(caculate(output_i,output_jjj)==15)
                            output_q2=output_jjj;
                            for output_jjjj=output_chu+1:output_q2-1
                                abc1(output_i,output_jjjj-output_chu)=caculate(output_i,output_jjjj)*10^(output_q2-1-output_jjjj);
                            end
                            for output_jjjj=output_q2+1:output_jian-1
                                abc1(output_i,output_jjjj-output_chu)=caculate(output_i,output_jjjj)*10^(output_q2-output_jjjj);
                            end
                        else
                            abc1(output_i,output_jjj-output_chu)=caculate(output_i,output_jjj)*10^(output_jian-1-output_jjjj);
                        end
                    end
                    for output_jjj=output_jian+1:output_deng-1
                        if(caculate(output_i,output_jjj)==15)
                            output_q3=output_jjj;
                            for output_jjjj=output_jian+1:output_q3-1
                                abc2(output_i,output_jjjj-output_jian)=caculate(output_i,output_jjjj)*10^(output_q3-1-output_jjjj);
                            end
                            for output_jjjj=output_q3+1:output_deng-1
                                abc2(output_i,output_jjjj-output_jian)=caculate(output_i,output_jjjj)*10^(output_q3-output_jjjj);
                            end
                        else
                            abc2(output_i,output_jjj-output_jian)=caculate(output_i,output_jjj)*10^(output_deng-1-output_jjj);
                        end
                    end
                    for output_jjj=output_deng+1:caculate_lie2
                        if(caculate(output_i,output_jjj)==15)
                            output_q4=output_jjj;
                            for output_jjjj=output_deng+1:output_q4-1
                                result_ghi(output_i,output_jjjj-output_deng)=caculate(output_i,output_jjjj)*10^(output_q4-1-output_jjjj);
                            end
                            for output_jjjj=output_q4+1:caculate_lie2
                                result_ghi(output_i,output_jjjj-output_deng)=caculate(output_i,output_jjjj)*10^(output_q4-output_jjjj);
                            end
                        else
                            result_ghi(output_i,output_jjj-output_deng)=caculate(output_i,output_jjj)*10^(caculate_lie2-output_jjj);
                        end
                    end
                end
            elseif(chufa==1&&jianfa==1)
                if(output_chu>output_jianfa)
                    jkl1(output_i,1)=caculate(output_i,output_chu);
                    jkl(output_i,1)=caculate(output_i,output_jian);
                else
                    jkl1(output_i,1)=caculate(output_i,output_chu);
                    jkl(output_i,1)=caculate(output_i,output_jian);
                end
                if(output_chu>output_jian)
                    for output_jjj=output_jian+1:output_chu-1
                        if(caculate(output_i,output_jjj)==15)
                            output_q1=output_jjj;
                            for output_jjjj=output_jian+1:output_q1-1
                                abc(output_i,output_jjjj-output_jian)=caculate(output_i,output_jjjj)*10^(output_q1-1-output_jjjj);
                            end
                            for output_jjjj=output_q1+1:output_chu-1
                                abc(output_i,output_jjjj-output_jian)=caculate(output_i,output_jjjj)*10^(output_q1-output_jjjj);
                            end
                        else
                            abc(output_i,output_jjj-output_jian)=caculate(output_i,output_jjj)*10^(output_chu-1-output_jjj);
                        end
                    end
                    for output_jjj=output_chu+1:output_deng-1
                        if(caculate(output_i,output_jjj)==15)
                            output_q2=output_jjj;
                            for output_jjjj=output_chu+1:output_q2-1
                                abc1(output_i,output_jjjj-output_chu)=caculate(output_i,output_jjjj)*10^(output_q2-1-output_jjjj);
                            end
                            for output_jjjj=output_q2+1:output_deng-1
                                abc1(output_i,output_jjjj-output_chu)=caculate(output_i,output_jjjj)*10^(output_q2-output_jjjj);
                            end
                        else
                            abc1(output_i,output_jjj-output_chu)=caculate(output_i,output_jjj)*10^(output_deng-1-output_jjjj);
                        end
                    end
                    for output_jjj=1:output_jian-1
                        if(caculate(output_i,output_jjj)==15)
                            output_q3=output_jjj;
                            for output_jjjj=1:output_q3-1
                                abc2(output_i,output_jjjj)=caculate(output_i,output_jjjj)*10^(output_q3-1-output_jjjj);
                            end
                            for output_jjjj=output_q3+1:output_jian-1
                                abc2(output_i,output_jjjj)=caculate(output_i,output_jjjj)*10^(output_q3-output_jjjj);
                            end
                        else
                            abc2(output_i,output_jjj)=caculate(output_i,output_jjj)*10^(output_jian-1-output_jjj);
                        end
                    end
                    for output_jjj=output_deng+1:caculate_lie2
                        if(caculate(output_i,output_jjj)==15)
                            output_q4=output_jjj;
                            for output_jjjj=output_deng+1:output_q4-1
                                result_ghi(output_i,output_jjjj-output_deng)=caculate(output_i,output_jjjj)*10^(output_q4-1-output_jjjj);
                            end
                            for output_jjjj=output_q4+1:caculate_lie2
                                result_ghi(output_i,output_jjjj-output_deng)=caculate(output_i,output_jjjj)*10^(output_q4-output_jjjj);
                            end
                        else
                            result_ghi(output_i,output_jjj-output_deng)=caculate(output_i,output_jjj)*10^(caculate_lie2-output_jjj);
                        end
                    end
                else
                    for output_jjj=1:output_chu-1
                        if(caculate(output_i,output_jjj)==15)
                            output_q1=output_jjj;
                            for output_jjjj=1:output_q1-1
                                abc(output_i,output_jjjj)=caculate(output_i,output_jjjj)*10^(output_q1-1-output_jjjj);
                            end
                            for output_jjjj=output_q1+1:output_chu-1
                                abc(output_i,output_jjjj)=caculate(output_i,output_jjjj)*10^(output_q1-output_jjjj);
                            end
                        else
                            abc(output_i,output_jjj)=caculate(output_i,output_jjj)*10^(output_chu-1-output_jjj);
                        end
                    end
                    for output_jjj=output_chu+1:output_jian-1
                        if(caculate(output_i,output_jjj)==15)
                            output_q2=output_jjj;
                            for output_jjjj=output_chu+1:output_q2-1
                                abc1(output_i,output_jjjj-output_chu)=caculate(output_i,output_jjjj)*10^(output_q2-1-output_jjjj);
                            end
                            for output_jjjj=output_q2+1:output_jian-1
                                abc1(output_i,output_jjjj-output_chu)=caculate(output_i,output_jjjj)*10^(output_q2-output_jjjj);
                            end
                        else
                            abc1(output_i,output_jjj-output_chu)=caculate(output_i,output_jjj)*10^(output_jian-1-output_jjjj);
                        end
                    end
                    for output_jjj=output_jian+1:output_deng-1
                        if(caculate(output_i,output_jjj)==15)
                            output_q3=output_jjj;
                            for output_jjjj=output_jian+1:output_q3-1
                                abc2(output_i,output_jjjj-output_jian)=caculate(output_i,output_jjjj)*10^(output_q3-1-output_jjjj);
                            end
                            for output_jjjj=output_q3+1:output_deng-1
                                abc2(output_i,output_jjjj-output_jian)=caculate(output_i,output_jjjj)*10^(output_q3-output_jjjj);
                            end
                        else
                            abc2(output_i,output_jjj-output_jian)=caculate(output_i,output_jjj)*10^(output_deng-1-output_jjj);
                        end
                    end
                    for output_jjj=output_deng+1:caculate_lie2
                        if(caculate(output_i,output_jjj)==15)
                            output_q4=output_jjj;
                            for output_jjjj=output_deng+1:output_q4-1
                                result_ghi(output_i,output_jjjj-output_deng)=caculate(output_i,output_jjjj)*10^(output_q4-1-output_jjjj);
                            end
                            for output_jjjj=output_q4+1:caculate_lie2
                                result_ghi(output_i,output_jjjj-output_deng)=caculate(output_i,output_jjjj)*10^(output_q4-output_jjjj);
                            end
                        else
                            result_ghi(output_i,output_jjj-output_deng)=caculate(output_i,output_jjj)*10^(caculate_lie2-output_jjj);
                        end
                    end
                end
            end
        else            
            if(output_a==1)
                output_e=output_b+1;
                jkl(output_i,1)=caculate(output_i,output_e);
                for output_j=output_a+1:output_c-1
                    if(caculate(output_i,output_j)==15)
                        output_g=output_j;
                        for output_jj=output_a+1:output_g-1
                            abc(output_i,output_jj-output_a)=caculate(output_i,output_jj)*10^(output_g-1-output_jj);
                        end
                        for output_jj=output_g+1:output_c-1
                            abc(output_i,output_jj-output_a)=caculate(output_i,output_jj)*10^(output_g-output_jj);
                        end
                    else
                        abc(output_i,output_j)=caculate(output_i,output_j)*10^(output_c-1-output_j);
                    end
                end
                for output_j=output_c+1:output_b-1
                    if(caculate(output_i,output_j)==15)
                        output_g1=output_j;
                        for output_jj=output_c+1:output_g1-1
                            abc1(output_i,output_jj-output_c)=caculate(output_i,output_jj)*10^(output_g1-1-output_jj);
                        end
                        for output_jj=output_g1+1:output_b-1
                            abc1(output_i,output_jj-output_c)=caculate(output_i,output_jj)*10^(output_g1-output_jj);
                        end
                    else
                        abc1(output_i,output_j)=caculate(output_i,output_j)*10^(output_b-1-output_j);
                    end
                end
                for output_j=output_e+1:output_d-1
                    if(caculate(output_i,output_j)==15)
                        output_g2=output_j;
                        for output_jj=output_e+1:output_g2-1
                            abc2(output_i,output_jj-output_e)=caculate(output_i,output_jj)*10^(output_g2-1-output_jj);
                        end
                        for output_jj=output_g2+1:output_d-1
                            abc2(output_i,output_jj-output_e)=caculate(output_i,output_jj)*10^(output_g2-output_jj);
                        end
                    else
                        abc2(output_i,output_j)=caculate(output_i,output_j)*10^(output_d-1-output_j);
                    end
                end
                for output_j=output_d+1:caculate_lie2
                    if(caculate(output_i,output_j)==15)
                        output_g3=output_j
                        for output_jj=output_d+1:output_g3-1
                            result_ghi(output_i,output_jj-output_d)=caculate(output_i,output_jj)*10^(output_g3-1-output_jj);
                        end
                        for output_jj=output_g3+1:caculate_lie2
                            result_ghi(output_i,output_jj-output_d)=caculate(output_i,output_jj)*10^(output_g3-output_jj);
                        end
                    else
                        result_ghi(output_i,output_j)=caculate(output_i,output_j)*10^(caculate_lie2-output_j);
                    end
                end         
            else
                output_e=output_a-1;
                jkl(output_i,1)=caculate(output_i,output_e);
                for output_j=1:output_e-1
                    if(caculate(output_i,output_j)==15)
                        output_g4=output_j;
                        for output_jj=1:output_g4-1
                            abc2(output_i,output_jj)=caculate(output_i,output_jj)*10^(output_g4-1-output_jj);
                        end
                        for output_jj=output_g4+1:output_e-1
                            abc2(output_i,output_jj)=caculate(output_i,output_jj)*10^(output_g4-output_jj);
                        end
                    else
                        abc2(output_i,output_j)=caculate(output_i,output_j)*10^(output_e-1-output_j);
                    end
                end
                for output_j=output_a+1:output_c-1
                    if(caculate(output_i,output_j)==15)
                        output_g5=output_j;
                        for output_jj=output_a+1:output_g5-1
                            abc1(output_i,output_jj-output_a)=caculate(output_i,output_jj)*10^(output_g5-1-output_jj);
                        end
                        for output_jj=output_g5+1:output_c-1
                            abc1(output_i,output_jj-output_a)=caculate(output_i,output_jj)*10^(output_g5-output_jj);
                        end
                    else
                        abc1(output_i,output_j-output_a)=caculate(output_i,output_j)*10^(output_c-1-output_j);
                    end
                end
                for output_j=output_c+1:output_b-1
                    if(caculate(output_i,output_j)==15)
                        output_g6=output_j;
                        for output_jj=output_c+1:output_g6-1
                            abc2(output_i,output_jj-output_c)=caculate(output_i,output_jj)*10^(output_g6-1-output_jj);
                        end
                        for output_jj=output_g6+1:output_b-1
                            abc2(output_i,output_jj-output_c)=caculate(output_i,output_jj)*10^(output_g6-output_jj);
                        end
                    else
                        abc2(output_i,output_j-output_c)=caculate(output_i,output_j)*10^(output_b-1-output_j);
                    end
                end
                for output_j=output_d+1:caculate_lie2
                    if(caculate(output_i,output_j)==15)
                        output_g7=output_j;
                        for output_jj=output_d+1:output_g7-1
                            result_ghi(output_i,output_jj-output_d)=caculate(output_i,output_jj)*10^(output_g7-1-output_jj);
                        end
                        for output_jj=output_g7+1:caculate_lie2
                            result_ghi(output_i,output_jj-output_d)=caculate(output_i,output_jj)*10^(output_g7-output_jj);
                        end
                    else
                        result_ghi(output_i,output_j-output_d)=caculate(output_i,output_j)*10^(caculate_lie2-output_j);
                    end
                end
            end
        end
    end
end
disp(abc);
disp(abc1);
disp(abc2);
disp(jkl);
disp(jkl1);
disp(result_ghi);


                
                    
        
   
       
            
            
                    
%%%%%%%%%%%%%%加减乘除运算%%%%%%%%%%%%%%            
            
% Path='D:\Matlab2016a\Matlab_R2016a_win64\workspace\tuxiangyuchuli\'
% Image_show=imread('yuanshi.bmp');
% Image_bw=imread('YS.bmp');
% axes(handles.axes9);
% imshow(Image_show);
% [Image_bw_m,Image_bw_n]=size(Image_bw);
% Image_bw1=double(Image_bw);
% [bw_a,bw_b]=find(Image_bw==1);
% bw_a_min=min(bw_a);%78
% bw_a_max=max(bw_a);%502
% bw_b_min=min(bw_b);%113     216
% bw_b_max=max(bw_b);%1143    1201
% caculate=zeros(20,20);
% bw_left=0;
% bw_left1=0;
% bw_right1=0;
% bw_right2=0;
% for bw_jj_1=1:Image_bw_n
%     flag=0;
%     while(sum(Image_bw(:,bw_jj_1))==0&&sum(Image_bw(:,bw_jj_1+1))~=0)
%         bw_left=bw_jj_1; %112
%         flag=1;
%         break;
%     end
%     if flag==1
%         break;
%     end
% end
% %disp(bw_left);%112最左边界   215
% bw_sign1=0;
% for bw_ij=bw_left:Image_bw_n
%     bw_sign=0;
%     while(sum(Image_bw(:,bw_ij+bw_sign))==0)
%         bw_sign=bw_sign+1;
%     end
%     if(bw_sign>=20)
%         bw_sign1=bw_ij+1;
%         break;
%     end
% end
% %disp(bw_sign1);%555
% bw_right=round((bw_b_max-bw_b_min)/2)+bw_left;
% %disp(bw_right)%中间点  
% for bw_jj_2=bw_right:Image_bw_n
%     flag=0;
%     while(sum(Image_bw(:,bw_jj_2))==0&&sum(Image_bw(:,bw_jj_2+1))~=0)
%         bw_left1=bw_jj_2;
%         flag=1;
%         break;
%     end
%     if flag==1
%         break;
%     end
% end
% %disp(bw_left1);%707右侧左边界     
% for bw_jj_3=bw_left1-1:-1:1
%     flag=0;
%     while(sum(Image_bw(:,bw_jj_3))==0&&sum(Image_bw(:,bw_jj_3-1))~=0)
%         bw_right1=bw_jj_3;
%         flag=1;
%         break;
%     end
%     if flag==1
%         break;
%     end
% end
% %disp(bw_right1);%515左侧右边界
% for bw_jj=Image_bw_n:-1:1
%     flag=0;
%     while(sum(Image_bw(:,bw_jj))==0&&sum(Image_bw(:,bw_jj-1))~=0)
%       bw_right2=bw_jj;
%       flag=1;
%       break;
%     end
%     if flag==1
%         break;
%     end
% end
% %disp(bw_right2);
% matrix_bw_1=zeros(Image_bw_m,1);
% matrix_bw_2=zeros(Image_bw_n,1);
% for bw_i=1:Image_bw_m
%     for bw_j=1:Image_bw_n
%         if(Image_bw1(bw_i,bw_j)==1);
%             matrix_bw_1(bw_i,1)=matrix_bw_1(bw_i,1)+1;
%         end
%     end
% end
% for bw_j=1:Image_bw_n
%     for bw_i=1:Image_bw_m
%         if(Image_bw1(bw_i,bw_j)==1);
%             matrix_bw_2(bw_j,1)=matrix_bw_2(bw_j,1)+1;
%         end
%     end
% end
% % figure,plot(1:Image_bw_m,matrix_bw_1);
% % figure,plot(1:Image_bw_n,matrix_bw_2);
% kongyu1=Image_bw_n-bw_b_max
% kongyu2=bw_left1-bw_sign1;
% kongyu=min(kongyu1,kongyu2);
% bw_px0=1;
% bw_px1=1;
% bw_px2=1;
% bw_px3=1;
% bw_hang_num=hang_slice(Image_bw);
% for i=1:bw_hang_num%4
%     while(matrix_bw_1(bw_px0,1)<1&&bw_px0<=Image_bw_m)
%         bw_px0=bw_px0+1;
%     end
%     bw_px1=bw_px0;
%     while(matrix_bw_1(bw_px1,1)>=1&&bw_px1<=Image_bw_m)
%         bw_px1=bw_px1+1;
%     end
%     bw_fenge1=Image_bw(bw_px0-1:bw_px1+1,1:bw_sign1+1);
%     bw_fenge2=Image_bw(bw_px0-1:bw_px1+1,bw_sign1+1:Image_bw_n);
%     if(kongyu>80)
%         line([bw_left,bw_sign1+80],[bw_px0,bw_px0],'color','b');
%         line([bw_left,bw_sign1+80],[bw_px1,bw_px1],'color','b');
%         line([bw_left1,bw_b_max+80],[bw_px0,bw_px0],'color','b');
%         line([bw_left1,bw_b_max+80],[bw_px1,bw_px1],'color','b');
%         line([bw_left,bw_left],[bw_px0,bw_px1],'color','b');
%         line([bw_sign1+80,bw_sign1+80],[bw_px0,bw_px1],'color','b');
%         line([bw_left1,bw_left1],[bw_px0,bw_px1],'color','b');
%         line([bw_b_max+80,bw_b_max+80],[bw_px0,bw_px1],'color','b');
%     else
%         line([bw_left,bw_sign1+kongyu],[bw_px0,bw_px0],'color','b');
%         line([bw_left,bw_sign1+kongyu],[bw_px1,bw_px1],'color','b');
%         line([bw_left1,bw_b_max+kongyu],[bw_px0,bw_px0],'color','b');
%         line([bw_left1,bw_b_max+kongyu],[bw_px1,bw_px1],'color','b');
%         line([bw_left,bw_left],[bw_px0,bw_px1],'color','b');
%         line([bw_sign1+kongyu,bw_sign1+kongyu],[bw_px0,bw_px1],'color','b');
%         line([bw_left1,bw_left1],[bw_px0,bw_px1],'color','b');
%         line([bw_b_max+kongyu,bw_b_max+kongyu],[bw_px0,bw_px1],'color','b');
%     end
%     %figure,imshow(bw_fenge);
%     imwrite(bw_fenge1,strcat(Path,strcat('bw',num2str(i+i-1)),'.bmp'),'bmp');
%     imwrite(bw_fenge2,strcat(Path,strcat('bw',num2str(i+i)),'.bmp'),'bmp');
%     bw_px0=bw_px1;
% end
% % [FileName,PathName] = uiputfile({'*.jpg','JPEG(*.jpg)';...
% %                                              '*.bmp','Bitmap(*.bmp)';...
% %                                              '*.gif','GIF(*.gif)';...
% %                                              '*.*',  'All Files (*.*)'},...
% %                                              'Save Picture','Untitled');
% % if FileName==0
% %       disp('保存失败');
% %       return;
% % else
% %       h=getframe(handles.axes9);%picture是GUI界面绘图的坐标系句柄
% %       imwrite(h.cdata,[PathName,FileName]);
% % end           
% h=getframe(handles.axes9);
% imwrite(h.cdata,'jisuantichuli.bmp','bmp');
% global iiii
% iiii=0;
% for i=1:bw_hang_num*2%%对输入图像分割保存
%     caculate_image=strcat('bw',num2str(i),'.bmp');
%     caculate_image_path=[Path caculate_image];
%     caculate_Image=imread(caculate_image_path);
%     getword(caculate_Image);
% end
% caculate_1=1;
% caculate_2=0;
% caculate_count=0;
% caculate=zeros(20,20);
% for caculate_i=1:bw_hang_num*2%8     %%将识别的字符存放于矩阵中,每个式子按列存放于矩阵中%%
%     caculate_image1=strcat('bw',num2str(caculate_i),'.bmp');
%     caculate_image_path1=[Path caculate_image1];
%     caculate_Image1=imread(caculate_image_path1);
%     caculate_lie=lie_slice(caculate_Image1);
%     caculate_jj=0;
%     for caculate_j=caculate_1:caculate_lie+caculate_2
%         caculate_image_input=strcat('handwrite',num2str(caculate_j),'.bmp');
%         caculate_image_input_path=[Path caculate_image_input];
%         caculate_image_Input=imread(caculate_image_input_path);
%         caculate_jj=caculate_jj+1;
%         caculate(caculate_i,caculate_jj)=yinshua_num_out(caculate_image_Input);   
%         caculate_count=caculate_count+1;
%     end
%     caculate_1=caculate_count+1;
%     caculate_2=caculate_count;
% end
% %disp(caculate);
% 
% %for i=1:caculate_count%49
% %     if(caculate(i)==14)
% %         caculate_result=strcat('handwrite',num2str(i+1),'.bmp');
% %         caculate_result_path=[Path caculate_result];
% %         caculate_Result=imread(caculate_result_path);
% %         caculate(i+1)=handwrite_num_out(caculate_Result);
% %         caculate_result=strcat('handwrite',num2str(i+2),'.bmp');
% %         caculate_result_path=[Path caculate_result];
% %         caculate_Result=imread(caculate_result_path);
% %         caculate(i+2)=handwrite_num_out(caculate_Result);
% %     end
% % end
% %disp(caculate);
% caculate_iiii=0;
% for caculate_iii=1:bw_hang_num*2 %%将手写体字符存放于矩阵中%%
%     caculate_image2=strcat('bw',num2str(caculate_iii),'.bmp');
%     caculate_image_path2=[Path caculate_image2];
%     caculate_Image2=imread(caculate_image_path2);
%     caculate_lie1=lie_slice(caculate_Image2);
%     for caculate_jjj=1:20
%         if(caculate(caculate_iii,caculate_jjj)==14)
%             caculator=caculate_lie1-caculate_jjj;
%             for caculate_ij=1:caculator
%                 caculate_result=strcat('handwrite',num2str(caculate_ij+caculate_jjj+caculate_iiii),'.bmp');
%                 caculate_result_path=[Path caculate_result];
%                 caculate_Result=imread(caculate_result_path);
%                 caculate(caculate_iii,caculate_jjj+caculate_ij)=handwrite_num_out(caculate_Result);
%             end
%             caculate_iiii=caculate_iiii+caculate_lie1;
%         end
%     end
% end
% disp(caculate);
% abc=zeros(20,10);
% def=zeros(20,10);
% jkl=zeros(20,10);
% jkl1=zeros(20,10);
% jkl2=zeros(20,10);
% result_ghi=zeros(20,10);
% for output_i=1:bw_hang_num*2
%     caculate_image3=strcat('bw',num2str(output_i),'.bmp');
%     caculate_image_path3=[Path caculate_image3];
%     caculate_Image3=imread(caculate_image_path3);
%     caculate_lie2=lie_slice(caculate_Image3);
%     for output_j=1:20
%         if(caculate(output_i,output_j)==10||caculate(output_i,output_j)==11||caculate(output_i,output_j)==12||caculate(output_i,output_j)==13)
%             output_j1=output_j;
%             jkl(output_i,1)=caculate(output_i,output_j);
%             for output_jj=1:output_j1-1
%                 abc(output_i,output_jj)=caculate(output_i,output_jj)*10^((output_j1-1)-output_jj);
%             end
%         end
%         if(caculate(output_i,output_j)==14)
%             output_j2=output_j;
%             for output_jjj=output_j1+1:output_j2-1
%                 def(output_i,output_jjj-output_j1)=caculate(output_i,output_jjj)*10^((output_j2-1)-output_jjj);
%             end
%             for output_jjjj=output_j2+1:caculate_lie2
%                 result_ghi(output_i,output_jjjj-output_j2)=caculate(output_i,output_jjjj)*10^((caculate_lie2)-output_jjjj);
%             end
%         end
%      
%     end
% end
% disp(abc);
% disp(def);
% disp(result_ghi);
% disp(jkl);            
%%%%%%%%%%%加减乘除运算%%%%%%%%%           
% T_image=imread('Ttrue.jpg');          %bw_right1左侧右边界  bw_left左侧左边界  bw_left1右侧左边界  bw_right2右侧右边界
% T_image1=double(T_image);             %bw_a_min上侧边界  bw_a_max下侧边界
% F_image=imread('Ffalse.jpg');
% F_image1=double(F_image);
% jst_chuli=imread('yuanshi.bmp');
% jst_chuli1=double(jst_chuli);
% uio_left=zeros(bw_hang_num,2);
% uio_right=zeros(bw_hang_num,2);
% jst_px0=1;
% jst_px1=1;
% bw_hang_num=hang_slice(Image_bw);
% true_num=0;
% for i=1:bw_hang_num%4
%     while(matrix_bw_1(jst_px0,1)<1&&jst_px0<=Image_bw_m)
%         jst_px0=jst_px0+1;
%     end
%     jst_px1=jst_px0;
%     while(matrix_bw_1(jst_px1,1)>=1&&jst_px1<=Image_bw_m)
%         jst_px1=jst_px1+1;
%     end        
%     for ii=(2*i-1):2*i
%         if(rem(ii,2)==1)
%             if(kongyu>80)
%                 if(jkl(ii,1)==10)
%                     if(sum(abc(ii,:))+sum(def(ii,:))==sum(result_ghi(ii,:)))
%                         jst_chuli(jst_px0:jst_px0+52,bw_sign1:bw_sign1+54,:)=T_image1;
%                         true_num=true_num+1;
%                     else
%                         jst_chuli(jst_px0:jst_px0+52,bw_sign1+1:bw_sign1+1+54,:)=F_image1;
%                         uio_left(i,1)=jst_px0;
%                         uio_left(i,2)=jst_px1;
%                     end
%                 end
%                 if(jkl(ii,1)==11)
%                     if(sum(abc(ii,:))-sum(def(ii,:))==sum(result_ghi(ii,:)))
%                         jst_chuli(jst_px0:jst_px0+52,bw_sign1+1:bw_sign1+1+54,:)=T_image1;
%                         true_num=true_num+1;
%                     else
%                         jst_chuli(jst_px0:jst_px0+52,bw_sign1+1:bw_sign1+1+54,:)=F_image1;
%                         uio_left(i,1)=jst_px0;
%                         uio_left(i,2)=jst_px1;
%                     end
%                 end
%                 if(jkl(ii,1)==12)
%                     if(sum(abc(ii,:))*sum(def(ii,:))==sum(result_ghi(ii,:)))
%                         jst_chuli(jst_px0:jst_px0+52,bw_sign1+1:bw_sign1+1+54,:)=T_image1;
%                         true_num=true_num+1;
%                     else
%                         jst_chuli(jst_px0:jst_px0+52,bw_sign1+1:bw_sign1+1+54,:)=F_image1;
%                         uio_left(i,1)=jst_px0;
%                         uio_left(i,2)=jst_px1;
%                     end
%                 end
%                 if(jkl(ii,1)==13)
%                     if(sum(abc(ii,:))/sum(def(ii,:))==sum(result_ghi(ii,:)))
%                         jst_chuli(jst_px0:jst_px0+52,bw_sign1+1:bw_sign1+1+54,:)=T_image1;
%                         true_num=true_num+1;
%                     else
%                         jst_chuli(jst_px0:jst_px0+52,bw_sign1+1:bw_sign1+1+54,:)=F_image1;
%                         uio_left(i,1)=jst_px0;
%                         uio_left(i,2)=jst_px1;
%                     end
%                 end
%             else
%                 kongyu=min(kongyu,jst_px1-jst_px0);
%                 T_image=imresize(T_image,[kongyu-1,kongyu-1]);
%                 F_image=imresize(F_image,[kongyu-1,kongyu-1]);
%                 T_image1=double(T_image);
%                 F_image1=double(F_image);
%                 if(jkl(ii,1)==10)
%                     if(sum(abc(ii,:))+sum(def(ii,:))==sum(result_ghi(ii,:)))
%                         jst_chuli(jst_px0:jst_px0+kongyu-2,bw_sign1+1:bw_sign1+1+kongyu-2,:)=T_image1;
%                         true_num=true_num+1;
%                     else
%                         jst_chuli(jst_px0:jst_px0+kongyu-2,bw_sign1+1:bw_sign1+1+kongyu-2,:)=F_image1;
%                         uio_left(i,1)=jst_px0;
%                         uio_left(i,2)=jst_px1;
%                     end
%                 end
%                 if(jkl(ii,1)==11)
%                     if(sum(abc(ii,:))-sum(def(ii,:))==sum(result_ghi(ii,:)))
%                         jst_chuli(jst_px0:jst_px0+kongyu-2,bw_sign1+1:bw_sign1+1+kongyu-2,:)=T_image1;
%                         true_num=true_num+1;
%                     else
%                         jst_chuli(jst_px0:jst_px0+kongyu-2,bw_sign1+1:bw_sign1+1+kongyu-2,:)=F_image1;
%                         uio_left(i,1)=jst_px0;
%                         uio_left(i,2)=jst_px1;
%                     end
%                 end
%                 if(jkl(ii,1)==12)
%                     if(sum(abc(ii,:))*sum(def(ii,:))==sum(result_ghi(ii,:)))
%                         jst_chuli(jst_px0:jst_px0+kongyu-2,bw_sign1+1:bw_sign1+1+kongyu-2,:)=T_image1;
%                         true_num=true_num+1;
%                     else
%                         jst_chuli(jst_px0:jst_px0+kongyu-2,bw_sign1+1:bw_sign1+1+kongyu-2,:)=F_image1;
%                         uio_left(i,1)=jst_px0;
%                         uio_left(i,2)=jst_px1;
%                     end
%                 end
%                 if(jkl(ii,1)==13)
%                     if(sum(abc(ii,:))/sum(def(ii,:))==sum(result_ghi(ii,:)))
%                         jst_chuli(jst_px0:jst_px0+kongyu-2,bw_sign1+1:bw_sign1+1+kongyu-2,:)=T_image1;
%                         true_num=true_num+1;
%                     else
%                         jst_chuli(jst_px0:jst_px0+kongyu-2,bw_sign1+1:bw_sign1+1+kongyu-2,:)=F_image1;
%                         uio_left(i,1)=jst_px0;
%                         uio_left(i,2)=jst_px1;
%                     end
%                 end
%             end
%         else
%             if(kongyu>80)
%                 if(jkl(ii,1)==10)
%                     if(sum(abc(ii,:))+sum(def(ii,:))==sum(result_ghi(ii,:)))
%                         jst_chuli(jst_px0:jst_px0+52,bw_b_max+1:bw_b_max+1+54,:)=T_image1;
%                         true_num=true_num+1;
%                     else
%                         jst_chuli(jst_px0:jst_px0+52,bw_b_max+1:bw_b_max+1+54,:)=F_image1;
%                         uio_right(i,1)=jst_px0;
%                         uio_right(i,2)=jst_px1;
%                     end
%                 end
%                 if(jkl(ii,1)==11)
%                     if(sum(abc(ii,:))-sum(def(ii,:))==sum(result_ghi(ii,:)))
%                         jst_chuli(jst_px0:jst_px0+52,bw_b_max+1:bw_b_max+1+54,:)=T_image1;
%                         true_num=true_num+1;
%                     else
%                         jst_chuli(jst_px0:jst_px0+52,bw_b_max+1:bw_b_max+1+54,:)=F_image1;
%                         uio_right(i,1)=jst_px0;
%                         uio_right(i,2)=jst_px1;
%                     end
%                 end
%                 if(jkl(ii,1)==12)
%                     if(sum(abc(ii,:))*sum(def(ii,:))==sum(result_ghi(ii,:)))
%                         jst_chuli(jst_px0:jst_px0+52,bw_b_max+1:bw_b_max+1+54,:)=T_image1;
%                         true_num=true_num+1;
%                     else
%                         jst_chuli(jst_px0:jst_px0+52,bw_b_max+1:bw_b_max+1+54,:)=F_image1;
%                         uio_right(i,1)=jst_px0;
%                         uio_right(i,2)=jst_px1;
%                     end
%                 end
%                 if(jkl(ii,1)==13)
%                     if(sum(abc(ii,:))/sum(def(ii,:))==sum(result_ghi(ii,:)))
%                         jst_chuli(jst_px0:jst_px0+52,bw_b_max+1:bw_b_max+1+54,:)=T_image1;
%                         true_num=true_num+1;
%                     else
%                         jst_chuli(jst_px0:jst_px0+52,bw_b_max+1:bw_b_max+1+54,:)=F_image1;
%                         uio_right(i,1)=jst_px0;
%                         uio_right(i,2)=jst_px1;
%                     end
%                 end
%             else
%                 kongyu=min(kongyu,jst_px1-jst_px0);
%                 T_image=imresize(T_image,[kongyu-1,kongyu-1]);
%                 F_image=imresize(F_image,[kongyu-1,kongyu-1]);
%                 T_image1=double(T_image);
%                 F_image1=double(F_image);
%                 if(jkl(ii,1)==10)
%                     if(sum(abc(ii,:))+sum(def(ii,:))==sum(result_ghi(ii,:)))
%                         jst_chuli(jst_px0:jst_px0+kongyu-2,bw_b_max+1:bw_b_max+1+kongyu-2,:)=T_image1;
%                         true_num=true_num+1;
%                     else
%                         jst_chuli(jst_px0:jst_px0+kongyu-2,bw_b_max+1:bw_b_max+1+kongyu-2,:)=F_image1;
%                         uio_right(i,1)=jst_px0;
%                         uio_right(i,2)=jst_px1;
%                     end
%                 end
%                 if(jkl(ii,1)==11)
%                     if(sum(abc(ii,:))-sum(def(ii,:))==sum(result_ghi(ii,:)))
%                         jst_chuli(jst_px0:jst_px0+kongyu-2,bw_b_max+1:bw_b_max+1+kongyu-2,:)=T_image1;
%                         true_num=true_num+1;
%                     else
%                         jst_chuli(jst_px0:jst_px0+kongyu-2,bw_b_max+1:bw_b_max+1+kongyu-2,:)=F_image1;
%                         uio_right(i,1)=jst_px0;
%                         uio_right(i,2)=jst_px1;
%                     end
%                 end
%                 if(jkl(ii,1)==12)
%                     if(sum(abc(ii,:))*sum(def(ii,:))==sum(result_ghi(ii,:)))
%                         jst_chuli(jst_px0:jst_px0+kongyu-2,bw_b_max+1:bw_b_max+1+kongyu-2,:)=T_image1;
%                         true_num=true_num+1;
%                     else
%                         jst_chuli(jst_px0:jst_px0+kongyu-2,bw_b_max+1:bw_b_max+1+kongyu-2,:)=F_image1;
%                         uio_right(i,1)=jst_px0;
%                         uio_right(i,2)=jst_px1;
%                     end
%                 end
%                 if(jkl(ii,1)==13)
%                     if(sum(abc(ii,:))/sum(def(ii,:))==sum(result_ghi(ii,:)))
%                         jst_chuli(jst_px0:jst_px0+kongyu-2,bw_b_max+1:bw_b_max+1+kongyu-2,:)=T_image1;
%                         true_num=true_num+1;
%                     else
%                         jst_chuli(jst_px0:jst_px0+kongyu-2,bw_b_max+1:bw_b_max+1+kongyu-2,:)=F_image1;
%                         uio_right(i,1)=jst_px0;
%                         uio_right(i,2)=jst_px1;
%                     end
%                 end
%             end
%         end
%     end
%     jst_px0=jst_px1;
% end
%disp(true_num);
                 
                     









clear,clc,close all;
I=imread('kousuanti_demo10.jpg');
imshow(I);title('Original image');
gray=rgb2gray(I);figure,imshow(gray);title('Grayscale image');
bw=edge(gray,'canny');
figure,imshow(bw);
theta=1:180;
[R,xp]=radon(bw,theta);
[I0,J]=find(R>=max(max(R)));%J记录了倾斜角
qingxiejiao=90-J;
I1=imrotate(I,qingxiejiao,'bilinear','crop');
figure,imshow(I1);title('correct image');


I=imread('kousuanti_demo11.jpg');
I1=diedai_yuzhi(I);
imshow(I1)












Path='D:\Matlab2016a\Matlab_R2016a_win64\workspace\tuxiangyuchuli\'
clear all;clc;close all;
[fn pn fi]=uigetfile('*.*','choose a picture');
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
    imshow(gw8);
    %imwrite(gw8,strcat(Path,'fengeimg',num2str(i),'.bmp'),'bmp');
end
figure(2),imshow(f)
hold on
for k=1:num
    [r,c]=find(L==k);
    rbar=mean(r);
    cbar=mean(c);
    plot(cbar,rbar,'Marker','o','MarkerEdgeColor','k','MarkerFaceColor','k','MarkerSize',10);
    plot(cbar,rbar,'Marker','*','MarkerEdgecolor','w');
end







I=imread('handwrite11.bmp');
I1=imresize(I,[28,28]);
imshow(I1);
imwrite(I1,'handwrite11.bmp');








I=imread('fenge_test.jpg');
I=diedai_yuzhi(I);
I=~I;
I=bwareaopen(I,50);
imshow(I)



I=imread('handwrite.bmp');
I=restrict(I);
imwrite(I,'handwrite.bmp','bmp');

H=imread('bw2.bmp');
[a1,b1,c1]=size(H);        
disp(a1);%45                    %
disp(b1);%381                   %
disp(c1);%1                     %
H3=double(H);
xx2=zeros(1,b1);
for j1=1:b1
    for i1=1:a1
        if(H3(i1,j1,1)==1)
            xx2(1,j1)=xx2(1,j1)+1;
        end
    end
end
figure,plot(1:b1,xx2);
saveas(gcf,'first.bmp');




I=imread('wufashibie.jpg');
I=diedai_yuzhi(I);
getword(I);
