%%%%%%%%%%%%用于输出印刷字体识别结果%%%%%%%%%%%
function y=yinshua_num_out(I)
TemplatePath='D:\Matlab2016a\Matlab_R2016a_win64\workspace\tuxiangyuchuli\';%%上传模板数字%%%%%%%%%
FileFormat='.bmp';
TemplateImage=zeros(28,28,18);
Image_num=1;
while(Image_num>=1&&Image_num<=18)%%%建立模板库%%%
    str=num2str(Image_num-1);
    str_num=strcat('moban_yangli',str);
    ImagePath=[TemplatePath,str_num,FileFormat];
    TempImage=imread(ImagePath);
    TemplateImage(:,:,Image_num)=TempImage;
    clear ImagePath 
    clear str_num
    clear str
    clear TempImage
    Image_num=Image_num+1;
end
U=length(find(I~=0));
for num2=1:18
        T=length(find(TemplateImage(:,:,num2)~=0));
        tempV=I&TemplateImage(:,:,num2);
        V=length(find(tempV~=0));
        tempW=xor(tempV,TemplateImage(:,:,num2));
        W=length(find(tempW~=0));
        tempX=xor(tempV,I);
        X=length(find(tempX~=0));
        TUV=(T+U+V)/3;
        tempsum=sqrt(((T-TUV)^2+(U-TUV)^2+(V-TUV)^2)/2);  %%模板匹配判别函数&&&&&
        Y(num2)=V/(W/T*X/U*tempsum);                      %%*********%%%%%%%%%%%
end
[MAX,indexMax]=max(Y,[],2);
y=indexMax-1;
end

