function varargout = untitled(varargin)
% UNTITLED MATLAB code for untitled.fig
%      UNTITLED, by itself, creates a new UNTITLED or raises the existing
%      singleton*.
%
%      H = UNTITLED returns the handle to a new UNTITLED or the handle to
%      the existing singleton*.
%
%      UNTITLED('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in UNTITLED.M with the given input arguments.
%
%      UNTITLED('Property','Value',...) creates a new UNTITLED or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before untitled_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to untitled_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help untitled

% Last Modified by GUIDE v2.5 07-May-2019 12:12:39

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @untitled_OpeningFcn, ...
                   'gui_OutputFcn',  @untitled_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before untitled is made visible.
function untitled_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to untitled (see VARARGIN)

% Choose default command line output for untitled
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes untitled wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = untitled_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.


%*************Step 1 选取图像***************
function pushbutton1_Callback(~, ~, handles)
[filename, pathname]=uigetfile({'*.bmp';'*.jpg';'*.png'},'read an image file');%选图像
   if isequal(filename,0)||isequal(pathname,0)
       errordlg('没有选中文件','出错');
       return;
   else 
       file=[pathname,filename];
   end
imagen=imread(file);
set(handles.axes6,'visible','off');
axes(handles.axes6);       %输出图像到控件
imshow(imagen);
imwrite(imagen,'yuanshi.bmp','bmp');
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in pushbutton2.


%**********Step 2 图像预处理（二值化、滤波、除噪、锐化等）*********
function pushbutton2_Callback(~, ~, handles)
img=imread('yuanshi.bmp');
[yuanshi_hang,yuanshi_lie]=size(img);
black_num=length(find(img==0));
white_num=length(find(img==1));
if (black_num+white_num==yuanshi_hang*yuanshi_lie)
    axes(handles.axes8);
    hg=get(gca,'children');
    delete(hg);
    imwrite(img,'YS.bmp','bmp');
    set(handles.axes8,'visible','off');
    axes(handles.axes8);
    img1=(img~=1);
    imshow(img1);
    imwrite(img1,'YS.bmp','bmp');
else
    axes(handles.axes8);
    hg=get(gca,'children');
    delete(hg);
    ff=fspecial('average',[3,3]);
    img=imfilter(img,ff);
    A=diedai_yuzhi(img);
    A2=(A~=1);
    A2=bwareaopen(A2,10);
    imwrite(A2,'yuanshi_demo.bmp','bmp');
    set(handles.axes8,'visible','off');
    axes(handles.axes8);
    imshow(A2);
    imwrite(A2,'YS.bmp','bmp');
end

%title('二值图像','color','b');


% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton4.


%**********Step 3 去除大多数空白多余的地方
function pushbutton4_Callback(hObject, eventdata, handles)
A=imread('yuanshi_demo.bmp');
[i,j]=find(A==1);%找到像素值为0的点
imax=max(i);
imin=min(i);
jmax=max(j);
jmin=min(j);
A1=A(imin:imax,jmin:jmax);
axes(handles.axes8);
imshow(A1);
imwrite(A1,'YS1.bmp');

% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton6.


%**********Step 4  图像分割（行分割、列分割）
function pushbutton6_Callback(hObject, eventdata, handles)
Path='D:\Matlab2016a\Matlab_R2016a_win64\workspace\tuxiangyuchuli\'
%I=imread('yuanshi.bmp');
%I1=rgb2gray(I);
%Imax=double(max(max(I1)));%返回最大值
%Imin=double(min(min(I1)));%返回最小值
%T=round(Imax-(Imax-Imin)/2);%确定阀值
I=imread('YS.bmp');
% I1=rgb2gray(I);
% level=graythresh(I1);%二值化阈值
% I2=im2bw(I1,level);%二值化

[x1,y1,~]=size(I);
%disp(x1);%显示图像像素值 377行
%disp(y1);%381列
%disp(z1);%1
I3=double(I);
%disp(I3);
xx1=zeros(x1,1);     
for ii=1:x1
    for jj=1:y1
        if(I3(ii,jj,1)==1)
            xx1(ii,1)=xx1(ii,1)+1;    
        end
    end
end
figure('Name','行投影曲线'),plot(1:x1,xx1);
%disp(xx1);
saveas(gcf,'quxian.bmp');
px0=1;
px1=1;
row_max=10;
column_max=10;
hang_num=hang_slice(I); %调用行计算函数
disp(hang_num);
%disp(hang_num);%4行
%行分割
for i=1:hang_num
    while(xx1(px0,1)<1&&px0<y1)
    px0=px0+1;
    end
    px1=px0;
    while(xx1(px1,1)>=1&&px1<y1||px1-px0<10)
    px1=px1+1;
    end
    Z=I(px0:px1,:,:);
    switch strcat('Z',num2str(i))
        case 'Z1'
        IMG1=Z;
        case 'Z2'
        IMG2=Z;
        case 'Z3'
        IMG3=Z;
        case 'Z4'
        IMG4=Z;
    end
    
    figure;
   %subplot(4,1,i);
    imshow(Z);
%     if i==1
%         imwrite(Z,'1.bmp','bmp');
%     end
%     if i==2
%         imwrite(Z,'2.bmp','bmp');
%     end
%     if i==3
%         imwrite(Z,'3.bmp','bmp');
%     end
%     if i==4
%         imwrite(Z,'4.bmp','bmp');
%     end
   
    imwrite(Z,strcat(Path,num2str(i),'.bmp'),'bmp');
    px0=px1;
end
global iiii;
iiii=0;
Nnum=hang_slice(I);
for Image_name=1:1  %
    Image_namestr=strcat(num2str(Image_name),'.bmp');
    Image_Path=[Path Image_namestr];
    Image_read=imread(Image_Path);
    getword(Image_read);
end
% %%%%%%%%%对第一行进行列分割%%%%%%%%%%逐行分割
% H=imread('1.bmp');
% % H1=getword(H);
% % H1=getword(H);
% H1=rgb2gray(H);                %当用saveas保存时加
% level1=graythresh(H1);         %
% H2=im2bw(H1,level1);           %
% [a1,b1,c1]=size(H);        
% disp(a1);%45                    %
% disp(b1);%381                   %
% disp(c1);%1                     %
% H3=double(H);
% xx2=zeros(1,b1);
% for j1=1:b1
%     for i1=1:a1
%         if(H3(i1,j1,1)==1)
%             xx2(1,j1)=xx2(1,j1)+1;
%         end
%     end
% end
% figure,plot(1:b1,xx2);
% saveas(gcf,'first.bmp');
% px2=1;
% px3=1;
% CharNum1=lie_slice(H);
% disp(CharNum1);
% for ii=1:CharNum1
%     while(xx2(1,px2)<1&&px2<b1)
%     px2=px2+1;
%     end
%     px3=px2;
%     while(xx2(1,px3)>=1&&px3<b1)
%     px3=px3+1;
%     end
%     ZZ=H(:,px2:px3,:);
%      switch strcat('ZZ',num2str(i))
%          case 'ZZ1'
%          IMG5=ZZ;
%          case 'ZZ2'
%          IMG6=ZZ;
%          case 'ZZ3'
%          IMG7=ZZ;
%          case 'ZZ4'
%          IMG8=ZZ;
%          case 'ZZ5'
%          IMG9=ZZ;
%          case 'ZZ6'
%          IMG10=ZZ;
%          case 'ZZ7'
%          IMG11=ZZ;
%          case 'ZZ8'
%          IMG12=ZZ;
%      end
%     %set (gcf,'Position',[400,400,200,200], 'color','w')
%      figure;
%     %subplot(1,8,ii);
%      imshow(ZZ);
%      px2=px3;
% end
%%%%%%%%%%对第二行进行列分割%%%%%%%%%%
% J=imread('2.bmp');
% J1=getword(J);
%J1=rgb2gray(J);                %当用saveas保存时加
%level2=graythresh(J1);         %
%J2=im2bw(J1,level2);           %
% [a2,b2,c2]=size(J);
% disp(a2);%
% disp(b2);%
% disp(c2);%
% J3=double(J);
% xx3=zeros(1,b2);
% for j2=1:b2
%     for i2=1:a2
%         if(J3(i2,j2,1)==0)
%             xx3(1,j2)=xx3(1,j2)+1;
%         end
%     end
% end
% figure,plot(1:b2,xx3);
% saveas(gcf,'second.bmp');
% px4=1;
% px5=1;
% CharNum2=lie_slice(J);
% disp(CharNum2);
% for iii=1:CharNum2
%     while(xx3(1,px4)<1&&px4<b2)
%     px4=px4+1;
%     end
%     px5=px4;
%     while(xx3(1,px5)>=1&&px5<b2)
%     px5=px5+1;
%     end
%     ZZZ=J(:,px4:px5,:);
%      switch strcat('ZZZ',num2str(i))
%          case 'ZZZ1'
%          IMG13=ZZZ;
%          case 'ZZZ2'
%          IMG14=ZZZ;
%          case 'ZZZ3'
%          IMG15=ZZZ;
%          case 'ZZZ4'
%          IMG16=ZZZ;
%          case 'ZZZ5'
%          IMG17=ZZZ;
%          case 'ZZZ6'
%          IMG18=ZZZ;
%          case 'ZZZ7'
%          IMG19=ZZZ;
%          case 'ZZZ8'
%          IMG20=ZZZ;
%          case 'ZZZ9'
%          IMG21=ZZZ;
%      end
%      figure;
%     %subplot(1,9,iii);
%      imshow(ZZZ);
%      px4=px5;
% end
%%%%%%%%%%对第三行进行列分割%%%%%%%%%%
% K=imread('3.bmp');
% K1=getword(K);
%K1=rgb2gray(K);                   %当用saveas保存时加
%level3=graythresh(K1);            %
%K2=im2bw(K1,level3);              %
% [a3,b3,c3]=size(K);
% disp(a3);%
% disp(b3);%
% disp(c3);%
% K3=double(K);
% xx4=zeros(1,b3);
% for j3=1:b3
%     for i3=1:a3
%         if(K3(i3,j3,1)==0)
%             xx4(1,j3)=xx4(1,j3)+1;
%         end
%     end
% end
% figure,plot(1:b3,xx4);
% saveas(gcf,'third.bmp');
% px6=1;
% px7=1;
% CharNum3=lie_slice(K);
% disp(CharNum3);
% for iiii=1:CharNum3
%     while(xx4(1,px6)<1&&px6<b3)
%     px6=px6+1;
%     end
%     px7=px6;
%     while(xx4(1,px7)>=1&&px7<b3)
%     px7=px7+1;
%     end
%     ZZZZ=K(:,px6:px7,:);
%      switch strcat('ZZZZ',num2str(i))
%          case 'ZZZZ1'
%          IMG22=ZZZZ;
%          case 'ZZZZ2'
%          IMG23=ZZZZ;
%          case 'ZZZZ3'
%          IMG24=ZZZZ;
%          case 'ZZZZ4'
%          IMG25=ZZZZ;
%          case 'ZZZZ5'
%          IMG26=ZZZZ;
%          case 'ZZZZ6'
%          IMG27=ZZZZ;
%          case 'ZZZZ7'
%          IMG28=ZZZZ;
%          case 'ZZZZ8'
%          IMG29=ZZZZ;
%          case 'ZZZZ9'
%          IMG30=ZZZZ;
%          case 'ZZZZ10'
%          IMG31=ZZZZ;
%      end
%      figure;
%     %subplot(1,10,iiii);
%      imshow(ZZZZ);
%      px6=px7;
% end     
%%%%%%%%%%对第四行进行列分割%%%%%%%%%%
% L=imread('4.bmp');
% L1=getword(L);
%L1=rgb2gray(L);                    %当用saveas保存时加
%level4=graythresh(L1);             %
%L2=im2bw(L1,level4);               %
% [a4,b4,c4]=size(L);
% disp(a4);%
% disp(b4);%
% disp(c4);%
% L3=double(L);
% xx5=zeros(1,b4);
% for j4=1:b4
%     for i4=1:a4
%         if(L3(i4,j4,1)==0)
%             xx5(1,j4)=xx5(1,j4)+1;
%         end
%     end
% end
% figure,plot(1:b4,xx5);
% saveas(gcf,'fourth.bmp');
% px8=1;
% px9=1;
% CharNum4=lie_slice(L);
% disp(CharNum4);
% for iiiii=1:CharNum4
%     while(xx5(1,px8)<1&&px8<b4)
%     px8=px8+1;
%     end
%     px9=px8;
%     while(xx5(1,px9)>=1&&px9<b4)
%     px9=px9+1;
%     end
%     ZZZZZ=L(:,px8:px9,:);
%      switch strcat('ZZZZZ',num2str(i))
%          case 'ZZZZZ1'
%          IMG32=ZZZZZ;
%          case 'ZZZZZ2'
%          IMG33=ZZZZZ;
%          case 'ZZZZZ3'
%          IMG34=ZZZZZ;
%          case 'ZZZZZ4'
%          IMG35=ZZZZZ;
%          case 'ZZZZZ5'
%          IMG36=ZZZZZ;
%          case 'ZZZZZ6'
%          IMG37=ZZZZZ;
%          case 'ZZZZZ7'
%          IMG38=ZZZZZ;
%          case 'ZZZZZ8'
%          IMG39=ZZZZZ;
%          case 'ZZZZZ9'
%          IMG40=ZZZZZ;
%          case 'ZZZZZ10'
%          IMG41=ZZZZZ;
%      end
%      figure;
%     %subplot(1,10,iiiii);
%      imshow(ZZZZZ);
%      px8=px9;
% end     




% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton8.
%%%%%%%%%%%模板匹配算法%%%%%%%%%%%%%
function pushbutton8_Callback(hObject, eventdata, handles)
TemplatePath='D:\Matlab2016a\Matlab_R2016a_win64\workspace\tuxiangyuchuli\'
standard=imread('moban_yangli1.jpg'); %印刷体字体及处理
level8=graythresh(standard);
standard1=im2bw(standard,level8);
standard3=(standard1~=1);
%figure,imshow(standard3);
standard2=double(standard3);
[hang,lie,~]=size(standard2);
%disp(hang); %92
%disp(lie);  %550
%disp(p);    %1
matrix=zeros(1,lie);
for j=1:lie
    for i=1:hang
        if(standard2(i,j,1)==1)
            matrix(1,j)=matrix(1,j)+1;
        end
    end
end
figure,plot(1:lie,matrix);
matrix_1=1;
matrix_2=1;
char_num=lie_slice(standard3);
%disp(char_num);
for num=0:char_num-1
    while(matrix(1,matrix_1)<1&&matrix_1<lie)
        matrix_1=matrix_1+1;
    end
    matrix_2=matrix_1;
    while(matrix(1,matrix_2)>=1&&matrix_2<lie)
        matrix_2=matrix_2+1;
    end
    biaozhun=standard3(:,matrix_1:matrix_2,:);
    biaozhun1=restrict(biaozhun);
    [biaozhun_m,biaozhun_n]=size(biaozhun1);
    if(biaozhun_m/biaozhun_n>2&&biaozhun_m/biaozhun_n<=3)
        biaozhun2=imresize(biaozhun1,[20 14]);
        white1=zeros(20,3);
        white2=zeros(20,3);
        biaozhun3=[white1,biaozhun2,white2];
        bz4=zeros(4,4);
        bz5=zeros(20,4);
        bz6=zeros(4,20);
        bz7=[bz4 bz6 bz4;bz5 biaozhun3 bz5;bz4 bz6 bz4];
    elseif(biaozhun_m/biaozhun_n>3)
        biaozhun2=imresize(biaozhun1,[20 8]);
        white1=zeros(20,6);
        white2=zeros(20,6);
        biaozhun3=[white1,biaozhun2,white2];
        bz4=zeros(4,4);
        bz5=zeros(20,4);
        bz6=zeros(4,20);
        bz7=[bz4 bz6 bz4;bz5 biaozhun3 bz5;bz4 bz6 bz4];
    elseif(biaozhun_n/biaozhun_m>2&&biaozhun_n/biaozhun_m<=3)
        biaozhun2=imresize(biaozhun1,[14 20]);
        white1=zeros(3,20);
        white2=zeros(3,20);
        biaozhun3=[white1;biaozhun2;white2];
        bz4=zeros(4,4);
        bz5=zeros(20,4);
        bz6=zeros(4,20);
        bz7=[bz4 bz6 bz4;bz5 biaozhun3 bz5;bz4 bz6 bz4];
    elseif(biaozhun_n/biaozhun_m>3)
        biaozhun2=imresize(biaozhun1,[8 20]);
        white1=zeros(6,20);
        white2=zeros(6,20);
        biaozhun3=[white1;biaozhun2;white2];
        bz4=zeros(4,4);
        bz5=zeros(20,4);
        bz6=zeros(4,20);
        bz7=[bz4 bz6 bz4;bz5 biaozhun3 bz5;bz4 bz6 bz4];
    elseif(biaozhun_m<=14&&biaozhun_n<=14)
        biaozhun2=imresize(biaozhun1,[5 5]);
        white1=zeros(5,3);
        white2=zeros(3,5);
        white3=zeros(3,3);
        white4=zeros(20,8);
        white5=zeros(20,20);
        white6=zeros(5,20);
        white7=zeros(3,20);
        bz7=[white4,white5;white1,biaozhun2,white6;white3,white2,white7];
    else
        biaozhun3=imresize(biaozhun1,[20 20]);
        bz4=zeros(4,4);
        bz5=zeros(20,4);
        bz6=zeros(4,20);
        bz7=[bz4 bz6 bz4;bz5 biaozhun3 bz5;bz4 bz6 bz4];
    end
    %biaozhun2=imresize(biaozhun1,[40 25]);
    %biaozhun4=medfilt2(biaozhun3,[1,1]);
%     w=fspecial('gaussian',[5,5],1);        %%%%高斯滤波
%     biaozhun4=imfilter(bz7,w,'replicate');  
%     subplot(2,9,num+1);
   figure, imshow(bz7);
%     if num==0                  %%%%逐个保存
%         imwrite(biaozhun2,'moban0.bmp','bmp');
%     end
%     if num==1
%         imwrite(biaozhun2,'moban1.bmp','bmp');
%     end
%     if num==2
%         imwrite(biaozhun2,'moban2.bmp','bmp');
%     end
%     if num==3
%         imwrite(biaozhun2,'moban3.bmp','bmp');
%     end
%     if num==4
%         imwrite(biaozhun2,'moban4.bmp','bmp');
%     end
%     if num==5
%         imwrite(biaozhun2,'moban5.bmp','bmp');
%     end
%     if num==6
%         imwrite(biaozhun2,'moban6.bmp','bmp');
%     end
%     if num==7
%         imwrite(biaozhun2,'moban7.bmp','bmp');
%     end
%     if num==8
%         imwrite(biaozhun2,'moban8.bmp','bmp');
%     end
%     if num==9
%         imwrite(biaozhun2,'moban9.bmp','bmp');
%     end
     imwrite(bz7,strcat(TemplatePath,'moban_abc',num2str(num),'.bmp'),'bmp');
    matrix_1=matrix_2;
end
TemplatePath='D:\Matlab2016a\Matlab_R2016a_win64\workspace\tuxiangyuchuli\';%%上传模板数字%%%%%%%%%
FileFormat='.bmp';
TemplateImage=zeros(28,28,char_num);
Image_num=1;
while(Image_num>=1&&Image_num<=char_num)%%%建立模板库%%%
    str=num2str(Image_num-1);
    str_num=strcat('moban_demo',str);
    ImagePath=[TemplatePath,str_num,FileFormat];
    TempImage=imread(ImagePath);
    TemplateImage(:,:,Image_num)=TempImage;
    clear ImagePath 
    clear str_num
    clear str
    clear TempImage
    Image_num=Image_num+1;
end
%disp(TemplateImage);
yinshua=imread('fuhao_all.jpg');
level_yinshua=graythresh(yinshua);
yinshua1=im2bw(yinshua,level_yinshua);
yinshua3=(yinshua1~=1);
%figure,imshow(yinshua3);
yinshua2=double(yinshua3);
[yinshua_hang,yinshua_lie,~]=size(yinshua1);
lie_num=lie_slice(yinshua3);
%disp(lie_num);%6
matrix_yinshua=zeros(1,yinshua_lie);
for yinshua_j=1:yinshua_lie
     for yinshua_i=1:yinshua_hang
         if(yinshua2(yinshua_i,yinshua_j,1)==1)
         matrix_yinshua(1,yinshua_j)=matrix_yinshua(1,yinshua_j)+1;
         end
     end
 end
figure,plot(1:yinshua_lie,matrix_yinshua);
yinshua_px0=1;
yinshua_px1=1;
for yinshua_num=1:lie_num
     while(matrix_yinshua(1,yinshua_px0)<1&&yinshua_px0<yinshua_lie)
         yinshua_px0=yinshua_px0+1;
     end
     yinshua_px1=yinshua_px0;
     while(matrix_yinshua(1,yinshua_px1)>=1&&yinshua_px1<yinshua_lie)
         yinshua_px1=yinshua_px1+1;
     end
     YinShua=yinshua3(:,yinshua_px0:yinshua_px1,:);
     YinShua1=restrict(YinShua);
     %figure,imshow(YinShua);
     %YinShua3=medfilt2(YinShua1);
%      YinShua2=imresize(YinShua1,[28 28],'nearest');
     [ys_m,ys_n]=size(YinShua1);
     if(ys_m/ys_n>2&&ys_m/ys_n<=3)
         ys_1=imresize(YinShua1,[20 14]);
         ys_2=zeros(20,3);
         ys_3=zeros(20,3);
         ys_4=[ys_2 ys_1 ys_3];
         ys_5=zeros(4,4);
         ys_6=zeros(20,4);
         ys_7=zeros(4,20);
         ys_8=[ys_5 ys_7 ys_5;ys_6 ys_4 ys_6;ys_5 ys_7 ys_5];
     elseif(ys_m/ys_n>3)
         ys_1=imresize(YinShua1,[20,8]);
         ys_2=zeros(20,6);
         ys_3=zeros(20,6);
         ys_4=[ys_2 ys_1 ys_3];
         ys_5=zeros(4,4);
         ys_6=zeros(20,4);
         ys_7=zeros(4,20);
         ys_8=[ys_5 ys_7 ys_5;ys_6 ys_4 ys_6;ys_5 ys_7 ys_5];
     elseif(ys_n/ys_m>2&&ys_n/ys_m<=3)
         ys_1=imresize(YinShua1,[14,20]);
         ys_2=zeros(3,20);
         ys_3=zeros(3,20);
         ys_4=[ys_2;ys_1;ys_3];
         ys_5=zeros(4,4);
         ys_6=zeros(20,4);
         ys_7=zeros(4,20);
         ys_8=[ys_5 ys_7 ys_5;ys_6 ys_4 ys_6;ys_5 ys_7 ys_5];
     elseif(ys_n/ys_m>3)
         ys_1=imresize(YinShua1,[8,20]);
         ys_2=zeros(6,20);
         ys_3=zeros(6,20);
         ys_4=[ys_2;ys_1;ys_3];
         ys_5=zeros(4,4);
         ys_6=zeros(20,4);
         ys_7=zeros(4,20);
         ys_8=[ys_5 ys_7 ys_5;ys_6 ys_4 ys_6;ys_5 ys_7 ys_5];
     elseif(ys_n<=10&&ys_m<=10)
         ys_1=imresize(YinShua1,[5,5]);
         ys_2=zeros(5,3);
         ys_3=zeros(3,5);
         ys_4=zeros(3,3);
         ys_5=zeros(20,8);
         ys_6=zeros(20,20);
         ys_7=zeros(5,20);
         ys_70=zeros(3,20);
         ys_8=[ys_5,ys_6;ys_2,ys_1,ys_7;ys_4,ys_3,ys_70];
     else
         ys_4=imresize(YinShua1,[20,20]);
         ys_5=zeros(4,4);
         ys_6=zeros(20,4);
         ys_7=zeros(4,20);
         ys_8=[ys_5 ys_7 ys_5;ys_6 ys_4 ys_6;ys_5 ys_7 ys_5];
     end
     figure,imshow(ys_8);
%      if yinshua_num==1          %%%%%逐个保存
%          imwrite(YinShua2,'yinshua1.bmp','bmp');
%      end
%      if yinshua_num==2
%          imwrite(YinShua2,'yinshua2.bmp','bmp');
%      end
%      if yinshua_num==3
%          imwrite(YinShua2,'yinshua3.bmp','bmp');
%      end
%      if yinshua_num==4
%          imwrite(YinShua2,'yinshua4.bmp','bmp');
%      end
%      if yinshua_num==5
%          imwrite(YinShua2,'yinshua5.bmp','bmp');
%      end
%      if yinshua_num==6
%          imwrite(YinShua2,'yinshua6.bmp','bmp');
%      end
%      if yinshua_num==7
%          imwrite(YinShua2,'yinshua7.bmp','bmp');
%      end
     imwrite(ys_8,strcat(TemplatePath,'yinshua',num2str(yinshua_num),'.bmp'),'bmp');
     yinshua_px0=yinshua_px1;
end
Test_image=zeros(28,28,lie_num);
%disp(Test_image);
Test_num=1;
while(Test_num>=1&&Test_num<=lie_num)  %%%%上传待识别的印刷体图像%%%%%
    Test_str=num2str(Test_num);
    Test_str1=strcat('yinshua',Test_str);
    TestPath=[TemplatePath Test_str1 FileFormat];
    TestImage=imread(TestPath);
    Test_image(:,:,Test_num)=TestImage;
    Test_num=Test_num+1;
end
%disp(Test_image(:,:,1));
Y=zeros(1,10);
save_figure=zeros(100,1);
for num1=1:lie_num   %6             %%%%%%模板匹配%%%%%%%%%
    U=length(find(Test_image(:,:,num1)~=0));
    for num2=1:char_num
        T=length(find(TemplateImage(:,:,num2)~=0));
        tempV=Test_image(:,:,num1)&TemplateImage(:,:,num2);
        V=length(find(tempV~=0));
        tempW=xor(tempV,TemplateImage(:,:,num2));
        W=length(find(tempW~=0));
        tempX=xor(tempV,Test_image(:,:,num1));
        X=length(find(tempX~=0));
        TUV=(T+U+V)/3;
        tempsum=sqrt(((T-TUV)^2+(U-TUV)^2+(V-TUV)^2)/2);  %%模板匹配判别函数&&&&&
        Y(num2)=V/(W/T*X/U*tempsum);                      %%*********%%%%%%%%%%%
    end
    [MAX,indexMax]=max(Y,[],2);
    %disp(MAX);
    save_figure(num1,1)=indexMax-1;
    string=num2str(indexMax-1);    %disp(string);
    final_str=strcat('moban_demo',string);
    StrPath=[TemplatePath final_str FileFormat];
    final_image=imread(StrPath);
    figure('name','匹配结果','color','c','position',[200,200,300,300]),imshow(final_image);
    %set(gcf,'position',[200,300,500,500]);
    clear StrPath indexMax;   
end
disp(save_figure);
%%%%%%神经网络%%%%%%%
train_x_file=char('train-images.idx3-ubyte');
test_x_file=char('t10k-images.idx3-ubyte');
train_y_file=char('train-labels.idx1-ubyte');
test_y_file=char('t10k-labels.idx1-ubyte');
train_x=decodefile(train_x_file,'image');
test_x=decodefile(test_x_file,'image');
train_y=decodefile(train_y_file,'label');
test_y=decodefile(test_y_file,'label');
save('mnist_uint8.mat','train_x','train_y','test_x','test_y');
for train_num=1:47040000
    if(train_x(train_num,1)>128);
        train_x(train_num,1)=255;
    else
        train_x(train_num,1)=0;
    end
end
for test_num=1:7840000
    if(test_x(test_num,1)>128)
        test_x(test_num,1)=255;
    else
        test_x(test_num,1)=0;
    end
end
train_x_matrix=reshape(train_x,1,784,60000);   %%%784x1x60000%%%    
train_x_matrix=permute(train_x_matrix,[2 1 3]);
test_x_matrix=reshape(test_x,1,784,10000);
test_x_matrix=permute(test_x_matrix,[2 1 3]);
load mnist_uint8.mat
train_x_matrix=double(train_x_matrix)/255;
test_x_matrix=double(test_x_matrix)/255;
%%%%%%%训练集及测试集的归一化处理%%%%%%%%%%%%%%
train_x_matrix=reshape(train_x_matrix,28,28,60000);
train_x_matrix=permute(train_x_matrix,[2,1,3]);
for i=1:60000
    train_x_1=restrict(train_x_matrix(:,:,i));
    [train_x_m,train_x_n]=size(train_x_1);
    if(train_x_m/train_x_n>2&&train_x_m/train_x_n<=3)
        train_x_2=imresize(train_x_1,[20,14]);
        train_x_3=zeros(20,3);
        train_x_4=zeros(20,3);
        train_x_5=[train_x_3,train_x_2,train_x_4];
        train_x_6=zeros(4,4);
        train_x_7=zeros(20,4);
        train_x_8=zeros(4,20);
        train_x_9=[train_x_6 train_x_8 train_x_6;train_x_7 train_x_5 train_x_7;train_x_6 train_x_8 train_x_6];
    elseif(train_x_m/train_x_n>3)
        train_x_2=imresize(train_x_1,[20,8]);
        train_x_3=zeros(20,6);
        train_x_4=zeros(20,6);
        train_x_5=[train_x_3,train_x_2,train_x_4];
        train_x_6=zeros(4,4);
        train_x_7=zeros(20,4);
        train_x_8=zeros(4,20);
        train_x_9=[train_x_6 train_x_8 train_x_6;train_x_7 train_x_5 train_x_7;train_x_6 train_x_8 train_x_6];
    elseif(train_x_n/train_x_m>2&&train_x_n/train_x_m<=3)
        train_x_2=imresize(train_x_1,[14,20]);
        train_x_3=zeros(3,20);
        train_x_4=zeros(3,20);
        train_x_5=[train_x_3;train_x_2;train_x_4];
        train_x_6=zeros(4,4);
        train_x_7=zeros(20,4);
        train_x_8=zeros(4,20);
        train_x_9=[train_x_6 train_x_8 train_x_6;train_x_7 train_x_5 train_x_7;train_x_6 train_x_8 train_x_6];
    elseif(train_x_n/train_x_m>3)
        train_x_2=imresize(train_x_1,[8,20]);
        train_x_3=zeros(6,20);
        train_x_4=zeros(6,20);
        train_x_5=[train_x_3;train_x_2;train_x_4];
        train_x_6=zeros(4,4);
        train_x_7=zeros(20,4);
        train_x_8=zeros(4,20);
        train_x_9=[train_x_6 train_x_8 train_x_6;train_x_7 train_x_5 train_x_7;train_x_6 train_x_8 train_x_6];
    else
        train_x_5=imresize(train_x_1,[20,20]);
        train_x_6=zeros(4,4);
        train_x_7=zeros(20,4);
        train_x_8=zeros(4,20);
        train_x_9=[train_x_6 train_x_8 train_x_6;train_x_7 train_x_5 train_x_7;train_x_6 train_x_8 train_x_6];
    end
    train_x_matrix(:,:,i)=train_x_9;
end
test_x_matrix=reshape(test_x_matrix,28,28,10000);
test_x_matrix=permute(test_x_matrix,[2,1,3]);
for i=1:10000
    test_x_1=restrict(test_x_matrix(:,:,i));
    [test_x_m,test_x_n]=size(test_x_1);
    if(test_x_m/test_x_n>2&&test_x_m/test_x_n<=3)
        test_x_2=imresize(test_x_1,[20,14]);
        test_x_3=zeros(20,3);
        test_x_4=zeros(20,3);
        test_x_5=[test_x_3,test_x_2,test_x_4];
        test_x_6=zeros(4,4);
        test_x_7=zeros(20,4);
        test_x_8=zeros(4,20);
        test_x_9=[test_x_6 test_x_8 test_x_6;test_x_7 test_x_5 test_x_7;test_x_6 test_x_8 test_x_6];
    elseif(test_x_m/test_x_n>3)
        test_x_2=imresize(test_x_1,[20,8]);
        test_x_3=zeros(20,6);
        test_x_4=zeros(20,6);
        test_x_5=[test_x_3,test_x_2,test_x_4];
        test_x_6=zeros(4,4);
        test_x_7=zeros(20,4);
        test_x_8=zeros(4,20);
        test_x_9=[test_x_6 test_x_8 test_x_6;test_x_7 test_x_5 test_x_7;test_x_6 test_x_8 test_x_6];
    elseif(test_x_n/test_x_m>2&&test_x_n/test_x_m<=3)
        test_x_2=imresize(test_x_1,[14,20]);
        test_x_3=zeros(3,20);
        test_x_4=zeros(3,20);
        test_x_5=[test_x_3;test_x_2;test_x_4];
        test_x_6=zeros(4,4);
        test_x_7=zeros(20,4);
        test_x_8=zeros(4,20);
        test_x_9=[test_x_6 test_x_8 test_x_6;test_x_7 test_x_5 test_x_7;test_x_6 test_x_8 test_x_6];
    elseif(test_x_n/test_x_m>3)
        test_x_2=imresize(test_x_1,[8,20]);
        test_x_3=zeros(6,20);
        test_x_4=zeros(6,20);
        test_x_5=[test_x_3;test_x_2;test_x_4];
        test_x_6=zeros(4,4);
        test_x_7=zeros(20,4);
        test_x_8=zeros(4,20);
        test_x_9=[test_x_6 test_x_8 test_x_6;test_x_7 test_x_5 test_x_7;test_x_6 test_x_8 test_x_6];
    else
        test_x_5=imresize(test_x_1,[20,20]);
        test_x_6=zeros(4,4);
        test_x_7=zeros(20,4);
        test_x_8=zeros(4,20);
        test_x_9=[test_x_6 test_x_8 test_x_6;test_x_7 test_x_5 test_x_7;test_x_6 test_x_8 test_x_6];
    end
    test_x_matrix(:,:,i)=test_x_9;
end
train_x_matrix=permute(train_x_matrix,[2,1,3]);
train_x_matrix=reshape(train_x_matrix,784,1,60000);
test_x_matrix=permute(test_x_matrix,[2,1,3]);
test_x_matrix=reshape(test_x_matrix,784,1,10000);
% train_x=double(train_x)/255;%%%归一化%%% 47040000x1 double
% test_x=double(test_x)/255;  %%%归一化%%% 7840000x1 double
train_y=double(train_y);
test_y=double(test_y);
%%%%%%%%%%%三层BP测试%%%%%%%%%%
sam_sum=60000;
input=784;
output=10;
hid=30;
w1=randn([input,hid]); %%%前向通道权值w1 784x20 double
w2=randn([hid,output]);%%%前向通道权值w2 20x10 double
bias1=zeros(hid,1);    %%%偏量bias1 20x1 
bias2=zeros(output,1); %%%偏量bias2 10x1
rate1=0.25;%%%学习率                                      
rate2=0.25;
temp1=zeros(hid,1);    %%%20x1
net=temp1;
temp2=zeros(output,1); %%%10x1
z=temp2;
for num=1:10
    for i=1:sam_sum%60000
        label=zeros(10,1);
        label(train_y(i)+1,1)=1;
        temp1 = (train_x_matrix(:,:,i)'*w1)' + bias1;%20x1
        net = 1./(1+exp(-temp1));%20x1
        temp2 =(net'*w2)'+ bias2;%10x1
        z = 1./(1+exp(-temp2));%10x1
        error = label - z;%10x1
        deltaZ = error.*z.*(1-z);%10x1 梯度跟新公式
        deltaNet = net.*(1-net).*(w2*deltaZ);%20x1
        for j = 1:output%10
            w2(:,j) = w2(:,j) + rate2*deltaZ(j).*net;
        end
        for j = 1:hid%20
            w1(:,j) = w1(:,j) + rate1*deltaNet(j).*train_x_matrix(:,:,i);
        end
        bias2 = bias2 + rate2*deltaZ;
        bias1 = bias1 + rate1*deltaNet;
    end
end
% baocun_w1=w1;
% baocun_w2=w2;
% baocun_bias1=bias1;
% baocun_bias2=bias2;
% save('baocun_demo1(95.07).mat','baocun_w1','baocun_w2','baocun_bias1','baocun_bias2');
% load baocun_demo.mat
test_demo=zeros(28,28,37);
demo=imread('handwrite81.bmp');
test_demo=demo';
test_demo=reshape(test_demo,1,784,1);
test_demo=permute(test_demo,[2,1,3]);
test_demo=double(test_demo)/255;
temp1=(test_demo(:,:,1)'*w1)'+bias1;
net=1./(1+exp(-temp1));
temp2=(net'*w2)'+bias2;
z=1./(1+exp(-temp2));
[maxn,inx]=max(z);
inx=inx-1;
disp(inx);
%%%测试数据集%%% 
test_sum=10000;
count=0;
for i=1:test_sum
    temp1=(test_x_matrix(:,:,i)'*w1)'+bias1;
    net=1./(1+exp(-temp1));
    temp2=(net'*w2)'+bias2;
    z=1./(1+exp(-temp2));
    [maxn,inx]=max(z);
    inx=inx-1;
    if inx==test_y(i);
        count=count+1;
    end
end
correctrate=count/test_sum;
disp(correctrate);          %%%%90%--96%  
%%%%%%%四层BP神经网络测试%%%%%%%%
sam_sum=60000;
input=784;
output=10;
hid1=500;
hid2=300;
w1=randn([input,hid1]);%784x40
w2=randn([hid1,hid2]);%40x20
w3=randn([hid2,output]);%20x10
bias1=zeros(hid1,1);%40x1
bias2=zeros(hid2,1);%20x1
bias3=zeros(output,1);%10x1
rate1=0.25;
rate2=0.25;
rate3=0.25;
temp1=zeros(hid1,1);%40x1
temp2=zeros(hid2,1);%20x1
temp3=zeros(output,1);%10x1
z=temp3;
for num=1:10
    for i=1:sam_sum%60000
       label=zeros(10,1);
       label(train_y(i)+1,1)=1; 
       temp1= (train_x_matrix(:,:,i)'*w1)' + bias1;%40x1
       net1=1./(1+exp(-temp1));%40x1
       temp2=(net1'*w2)'+bias2;%20x1
       net2=1./(1+exp(-temp2));%20x1
       temp3=(net2'*w3)'+bias3;%10x1
       z=1./(1+exp(-temp3));%10x1
       error=label-z;%10x1
       deltaZ=error.*z.*(1-z);%10x1
       deltaNet2=net2.*(1-net2).*(w3*deltaZ);%20x1
       deltaNet1=net1.*(1-net1).*(w2*deltaNet2);%20x1
       for j=1:output%10
           w3(:,j)=w3(:,j)+rate3*deltaZ(j).*net2;
       end
       for j=1:hid2
           w2(:,j)=w2(:,j)+rate2*deltaNet2(j).*net1;
       end
       for j=1:hid1
           w1(:,j)=w1(:,j)+rate1*deltaNet1(j).*train_x_matrix(:,:,j);
       end
       bias3=bias3+rate3*deltaZ;
       bias2=bias2+rate2*deltaNet2;
       bias1=bias1+rate1*deltaNet1;
    end
end
test_sum=10000;
count=0;
for i=1:test_sum
    temp1=(test_x_matrix(:,:,i)'*w1)'+bias1;
    net1=1./(1+exp(-temp1));
    temp2=(net1'*w2)'+bias2;
    net2=1./(1+exp(-temp2));
    temp3=(net2'*w3)'+bias3;
    z=1./(1+exp(-temp3));
    [maxn,inx]=max(z);
    inx=inx-1;
    if inx==test_y(i);
        count=count+1;
    end
end
correctrate=count/test_sum;
disp(correctrate);


% matrix_length=length(matrix);
% for len=1:matrix_length-1
%     if(matrix(1,len)==0&&matrix(1,len+1)~=0)
%         char_left=len;
%         char_width=0;
%         while sum(standard1(:,char_left+1))~=hang&&char_left<lie
%             char_left=char_left+1;
%             char_width=char_width+1;
%         end
%         char_single=restrict(imcrop(standard1,[len 1 char_width hang]));
%         char_single1=imresize(char_single,[40 25]);
%         figure,imshow(char_single1);
%     end
% end
        




    

% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Path='D:\Matlab2016a\Matlab_R2016a_win64\workspace\tuxiangyuchuli\'
Image_show=imread('yuanshi.bmp');
Image_bw=imread('YS.bmp');
axes(handles.axes9);
imshow(Image_show);
[Image_bw_m,Image_bw_n]=size(Image_bw);
Image_bw1=double(Image_bw);
[bw_a,bw_b]=find(Image_bw==1);
bw_a_min=min(bw_a);
bw_a_max=max(bw_a);
bw_b_min=min(bw_b);
bw_b_max=max(bw_b);
caculate=zeros(20,20);
bw_left=0;
bw_left1=0;
bw_right1=0;
bw_right2=0;
% image_res=imread('YS.bmp');
% [m,n]=size(image_res);
% image_res1=double(image_res);
% matrix_bw_1=zeros(m,1);
% matrix_bw_2=zeros(n,1);
% for bw_i=1:m
%     for bw_j=1:n
%         if(image_res1(bw_i,bw_j)==1);
%             matrix_bw_1(bw_i,1)=matrix_bw_1(bw_i,1)+1;
%         end
%     end
% end
% for bw_j=1:n
%     for bw_i=1:m
%         if(image_res1(bw_i,bw_j)==1);
%             matrix_bw_2(bw_j,1)=matrix_bw_2(bw_j,1)+1;
%         end
%     end
% end
% bw_px0=1;
% bw_px1=1;
% bw_px2=1;
% bw_px3=1;
% bw_hang_num=hang_slice(image_res);
% image_res5=zeros(bw_hang_num,n);
% for i=1:bw_hang_num%4
%     while(matrix_bw_1(bw_px0,1)<1&&bw_px0<=Image_bw_m)
%         bw_px0=bw_px0+1;
%     end
%     bw_px1=bw_px0;
%     while(matrix_bw_1(bw_px1,1)>=1&&bw_px1<=Image_bw_m)
%         bw_px1=bw_px1+1;
%     end
%     for j=1:n-1
%         len1=1
%         if(sum(image_res(bw_px0:bw_px1,j))~=0&&sum(image_res(bw_px0:bw_px1,j+1))==0)
%             len1=j;
%         end
%         for jj=len1:1:n-1
%             len2=len1;
%             if(sum(image_res(bw_px0:bw_px1,jj))==0&&sum(image_res(bw_px0:bw_px1,jj+1))~=0)
%                 len2=jj;
%                 break;
%             end
%         end
%         len=len2-len1;
%         image_res5(i,j)=len;
%     end
%     bw_px0=bw_px1;
% end
% image_res6=zeros(bw_hang_num,1);
% for i=1:bw_hang_num
%     image_res6(i,1)=max(image_res5(i,:));
% end
% len_f=min(image_res6);
% disp(len_f);

for bw_jj_1=1:Image_bw_n
    flag=0;
    while(sum(Image_bw(:,bw_jj_1))==0&&sum(Image_bw(:,bw_jj_1+1))~=0)
        bw_left=bw_jj_1; 
        flag=1;
        break;
    end
    if flag==1
        break;
    end
end
%disp(bw_left);
bw_sign1=0;
for bw_ij=bw_left:Image_bw_n
    bw_sign=0;
    while(sum(Image_bw(:,bw_ij+bw_sign))==0)
        bw_sign=bw_sign+1;
    end
    if(bw_sign>=50)
        bw_sign1=bw_ij+1;
        break;
    end
end
%disp(bw_sign1);
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
%disp(bw_left1);
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
%disp(bw_right1);
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
        flag=0;
        for output_jj=1:output_j1-1
            if(caculate(output_i,output_jj)==15)
                output_j2=output_jj;
                flag=1;
            end
        end
        if(flag==1)
            for output_jjj=1:output_j2-1
                abc(output_i,output_jjj)=caculate(output_i,output_jjj)*10^(output_j2-1-output_jjj);
            end
            for output_jjj=output_j2+1:output_j1-1
                abc(output_i,output_jjj)=caculate(output_i,output_jjj)*10^(output_j2-output_jjj);
            end
        else
            for output_jj=1:output_j1-1
                abc(output_i,output_jj)=caculate(output_i,output_jj)*10^(output_j1-1-output_jj);
            end
        end
        flag=0;
        for output_jjjj=output_j1+1:output_j3-1
            if(caculate(output_i,output_jjjj)==15)
                output_j4=output_jjjj;
                flag=1;
            end
        end
        if(flag==1)
            for output_jjjjj=output_j1+1:output_j4-1
                abc1(output_i,output_jjjjj-output_j1)=caculate(output_i,output_jjjjj)*10^(output_j4-output_jjjjj-1);
            end
            for output_jjjjj=output_j4+1:output_j3-1
                abc1(output_i,output_jjjjj-output_j1)=caculate(output_i,output_jjjjj)*10^(output_j4-output_jjjjj);
            end
        else
            for output_jjjj=output_j1+1:output_j3-1
                abc1(output_i,output_jjjj-output_j1)=caculate(output_i,output_jjjj)*10^(output_j3-1-output_jjjj);
            end
        end
        flag=0;
        for output_jjjj=output_j3+1:caculate_lie2
            if(caculate(output_i,output_jjjj)==15)
                output_j5=output_jjjj;
                flag=1;
            end
        end
        if(flag==1)
            for output_jjjjj=output_j3+1:output_j5-1
                result_ghi(output_i,output_jjjjj-output_j3)=caculate(output_i,output_jjjjj)*10^(output_j5-1-output_jjjjj);
            end
            for output_jjjjj=output_j5+1:caculate_lie2
                result_ghi(output_i,output_jjjjj-output_j3)=caculate(output_i,output_jjjjj)*10^(output_j5-output_jjjjj);
            end
        else
            for output_jjjj=output_j3++1:caculate_lie2
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
                flag=0;
                for output_jjj=1:output_cheng1-1
                    if(caculate(output_i,output_jjj)==15)
                        output_h1=output_jjj;
                        flag=1;
                    end
                end
                if(flag==1)
                    for output_jjjj=1:output_h1-1
                        abc(output_i,output_jjjj)=caculate(output_i,output_jjjj)*10^(output_h1-1-output_jjjj);
                    end
                    for output_jjjj=output_h1+1:output_cheng1-1
                        abc(output_i,output_jjjj)=caculate(output_i,output_jjjj)*10^(output_h1-output_jjjj);
                    end
                else
                    for output_jjj=1:output_cheng1-1
                        abc(output_i,output_jjj)=caculate(output_i,output_jjj)*10^(output_cheng1-1-output_jjj);
                    end
                end
                flag=0;
                for output_jjj=output_cheng1+1:output_cheng-1
                    if(caculate(output_i,output_jjj)==15)
                        output_h2=output_jjj;
                        flag=1;
                    end
                end
                if(flag==1)
                    for output_jjjj=output_cheng1+1:output_h2-1
                        abc1(output_i,output_jjjj-output_cheng1)=caculate(output_i,output_jjjj)*10^(output_h2-1-output_jjjj);
                    end
                    for output_jjjj=output_h2+1:output_cheng-1
                        abc1(output_i,output_jjjj-output_cheng1)=caculate(output_i,output_jjjj)*10^(output_h2-output_jjjj);
                    end
                else
                    for output_jjj=output_cheng1+1:output_cheng-1
                        abc1(output_i,output_jjj-output_cheng1)=caculate(output_i,output_jjj)*10^(output_cheng-1-output_jjj);
                    end
                end
                flag=0;
                for output_jjj=output_cheng+1:output_deng-1
                    if(caculate(output_i,output_jjj)==15)
                        output_h3=output_jjj;
                        flag=1;
                    end
                end
                if(flag==1)
                    for output_jjjj=output_cheng+1:output_h3-1
                        abc2(output_i,output_jjjj-output_cheng)=caculate(output_i,output_jjjj)*10^(output_h3-1-output_jjjj);
                    end
                    for output_jjjj=output_h3+1:output_deng-1
                        abc2(output_i,output_jjjj-output_cheng)=caculate(output_i,output_jjjj)*10^(output_h3-output_jjjj);
                    end
                else
                    for output_jjj=output_cheng+1:output_deng-1
                        abc2(output_i,output_jjj-output_cheng)=caculate(output_i,output_jjj)*10^(output_deng-1-output_jjj);
                    end
                end
                flag=0;
                for output_jjj=output_deng+1:caculate_lie2
                    if(caculate(output_i,output_jjj)==15)
                        output_h4=output_jjj;
                        flag=1;
                    end
                end
                if(flag==1)
                    for output_jjjj=output_deng+1:output_h4-1
                        result_ghi(output_i,output_jjjj-output_deng)=caculate(output_i,output_jjjj)*10^(output_h4-1-output_jjjj);
                    end
                    for output_jjjj=output_h4+1:caculate_lie2
                        result_ghi(output_i,output_jjjj-output_deng)=caculate(output_i,output_jjjj)*10^(output_h4-output_jjjj);
                    end
                else
                    for output_jjj=output_deng+1:caculate_lie2
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
                flag=0;
                for output_jjj=1:output_chu1-1
                    if(caculate(output_i,output_jjj)==15)
                        output_h5=output_jjj;
                        flag=1;
                    end
                end
                if(flag==1)
                    for output_jjjj=1:output_h5-1
                        abc(output_i,output_jjjj)=caculate(output_i,output_jjjj)*10^(output_h5-1-output_jjjj);
                    end
                    for output_jjjj=output_h5+1:output_chu1-1
                        abc(output_i,output_jjjj)=caculate(output_i,output_jjjj)*10^(output_h5-output_jjjj);
                    end
                else
                    for output_jjj=1:output_chu1-1
                        abc(output_i,output_jjj)=caculate(output_i,output_jjj)*10^(output_chu1-1-output_jjj);
                    end
                end
                flag=0;
                for output_jjj=output_chu1+1:output_chu-1
                    if(caculate(output_i,output_jjj)==15)
                        output_h6=output_jjj;
                        flag=1;
                    end
                end
                if(flag==1)
                    for output_jjjj=output_chu1+1:output_h6-1
                        abc1(output_i,output_jjjj-output_chu1)=caculate(output_i,output_jjjj)*10^(output_h6-1-output_jjjj);
                    end
                    for output_jjjj=output_h6+1:output_chu-1
                        abc1(output_i,output_jjjj-output_chu1)=caculate(output_i,output_jjjj)*10^(output_h6-output_jjjj);
                    end
                else
                    for output_jjj=output_chu1+1:output_chu-1
                        abc1(output_i,output_jjj-output_chu1)=caculate(output_i,output_jjj)*10^(output_chu-1-output_jjj);
                    end
                end
                flag=0;
                for output_jjj=output_chu+1:output_deng-1
                    if(caculate(output_i,output_jjj)==15)
                        output_h7=output_jjj;
                        flag=1;
                    end
                end
                if(flag==1)
                    for output_jjjj=output_chu+1:output_h7-1
                        abc2(output_i,output_jjjj-output_chu)=caculate(output_i,output_jjjj)*10^(output_h7-1-output_jjjj);
                    end
                    for output_jjjj=output_h7+1:output_deng-1
                        abc2(output_i,output_jjjj-output_chu)=caculate(output_i,output_jjjj)*10^(output_h7-output_jjjj);
                    end
                else
                    for output_jjj=output_chu+1:output_deng-1
                        abc2(output_i,output_jjj-output_chu)=caculate(output_i,output_jjj)*10^(output_deng-1-output_jjj);
                    end
                end
                flag=0
                for output_jjj=output_deng+1:caculate_lie2
                    if(caculate(output_i,output_jjj)==15)
                        output_h8=output_jjj;
                        flag=1;
                    end
                end
                if(flag==1)
                    for output_jjjj=output_deng+1:output_h8-1
                        result_ghi(output_i,output_jjjj-output_deng)=caculate(output_i,output_jjjj)*10^(output_h8-1-output_jjjj);
                    end
                    for output_jjjj=output_h8+1:caculate_lie2
                        result_ghi(output_i,output_jjjj-output_deng)=caculate(output_i,output_jjjj)*10^(output_h8-output_jjjj);
                    end
                else
                    for output_jjj=output_deng+1:caculate_lie2
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
                flag=0;
                if(output_cheng>output_chu)
                    for output_jjj=1:output_chu-1
                        if(caculate(output_i,output_jjj)==15)
                            output_q1=output_jjj;
                            flag=1;
                        end
                    end
                    if(flag==1)
                        for output_jjjj=1:output_q1-1
                            abc(output_i,output_jjjj)=caculate(output_i,output_jjjj)*10^(output_q1-1-output_jjjj);
                        end
                        for output_jjjj=output_q1+1:output_chu-1
                            abc(output_i,output_jjjj)=caculate(output_i,output_jjjj)*10^(output_q1-output_jjjj);
                        end
                    else
                        for output_jjj=1:output_chu-1
                            abc(output_i,output_jjj)=caculate(output_i,output_jjj)*10^(output_chu-1-output_jjj);
                        end
                    end
                    flag=0;
                    for output_jjj=output_chu+1:output_cheng-1
                        if(caculate(output_i,output_jjj)==15)
                            output_q2=output_jjj;
                            flag=1;
                        end
                    end
                    if(flag==1)
                        for output_jjjj=output_chu+1:output_q2-1
                            abc1(output_i,output_jjjj-output_chu)=caculate(output_i,output_jjjj)*10^(output_q2-1-output_jjjj);
                        end
                        for output_jjjj=output_q2+1:output_cheng-1
                            abc1(output_i,output_jjjj-output_chu)=caculate(output_i,output_jjjj)*10^(output_q2-output_jjjj);
                        end
                    else
                        for output_jjj=output_chu+1:output_cheng-1
                            abc1(output_i,output_jjj-output_chu)=caculate(output_i,output_jjj)*10^(output_cheng-1-output_jjj);
                        end
                    end
                    flag=0;
                    for output_jjj=output_cheng+1:output_deng-1
                        if(caculate(output_i,output_jjj)==15)
                            output_q3=output_jjj;
                            flag=1;
                        end
                    end
                    if(flag==1)
                        for output_jjjj=output_cheng+1:output_q3-1
                            abc2(output_i,output_jjjj-output_cheng)=caculate(output_i,output_jjjj)*10^(output_q3-1-output_jjjj);
                        end
                        for output_jjjj=output_q3+1:output_deng-1
                            abc2(output_i,output_jjjj-output_cheng)=caculate(output_i,output_jjjj)*10^(output_q3-output_jjjj);
                        end
                    else
                        for output_jjj=output_cheng+1:output_deng-1
                            abc2(output_i,output_jjj-output_cheng)=caculate(output_i,output_jjj)*10^(output_deng-1-output_jjj);
                        end
                    end
                    flag=0;
                    for output_jjj=output_deng+1:caculate_lie2
                        if(caculate(output_i,output_jjj)==15)
                            output_q4=output_jjj;
                            flag=1;
                        end
                    end
                    if(flag==1)
                        for output_jjjj=output_deng+1:output_q4-1
                            result_ghi(output_i,output_jjjj-output_deng)=caculate(output_i,output_jjjj)*10^(output_q4-1-output_jjjj);
                        end
                        for output_jjjj=output_q4+1:caculate_lie2
                            result_ghi(output_i,output_jjjj-output_deng)=caculate(output_i,output_jjjj)*10^(output_q4-output_jjjj);
                        end
                    else
                        for output_jjj=output_deng+1:caculate_lie2
                            result_ghi(output_i,output_jjj-output_deng)=caculate(output_i,output_jjj)*10^(caculate_lie2-output_jjj);
                        end
                    end
                else
                    flag=0;
                    for output_jjj=1:output_cheng-1
                        if(caculate(output_i,output_jjj)==15)
                            output_q1=output_jjj;
                            flag=1;
                        end
                    end
                    if(flag==1)
                        for output_jjjj=1:output_q1-1
                            abc(output_i,output_jjjj)=caculate(output_i,output_jjjj)*10^(output_q1-1-output_jjjj);
                        end
                        for output_jjjj=output_q1+1:output_cheng-1
                            abc(output_i,output_jjjj)=caculate(output_i,output_jjjj)*10^(output_q1-output_jjjj);
                        end
                    else
                        for output_jjj=1:output_cheng-1
                            abc(output_i,output_jjj)=caculate(output_i,output_jjj)*10^(output_cheng-1-output_jjj);
                        end
                    end
                    flag=0;
                    for output_jjj=output_cheng+1:output_chu-1
                        if(caculate(output_i,output_jjj)==15)
                            output_q2=output_jjj;
                            flag=1;
                        end
                    end
                    if(flag==1)
                        for output_jjjj=output_cheng+1:output_q2-1
                            abc1(output_i,output_jjjj-output_cheng)=caculate(output_i,output_jjjj)*10^(output_q2-1-output_jjjj);
                        end
                        for output_jjjj=output_q2+1:output_chu-1
                            abc1(output_i,output_jjjj-output_cheng)=caculate(output_i,output_jjjj)*10^(output_q2-output_jjjj);
                        end
                    else
                        for output_jjj=output_cheng+1:output_chu-1
                            abc1(output_i,output_jjj-output_cheng)=caculate(output_i,output_jjj)*10^(output_chu-1-output_jjjj);
                        end
                    end
                    flag=0;
                    for output_jjj=output_chu+1:output_deng-1
                        if(caculate(output_i,output_jjj)==15)
                            output_q3=output_jjj;
                            flag=1;
                        end
                    end
                    if(flag==1)
                        for output_jjjj=output_chu+1:output_q3-1
                            abc2(output_i,output_jjjj-output_chu)=caculate(output_i,output_jjjj)*10^(output_q3-1-output_jjjj);
                        end
                        for output_jjjj=output_q3+1:output_deng-1
                            abc2(output_i,output_jjjj-output_chu)=caculate(output_i,output_jjjj)*10^(output_q3-output_jjjj);
                        end
                    else
                        for output_jjj=output_chu+1:output_deng-1
                            abc2(output_i,output_jjj-output_chu)=caculate(output_i,output_jjj)*10^(output_deng-1-output_jjj);
                        end
                    end
                    flag=0;
                    for output_jjj=output_deng+1:caculate_lie2
                        if(caculate(output_i,output_jjj)==15)
                            output_q4=output_jjj;
                            flag=1;
                        end
                    end
                    if(flag==1)
                        for output_jjjj=output_deng+1:output_q4-1
                            result_ghi(output_i,output_jjjj-output_deng)=caculate(output_i,output_jjjj)*10^(output_q4-1-output_jjjj);
                        end
                        for output_jjjj=output_q4+1:caculate_lie2
                            result_ghi(output_i,output_jjjj-output_deng)=caculate(output_i,output_jjjj)*10^(output_q4-output_jjjj);
                        end
                    else
                        for output_jjj=output_deng+1:caculate_lie2
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
                flag=0;
                for output_jjj=1:output_jia1-1
                    if(caculate(output_i,output_jjj)==15)
                        output_w1=output_jjj;
                        flag=1;
                    end
                end
                if(flag==1)
                    for output_jjjj=1:output_w1-1
                        abc(output_i,output_jjjj)=caculate(output_i,output_jjjj)*10^(output_w1-1-output_jjjj);
                    end
                    for output_jjjj=output_w1+1:output_jia1-1
                        abc(output_i,output_jjjj)=caculate(output_output_jjjj)*10^(output_w1-output_jjjj);
                    end
                else
                    for output_jjj=1:output_jia1-1
                        abc(output_i,output_jjj)=caculate(output_i,output_jjj)*10^(output_jia1-1-output_jjj);
                    end
                end
                flag=0;
                for output_jjj=output_jia1+1:output_jia-1
                    if(caculate(output_i,output_jjj)==15)
                        output_w2=output_jjj;
                        flag=1;
                    end
                end
                if(flag==1)
                    for output_jjjj=output_jia1+1:output_w2-1
                        abc1(output_i,output_jjjj-output_jia1)=caculate(output_i,output_jjjj)*10^(output_w2-1-output_jjjj);
                    end
                    for output_jjjj=output_w2+1:output_jia-1
                        abc1(output_i,output_jjjj-output_jia1)=caculate(output_i,output_jjjj)*10^(output_w2-output_jjjj);
                    end
                else
                    for output_jjj=output_jia1+1:output_jia-1
                        abc1(output_i,output_jjj-output_jia1)=caculate(output_i,output_jjj)*10^(output_jia-1-output_jjj);
                    end
                end
                flag=0;
                for output_jjj=output_jia+1:output_d-1
                    if(caculate(output_i,output_jjj)==15)
                        output_w3=output_jjj;
                        flag=1;
                    end
                end
                if(flag==1)
                    for output_jjjj=output_jia+1:output_w3-1
                        abc2(output_i,output_jjjj-output_jia)=caculate(output_i,output_jjjj)*10^(output_w3-1-output_jjjj);
                    end
                    for output_jjjj=output_w3+1:output_d-1
                        abc2(output_i,output_jjjj-output_jia)=caculate(output_i,output_jjjj)*10^(output_w3-output_jjjj);
                    end
                else
                    for output_jjj=output_jia+1:output_d-1
                        abc2(output_i,output_jjj-output_jia)=caculate(output_i,output_jjj)*10^(output_d-1-output_jjj);
                    end
                end
                flag=0;
                for output_jjj=output_d+1:caculate_lie2
                    if(caculate(output_i,output_jjj)==15)
                        output_w4=output_jjj;
                        flag=1;
                    end
                end
                if(flag==1)
                    for output_jjjj=output_deng+1:output_w4-1
                        result_ghi(output_i,output_jjjj-output_deng)=caculate(output_i,output_jjjj)*10^(output_w4-1-output_jjjj);
                    end
                    for output_jjjj=output_w4+1:caculate_lie2
                        result_ghi(output_i,output_jjjj-output_deng)=caculate(output_i,output_jjjj)*10^(output_w4-output_jjjj);
                    end
                else
                    for output_jjj=output_deng+1:caculate_lie2
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
                flag=0;
                for output_jjj=1:output_jian1-1
                    if(caculate(output_i,output_jjj)==15)
                        output_e1=output_jjj;
                        flag=1;
                    end
                end
                if(flag==1)
                    for output_jjjj=1:output_e1-1
                        abc(output_i,output_jjjj)=caculate(output_i,output_jjjj)*10^(output_e1-1-output_jjjj);
                    end
                    for output_jjjj=output_e1+1:output_jian1-1
                        abc(output_i,output_jjjj)=caculate(output_output_jjjj)*10^(output_e1-output_jjjj);
                    end
                else
                    for output_jjj=1:output_jian1-1
                        abc(output_i,output_jjj)=caculate(output_i,output_jjj)*10^(output_jian1-1-output_jjj);
                    end
                end
                flag=0;
                for output_jjj=output_jian1+1:output_jian-1
                    if(caculate(output_i,output_jjj)==15)
                        output_e2=output_jjj;
                        flag=1;
                    end
                end
                if(flag==1)
                    for output_jjjj=output_jian1+1:output_e2-1
                        abc1(output_i,output_jjjj-output_jian1)=caculate(output_i,output_jjjj)*10^(output_e2-1-output_jjjj);
                    end
                    for output_jjjj=output_e2+1:output_jian-1
                        abc1(output_i,output_jjjj-output_jian1)=caculate(output_i,output_jjjj)*10^(output_e2-output_jjjj);
                    end
                else
                    for output_jjj=output_jian1+1:output_jian-1
                        abc1(output_i,output_jjj-output_jian1)=caculate(output_i,output_jjj)*10^(output_jian-1-output_jjj);
                    end
                end
                flag=0;
                for output_jjj=output_jian+1:output_deng-1
                    if(caculate(output_i,output_jjj)==15)
                        output_e3=output_jjj;
                        flag=1;
                    end
                end
                if(flag==1)
                    for output_jjjj=output_jian+1:output_e3-1
                        abc2(output_i,output_jjjj-output_jian)=caculate(output_i,output_jjjj)*10^(output_e3-1-output_jjjj);
                    end
                    for output_jjjj=output_e3+1:output_deng-1
                        abc2(output_i,output_jjjj-output_jian)=caculate(output_i,output_jjjj)*10^(output_e3-output_jjjj);
                    end
                else
                    for output_jjj=output_jian+1:output_deng-1
                        abc2(output_i,output_jjj-output_jian)=caculate(output_i,output_jjj)*10^(output_deng-1-output_jjj);
                    end
                end
                flag=0;
                for output_jjj=output_deng+1:caculate_lie2
                    if(caculate(output_i,output_jjj)==15)
                        output_e4=output_jjj;
                        flag=1;
                    end
                end
                if(flag==1)
                    for output_jjjj=output_deng+1:output_e4-1
                        result_ghi(output_i,output_jjjj-output_deng)=caculate(output_i,output_jjjj)*10^(output_e4-1-output_jjjj);
                    end
                    for output_jjjj=output_e4+1:caculate_lie2
                        result_ghi(output_i,output_jjjj-output_deng)=caculate(output_i,output_jjjj)*10^(output_e4-output_jjjj);
                    end
                else
                    for output_jjj=output_deng+1:caculate_lie2
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
                flag=0;
                if(output_jia>output_jian)
                    for output_jjj=1:output_jian-1
                        if(caculate(output_i,output_jjj)==15)
                            output_q1=output_jjj;
                            flag=1;
                        end
                    end
                    if(flag==1)
                        for output_jjjj=1:output_q1-1
                            abc(output_i,output_jjjj)=caculate(output_i,output_jjjj)*10^(output_q1-1-output_jjjj);
                        end
                        for output_jjjj=output_q1+1:output_jian-1
                            abc(output_i,output_jjjj)=caculate(output_i,output_jjjj)*10^(output_q1-output_jjjj);
                        end
                    else
                        for output_jjj=1:output_jian-1
                            abc(output_i,output_jjj)=caculate(output_i,output_jjj)*10^(output_jian-1-output_jjj);
                        end
                    end
                    flag=0;
                    for output_jjj=output_jian+1:output_jia-1
                        if(caculate(output_i,output_jjj)==15)
                            output_q2=output_jjj;
                            flag=1;
                        end
                    end
                    if(flag==1)
                        for output_jjjj=output_jian+1:output_q2-1
                            abc1(output_i,output_jjjj-output_jian)=caculate(output_i,output_jjjj)*10^(output_q2-1-output_jjjj);
                        end
                        for output_jjjj=output_q2+1:output_jia-1
                            abc1(output_i,output_jjjj-output_jian)=caculate(output_i,output_jjjj)*10^(output_q2-output_jjjj);
                        end
                    else
                        for output_jjj=output_jian+1:output_jia-1
                            abc1(output_i,output_jjj-output_jian)=caculate(output_i,output_jjj)*10^(output_jia-1-output_jjjj);
                        end
                    end
                    flag=0;
                    for output_jjj=output_jia+1:output_deng-1
                        if(caculate(output_i,output_jjj)==15)
                            output_q3=output_jjj;
                            flag=1;
                        end
                    end
                    if(flag==1)
                        for output_jjjj=output_jia+1:output_q3-1
                            abc2(output_i,output_jjjj-output_jia)=caculate(output_i,output_jjjj)*10^(output_q3-1-output_jjjj);
                        end
                        for output_jjjj=output_q3+1:output_deng-1
                            abc2(output_i,output_jjjj-output_jia)=caculate(output_i,output_jjjj)*10^(output_q3-output_jjjj);
                        end
                    else
                        for output_jjj=output_jia+1:output_deng-1
                            abc2(output_i,output_jjj-output_jia)=caculate(output_i,output_jjj)*10^(output_deng-1-output_jjj);
                        end
                    end
                    flag=0;
                    for output_jjj=output_deng+1:caculate_lie2
                        if(caculate(output_i,output_jjj)==15)
                            output_q4=output_jjj;
                            flag=1;
                        end
                    end
                    if(flag==1)
                        for output_jjjj=output_deng+1:output_q4-1
                            result_ghi(output_i,output_jjjj-output_deng)=caculate(output_i,output_jjjj)*10^(output_q4-1-output_jjjj);
                        end
                        for output_jjjj=output_q4+1:caculate_lie2
                            result_ghi(output_i,output_jjjj-output_deng)=caculate(output_i,output_jjjj)*10^(output_q4-output_jjjj);
                        end
                    else
                        for output_jjj=output_deng+1:caculate_lie2
                            result_ghi(output_i,output_jjj-output_deng)=caculate(output_i,output_jjj)*10^(caculate_lie2-output_jjj);
                        end
                    end
                else
                    flag=0;
                    for output_jjj=1:output_jia-1
                        if(caculate(output_i,output_jjj)==15)
                            output_q1=output_jjj;
                            flag=1;
                        end
                    end
                    if(flag==1)
                        for output_jjjj=1:output_q1-1
                            abc(output_i,output_jjjj)=caculate(output_i,output_jjjj)*10^(output_q1-1-output_jjjj);
                        end
                        for output_jjjj=output_q1+1:output_jia-1
                            abc(output_i,output_jjjj)=caculate(output_i,output_jjjj)*10^(output_q1-output_jjjj);
                        end
                    else
                        for output_jjj=1:output_jia-1
                            abc(output_i,output_jjj)=caculate(output_i,output_jjj)*10^(output_jia-1-output_jjj);
                        end
                    end
                    flag=0;
                    for output_jjj=output_jia+1:output_jian-1
                        if(caculate(output_i,output_jjj)==15)
                            output_q2=output_jjj;
                            flag=1;
                        end
                    end
                    if(flag==1)
                        for output_jjjj=output_jia+1:output_q2-1
                            abc1(output_i,output_jjjj-output_jia)=caculate(output_i,output_jjjj)*10^(output_q2-1-output_jjjj);
                        end
                        for output_jjjj=output_q2+1:output_jian-1
                            abc1(output_i,output_jjjj-output_jia)=caculate(output_i,output_jjjj)*10^(output_q2-output_jjjj);
                        end
                    else
                        for output_jjj=output_jia+1:output_jian-1
                            abc1(output_i,output_jjj-output_jia)=caculate(output_i,output_jjj)*10^(output_jian-1-output_jjjj);
                        end
                    end
                    flag=0;
                    for output_jjj=output_jian+1:output_deng-1
                        if(caculate(output_i,output_jjj)==15)
                            output_q3=output_jjj;
                            flag=1;
                        end
                    end
                    if(flag==1)
                        for output_jjjj=output_jian+1:output_q3-1
                            abc2(output_i,output_jjjj-output_jian)=caculate(output_i,output_jjjj)*10^(output_q3-1-output_jjjj);
                        end
                        for output_jjjj=output_q3+1:output_deng-1
                            abc2(output_i,output_jjjj-output_jian)=caculate(output_i,output_jjjj)*10^(output_q3-output_jjjj);
                        end
                    else
                        for output_jjj=output_jian+1:output_deng-1
                            abc2(output_i,output_jjj-output_jian)=caculate(output_i,output_jjj)*10^(output_deng-1-output_jjj);
                        end
                    end
                    flag=0;
                    for output_jjj=output_deng+1:caculate_lie2
                        if(caculate(output_i,output_jjj)==15)
                            output_q4=output_jjj;
                            flag=1;
                        end
                    end
                    if(flag==1)
                        for output_jjjj=output_deng+1:output_q4-1
                            result_ghi(output_i,output_jjjj-output_deng)=caculate(output_i,output_jjjj)*10^(output_q4-1-output_jjjj);
                        end
                        for output_jjjj=output_q4+1:caculate_lie2
                            result_ghi(output_i,output_jjjj-output_deng)=caculate(output_i,output_jjjj)*10^(output_q4-output_jjjj);
                        end
                    else
                        for output_jjj=output_deng+1:caculate_lie2
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
                flag=0;
                if(output_cheng>output_jia)
                    for output_jjj=1:output_jia+1:output_cheng-1
                        if(caculate(output_i,output_jjj)==15)
                            output_q1=output_jjj;
                            flag=1;
                        end
                    end
                    if(flag==1)
                        for output_jjjj=output_jia+1:output_q1-1
                            abc(output_i,output_jjjj-output_jia)=caculate(output_i,output_jjjj)*10^(output_q1-1-output_jjjj);
                        end
                        for output_jjjj=output_q1+1:output_cheng-1
                            abc(output_i,output_jjjj-output_jia)=caculate(output_i,output_jjjj)*10^(output_q1-output_jjjj);
                        end
                    else
                        for output_jjj=output_jia+1:output_cheng-1
                            abc(output_i,output_jjj-output_jia)=caculate(output_i,output_jjj)*10^(output_cheng-1-output_jjj);
                        end
                    end
                    flag=0;
                    for output_jjj=output_cheng+1:output_deng-1
                        if(caculate(output_i,output_jjj)==15)
                            output_q2=output_jjj;
                            flag=1;
                        end
                    end
                    if(flag==1)
                        for output_jjjj=output_cheng+1:output_q2-1
                            abc1(output_i,output_jjjj-output_cheng)=caculate(output_i,output_jjjj)*10^(output_q2-1-output_jjjj);
                        end
                        for output_jjjj=output_q2+1:output_deng-1
                            abc1(output_i,output_jjjj-output_cheng)=caculate(output_i,output_jjjj)*10^(output_q2-output_jjjj);
                        end
                    else
                        for output_jjj=output_cheng+1:output_deng-1
                            abc1(output_i,output_jjj-output_cheng)=caculate(output_i,output_jjj)*10^(output_deng-1-output_jjjj);
                        end
                    end
                    flag=0;
                    for output_jjj=1:output_jia-1
                        if(caculate(output_i,output_jjj)==15)
                            output_q3=output_jjj;
                            flag=1;
                        end
                    end
                    if(flag==1)
                        for output_jjjj=1:output_q3-1
                            abc(output_i,output_jjjj)=caculate(output_i,output_jjjj)*10^(output_q3-1-output_jjjj);
                        end
                        for output_jjjj=output_q3+1:output_jia-1
                            abc(output_i,output_jjjj)=caculate(output_i,output_jjjj)*10^(output_q3-output_jjjj);
                        end
                    else
                        for output_jjj=1:output_jia-1
                            abc(output_i,output_jjj)=caculate(output_i,output_jjj)*10^(output_jia-1-output_jjj);
                        end
                    end
                    flag=0;
                    for output_jjj=output_deng+1:caculate_lie2
                        if(caculate(output_i,output_jjj)==15)
                            output_q4=output_jjj;
                            flag=1;
                        end
                    end
                    if(flag==1)
                        for output_jjjj=output_deng+1:output_q4-1
                            result_ghi(output_i,output_jjjj-output_deng)=caculate(output_i,output_jjjj)*10^(output_q4-1-output_jjjj);
                        end
                        for output_jjjj=output_q4+1:caculate_lie2
                            result_ghi(output_i,output_jjjj-output_deng)=caculate(output_i,output_jjjj)*10^(output_q4-output_jjjj);
                        end
                    else
                        for output_jjj=output_deng+1:caculate_lie2
                            result_ghi(output_i,output_jjj-output_deng)=caculate(output_i,output_jjj)*10^(caculate_lie2-output_jjj);
                        end
                    end
                else
                    flag=0;
                    for output_jjj=1:output_cheng-1
                        if(caculate(output_i,output_jjj)==15)
                            output_q1=output_jjj;
                            flag=1;
                        end
                    end
                    if(flag==1)
                        for output_jjjj=1:output_q1-1
                            abc(output_i,output_jjjj)=caculate(output_i,output_jjjj)*10^(output_q1-1-output_jjjj);
                        end
                        for output_jjjj=output_q1+1:output_cheng-1
                            abc(output_i,output_jjjj)=caculate(output_i,output_jjjj)*10^(output_q1-output_jjjj);
                        end
                    else
                        for output_jjj=1:output_cheng-1
                            abc(output_i,output_jjj)=caculate(output_i,output_jjj)*10^(output_cheng-1-output_jjj);
                        end
                    end
                    flag=0;
                    for output_jjj=output_cheng+1:output_jia-1
                        if(caculate(output_i,output_jjj)==15)
                            output_q2=output_jjj;
                            flag=1;
                        end
                    end
                    if(flag==1)
                        for output_jjjj=output_cheng+1:output_q2-1
                            abc1(output_i,output_jjjj-output_cheng)=caculate(output_i,output_jjjj)*10^(output_q2-1-output_jjjj);
                        end
                        for output_jjjj=output_q2+1:output_jia-1
                            abc1(output_i,output_jjjj-output_cheng)=caculate(output_i,output_jjjj)*10^(output_q2-output_jjjj);
                        end
                    else
                        for output_jjj=output_cheng+1:output_jia-1
                            abc1(output_i,output_jjj-output_cheng)=caculate(output_i,output_jjj)*10^(output_jia-1-output_jjjj);
                        end
                    end
                    flag=0;
                    for output_jjj=output_jia+1:output_deng-1
                        if(caculate(output_i,output_jjj)==15)
                            output_q3=output_jjj;
                            flag=1;
                        end
                    end
                    if(flag==1)
                        for output_jjjj=output_jia+1:output_q3-1
                            abc2(output_i,output_jjjj-output_jia)=caculate(output_i,output_jjjj)*10^(output_q3-1-output_jjjj);
                        end
                        for output_jjjj=output_q3+1:output_deng-1
                            abc2(output_i,output_jjjj-output_jia)=caculate(output_i,output_jjjj)*10^(output_q3-output_jjjj);
                        end
                    else
                        for output_jjj=output_jia+1:output_deng-1
                            abc2(output_i,output_jjj-output_jia)=caculate(output_i,output_jjj)*10^(output_deng-1-output_jjj);
                        end
                    end
                    flag=0;
                    for output_jjj=output_deng+1:caculate_lie2
                        if(caculate(output_i,output_jjj)==15)
                            output_q4=output_jjj;
                            flag=1;
                        end
                    end
                    if(flag==1)
                        for output_jjjj=output_deng+1:output_q4-1
                            result_ghi(output_i,output_jjjj-output_deng)=caculate(output_i,output_jjjj)*10^(output_q4-1-output_jjjj);
                        end
                        for output_jjjj=output_q4+1:caculate_lie2
                            result_ghi(output_i,output_jjjj-output_deng)=caculate(output_i,output_jjjj)*10^(output_q4-output_jjjj);
                        end
                    else
                        for output_jjj=output_deng+1:caculate_lie2
                            result_ghi(output_i,output_jjj-output_deng)=caculate(output_i,output_jjj)*10^(caculate_lie2-output_jjj);
                        end
                    end
                end
            elseif(chengfa==1&&jianfa==1)
                if(output_cheng>output_jian)
                    jkl1(output_i,1)=caculate(output_i,output_cheng);
                    jkl2(output_i,1)=caculate(output_i,output_jian);
                else
                    jkl1(output_i,1)=caculate(output_i,output_cheng);
                    jkl(output_i,1)=caculate(output_i,output_jian);
                end
                flag=0;
                if(output_cheng>output_jian)
                    for output_jjj=output_jian+1:output_cheng-1
                        if(caculate(output_i,output_jjj)==15)
                            output_q1=output_jjj;
                            flag=1;
                        end
                    end
                    if(flag==1)
                        for output_jjjj=output_jian+1:output_q1-1
                            abc(output_i,output_jjjj-output_jian)=caculate(output_i,output_jjjj)*10^(output_q1-1-output_jjjj);
                        end
                        for output_jjjj=output_q1+1:output_cheng-1
                            abc(output_i,output_jjjj-output_jian)=caculate(output_i,output_jjjj)*10^(output_q1-output_jjjj);
                        end
                    else
                        for output_jjj=output_jian+1:output_cheng-1
                            abc(output_i,output_jjj-output_jian)=caculate(output_i,output_jjj)*10^(output_cheng-1-output_jjj);
                        end
                    end
                    flag=0;
                    for output_jjj=output_cheng+1:output_deng-1
                        if(caculate(output_i,output_jjj)==15)
                            output_q2=output_jjj;
                            flag=1;
                        end
                    end
                    if(flag==1)
                        for output_jjjj=output_cheng+1:output_q2-1
                            abc1(output_i,output_jjjj-output_cheng)=caculate(output_i,output_jjjj)*10^(output_q2-1-output_jjjj);
                        end
                        for output_jjjj=output_q2+1:output_deng-1
                            abc1(output_i,output_jjjj-output_cheng)=caculate(output_i,output_jjjj)*10^(output_q2-output_jjjj);
                        end
                    else
                        for output_jjj=output_cheng+1:output_deng-1
                            abc1(output_i,output_jjj-output_cheng)=caculate(output_i,output_jjj)*10^(output_deng-1-output_jjjj);
                        end
                    end
                    flag=0
                    for output_jjj=1:output_jian-1
                        if(caculate(output_i,output_jjj)==15)
                            output_q3=output_jjj;
                            flag=1;
                        end
                    end
                    if(flag==1)
                        for output_jjjj=1:output_q3-1
                            abc2(output_i,output_jjjj)=caculate(output_i,output_jjjj)*10^(output_q3-1-output_jjjj);
                        end
                        for output_jjjj=output_q3+1:output_jian-1
                            abc2(output_i,output_jjjj)=caculate(output_i,output_jjjj)*10^(output_q3-output_jjjj);
                        end
                    else
                        for output_jjj=1:output_jian-1
                            abc2(output_i,output_jjj)=caculate(output_i,output_jjj)*10^(output_jian-1-output_jjj);
                        end
                    end
                    flag=0;
                    for output_jjj=output_deng+1:caculate_lie2
                        if(caculate(output_i,output_jjj)==15)
                            output_q4=output_jjj;
                            flag=1;
                        end
                    end
                    if(flag==1)
                        for output_jjjj=output_deng+1:output_q4-1
                            result_ghi(output_i,output_jjjj-output_deng)=caculate(output_i,output_jjjj)*10^(output_q4-1-output_jjjj);
                        end
                        for output_jjjj=output_q4+1:caculate_lie2
                            result_ghi(output_i,output_jjjj-output_deng)=caculate(output_i,output_jjjj)*10^(output_q4-output_jjjj);
                        end
                    else
                        for output_jjj=output_deng+1:caculate_lie2
                            result_ghi(output_i,output_jjj-output_deng)=caculate(output_i,output_jjj)*10^(caculate_lie2-output_jjj);
                        end
                    end
                else
                    flag=0;
                    for output_jjj=1:output_cheng-1
                        if(caculate(output_i,output_jjj)==15)
                            output_q1=output_jjj;
                            flag=1
                        end
                    end
                    if(flag==1)
                        for output_jjjj=1:output_q1-1
                            abc(output_i,output_jjjj)=caculate(output_i,output_jjjj)*10^(output_q1-1-output_jjjj);
                        end
                        for output_jjjj=output_q1+1:output_cheng-1
                            abc(output_i,output_jjjj)=caculate(output_i,output_jjjj)*10^(output_q1-output_jjjj);
                        end
                    else
                        for output_jjj=1:output_cheng-1
                            abc(output_i,output_jjj)=caculate(output_i,output_jjj)*10^(output_cheng-1-output_jjj);
                        end
                    end
                    flag=0;
                    for output_jjj=output_cheng+1:output_jian-1
                        if(caculate(output_i,output_jjj)==15)
                            output_q2=output_jjj;
                            flag=1;
                        end
                    end
                    if(flag==1)
                        for output_jjjj=output_cheng+1:output_q2-1
                            abc1(output_i,output_jjjj-output_cheng)=caculate(output_i,output_jjjj)*10^(output_q2-1-output_jjjj);
                        end
                        for output_jjjj=output_q2+1:output_jian-1
                            abc1(output_i,output_jjjj-output_cheng)=caculate(output_i,output_jjjj)*10^(output_q2-output_jjjj);
                        end
                    else
                        for output_jjj=output_cheng+1:output_jian-1
                            abc1(output_i,output_jjj-output_cheng)=caculate(output_i,output_jjj)*10^(output_jian-1-output_jjjj);
                        end
                    end
                    flag=0;
                    for output_jjj=output_jian+1:output_deng-1
                        if(caculate(output_i,output_jjj)==15)
                            output_q3=output_jjj;
                            flag=1;
                        end
                    end
                    if(flag==1)
                        for output_jjjj=output_jian+1:output_q3-1
                            abc2(output_i,output_jjjj-output_jian)=caculate(output_i,output_jjjj)*10^(output_q3-1-output_jjjj);
                        end
                        for output_jjjj=output_q3+1:output_deng-1
                            abc2(output_i,output_jjjj-output_jian)=caculate(output_i,output_jjjj)*10^(output_q3-output_jjjj);
                        end
                    else
                        for output_jjj=output_jian+1:output_deng-1
                            abc2(output_i,output_jjj-output_jian)=caculate(output_i,output_jjj)*10^(output_deng-1-output_jjj);
                        end
                    end
                    flag=0;
                    for output_jjj=output_deng+1:caculate_lie2
                        if(caculate(output_i,output_jjj)==15)
                            output_q4=output_jjj;
                            flag=1;
                        end
                    end
                    if(flag==1)
                        for output_jjjj=output_deng+1:output_q4-1
                            result_ghi(output_i,output_jjjj-output_deng)=caculate(output_i,output_jjjj)*10^(output_q4-1-output_jjjj);
                        end
                        for output_jjjj=output_q4+1:caculate_lie2
                            result_ghi(output_i,output_jjjj-output_deng)=caculate(output_i,output_jjjj)*10^(output_q4-output_jjjj);
                        end
                    else
                        for output_jjj=output_deng+1:caculate_lie2
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
                flag=0;
                if(output_chu>output_jia)
                    for output_jjj=output_jia+1:output_chu-1
                        if(caculate(output_i,output_jjj)==15)
                            output_q1=output_jjj;
                            flag=1;
                        end
                    end
                    if(flag==1)
                        for output_jjjj=output_jia+1:output_q1-1
                            abc(output_i,output_jjjj-output_jia)=caculate(output_i,output_jjjj)*10^(output_q1-1-output_jjjj);
                        end
                        for output_jjjj=output_q1+1:output_chu-1
                            abc(output_i,output_jjjj-output_jia)=caculate(output_i,output_jjjj)*10^(output_q1-output_jjjj);
                        end
                    else
                        for output_jjj=output_jia+1:output_chu-1
                            abc(output_i,output_jjj-output_jia)=caculate(output_i,output_jjj)*10^(output_chu-1-output_jjj);
                        end
                    end
                    flag=0;
                    for output_jjj=output_chu+1:output_deng-1
                        if(caculate(output_i,output_jjj)==15)
                            output_q2=output_jjj;
                            flag=1;
                        end
                    end
                    if(flag==1)
                        for output_jjjj=output_chu+1:output_q2-1
                            abc1(output_i,output_jjjj-output_chu)=caculate(output_i,output_jjjj)*10^(output_q2-1-output_jjjj);
                        end
                        for output_jjjj=output_q2+1:output_deng-1
                            abc1(output_i,output_jjjj-output_chu)=caculate(output_i,output_jjjj)*10^(output_q2-output_jjjj);
                        end
                    else
                        for output_jjj=output_chu+1:output_deng-1
                            abc1(output_i,output_jjj-output_chu)=caculate(output_i,output_jjj)*10^(output_deng-1-output_jjjj);
                        end
                    end
                    flag=0;
                    for output_jjj=1:output_jia-1
                        if(caculate(output_i,output_jjj)==15)
                            output_q3=output_jjj;
                            flag=1;
                        end
                    end
                    if(flag==1)
                        for output_jjjj=1:output_q3-1
                            abc2(output_i,output_jjjj)=caculate(output_i,output_jjjj)*10^(output_q3-1-output_jjjj);
                        end
                        for output_jjjj=output_q3+1:output_jia-1
                            abc2(output_i,output_jjjj)=caculate(output_i,output_jjjj)*10^(output_q3-output_jjjj);
                        end
                    else
                        for output_jjj=1:output_jia-1
                            abc2(output_i,output_jjj)=caculate(output_i,output_jjj)*10^(output_jia-1-output_jjj);
                        end
                    end
                    flag=0;
                    for output_jjj=output_deng+1:caculate_lie2
                        if(caculate(output_i,output_jjj)==15)
                            output_q4=output_jjj;
                            flag=1;
                        end
                    end
                    if(flag==1)
                        for output_jjjj=output_deng+1:output_q4-1
                            result_ghi(output_i,output_jjjj-output_deng)=caculate(output_i,output_jjjj)*10^(output_q4-1-output_jjjj);
                        end
                        for output_jjjj=output_q4+1:caculate_lie2
                            result_ghi(output_i,output_jjjj-output_deng)=caculate(output_i,output_jjjj)*10^(output_q4-output_jjjj);
                        end
                    else
                        for output_jjj=output_deng+1:caculate_lie2
                            result_ghi(output_i,output_jjj-output_deng)=caculate(output_i,output_jjj)*10^(caculate_lie2-output_jjj);
                        end
                    end
                else
                    flag=0;
                    for output_jjj=1:output_chu-1
                        if(caculate(output_i,output_jjj)==15)
                            output_q1=output_jjj;
                            flag=1;
                        end
                    end
                    if(flag==1)
                        for output_jjjj=1:output_q1-1
                            abc(output_i,output_jjjj)=caculate(output_i,output_jjjj)*10^(output_q1-1-output_jjjj);
                        end
                        for output_jjjj=output_q1+1:output_chu-1
                            abc(output_i,output_jjjj)=caculate(output_i,output_jjjj)*10^(output_q1-output_jjjj);
                        end
                    else
                        for output_jjj=1:output_chu-1
                            abc(output_i,output_jjj)=caculate(output_i,output_jjj)*10^(output_chu-1-output_jjj);
                        end
                    end
                    flag=0;
                    for output_jjj=output_chu+1:output_jian-1
                        if(caculate(output_i,output_jjj)==15)
                            output_q2=output_jjj;
                            flag=1;
                        end
                    end
                    if(flag==1)
                        for output_jjjj=output_chu+1:output_q2-1
                            abc1(output_i,output_jjjj-output_chu)=caculate(output_i,output_jjjj)*10^(output_q2-1-output_jjjj);
                        end
                        for output_jjjj=output_q2+1:output_jian-1
                            abc1(output_i,output_jjjj-output_chu)=caculate(output_i,output_jjjj)*10^(output_q2-output_jjjj);
                        end
                    else
                        for output_jjj=output_chu+1:output_jian-1
                            abc1(output_i,output_jjj-output_chu)=caculate(output_i,output_jjj)*10^(output_jian-1-output_jjjj);
                        end
                    end
                    flag=0;
                    for output_jjj=output_jian+1:output_deng-1
                        if(caculate(output_i,output_jjj)==15)
                            output_q3=output_jjj;
                            flag=1;
                        end
                    end
                    if(flag==1)
                        for output_jjjj=output_jian+1:output_q3-1
                            abc2(output_i,output_jjjj-output_jian)=caculate(output_i,output_jjjj)*10^(output_q3-1-output_jjjj);
                        end
                        for output_jjjj=output_q3+1:output_deng-1
                            abc2(output_i,output_jjjj-output_jian)=caculate(output_i,output_jjjj)*10^(output_q3-output_jjjj);
                        end
                    else
                        for output_jjj=output_jian+1:output_deng-1
                            abc2(output_i,output_jjj-output_jian)=caculate(output_i,output_jjj)*10^(output_deng-1-output_jjj);
                        end
                    end
                    flag=0;
                    for output_jjj=output_deng+1:caculate_lie2
                        if(caculate(output_i,output_jjj)==15)
                            output_q4=output_jjj;
                            flag=1;
                        end
                    end
                    if(flag==1)
                        for output_jjjj=output_deng+1:output_q4-1
                            result_ghi(output_i,output_jjjj-output_deng)=caculate(output_i,output_jjjj)*10^(output_q4-1-output_jjjj);
                        end
                        for output_jjjj=output_q4+1:caculate_lie2
                            result_ghi(output_i,output_jjjj-output_deng)=caculate(output_i,output_jjjj)*10^(output_q4-output_jjjj);
                        end
                    else
                        for output_jjj=output_deng+1:caculate_lie2
                            result_ghi(output_i,output_jjj-output_deng)=caculate(output_i,output_jjj)*10^(caculate_lie2-output_jjj);
                        end
                    end
                end
            elseif(chufa==1&&jianfa==1)
                if(output_chu>output_jianfa)
                    jkl1(output_i,1)=caculate(output_i,output_chu);
                    jkl2(output_i,1)=caculate(output_i,output_jian);
                else
                    jkl1(output_i,1)=caculate(output_i,output_chu);
                    jkl(output_i,1)=caculate(output_i,output_jian);
                end
                flag=0;
                if(output_chu>output_jian)
                    for output_jjj=output_jian+1:output_chu-1
                        if(caculate(output_i,output_jjj)==15)
                            output_q1=output_jjj;
                            flag=1;
                        end
                    end
                    if(flag==1)
                        for output_jjjj=output_jian+1:output_q1-1
                            abc(output_i,output_jjjj-output_jian)=caculate(output_i,output_jjjj)*10^(output_q1-1-output_jjjj);
                        end
                        for output_jjjj=output_q1+1:output_chu-1
                            abc(output_i,output_jjjj-output_jian)=caculate(output_i,output_jjjj)*10^(output_q1-output_jjjj);
                        end
                    else
                        for output_jjj=output_jian+1:output_chu-1
                            abc(output_i,output_jjj-output_jian)=caculate(output_i,output_jjj)*10^(output_chu-1-output_jjj);
                        end
                    end
                    flag=0;
                    for output_jjj=output_chu+1:output_deng-1
                        if(caculate(output_i,output_jjj)==15)
                            output_q2=output_jjj;
                            flag=1;
                        end
                    end
                    if(flag==1)
                        for output_jjjj=output_chu+1:output_q2-1
                            abc1(output_i,output_jjjj-output_chu)=caculate(output_i,output_jjjj)*10^(output_q2-1-output_jjjj);
                        end
                        for output_jjjj=output_q2+1:output_deng-1
                            abc1(output_i,output_jjjj-output_chu)=caculate(output_i,output_jjjj)*10^(output_q2-output_jjjj);
                        end
                    else
                        for output_jjj=output_chu+1:output_deng-1
                            abc1(output_i,output_jjj-output_chu)=caculate(output_i,output_jjj)*10^(output_deng-1-output_jjjj);
                        end
                    end
                    flag=0;
                    for output_jjj=1:output_jian-1
                        if(caculate(output_i,output_jjj)==15)
                            output_q3=output_jjj;
                            flag=1;
                        end
                    end
                    if(flag==1)
                        for output_jjjj=1:output_q3-1
                            abc2(output_i,output_jjjj)=caculate(output_i,output_jjjj)*10^(output_q3-1-output_jjjj);
                        end
                        for output_jjjj=output_q3+1:output_jian-1
                            abc2(output_i,output_jjjj)=caculate(output_i,output_jjjj)*10^(output_q3-output_jjjj);
                        end
                    else
                        for output_jjj=1:output_jian-1
                            abc2(output_i,output_jjj)=caculate(output_i,output_jjj)*10^(output_jian-1-output_jjj);
                        end
                    end
                    flag=0;
                    for output_jjj=output_deng+1:caculate_lie2
                        if(caculate(output_i,output_jjj)==15)
                            output_q4=output_jjj;
                            flag=1;
                        end
                    end
                    if(flag==1)
                        for output_jjjj=output_deng+1:output_q4-1
                            result_ghi(output_i,output_jjjj-output_deng)=caculate(output_i,output_jjjj)*10^(output_q4-1-output_jjjj);
                        end
                        for output_jjjj=output_q4+1:caculate_lie2
                            result_ghi(output_i,output_jjjj-output_deng)=caculate(output_i,output_jjjj)*10^(output_q4-output_jjjj);
                        end
                    else
                        for output_jjj=output_deng+1:caculate_lie
                            result_ghi(output_i,output_jjj-output_deng)=caculate(output_i,output_jjj)*10^(caculate_lie2-output_jjj);
                        end
                    end
                else
                    flag=0;
                    for output_jjj=1:output_chu-1
                        if(caculate(output_i,output_jjj)==15)
                            output_q1=output_jjj;
                            flag=1;
                        end
                    end
                    if(flag==1)
                        for output_jjjj=1:output_q1-1
                            abc(output_i,output_jjjj)=caculate(output_i,output_jjjj)*10^(output_q1-1-output_jjjj);
                        end
                        for output_jjjj=output_q1+1:output_chu-1
                            abc(output_i,output_jjjj)=caculate(output_i,output_jjjj)*10^(output_q1-output_jjjj);
                        end
                    else
                        for output_jjj=1:output_chu-1
                            abc(output_i,output_jjj)=caculate(output_i,output_jjj)*10^(output_chu-1-output_jjj);
                        end
                    end
                    flag=0;
                    for output_jjj=output_chu+1:output_jian-1
                        if(caculate(output_i,output_jjj)==15)
                            output_q2=output_jjj;
                            flag=1;
                        end
                    end
                    if(flag==1)
                        for output_jjjj=output_chu+1:output_q2-1
                            abc1(output_i,output_jjjj-output_chu)=caculate(output_i,output_jjjj)*10^(output_q2-1-output_jjjj);
                        end
                        for output_jjjj=output_q2+1:output_jian-1
                            abc1(output_i,output_jjjj-output_chu)=caculate(output_i,output_jjjj)*10^(output_q2-output_jjjj);
                        end
                    else
                        for output_jjj=output_chu+1:output_jian-1
                            abc1(output_i,output_jjj-output_chu)=caculate(output_i,output_jjj)*10^(output_jian-1-output_jjjj);
                        end
                    end
                    flag=0;
                    for output_jjj=output_jian+1:output_deng-1
                        if(caculate(output_i,output_jjj)==15)
                            output_q3=output_jjj;
                            flag=1;
                        end
                    end
                    if(flag==1)
                        for output_jjjj=output_jian+1:output_q3-1
                            abc2(output_i,output_jjjj-output_jian)=caculate(output_i,output_jjjj)*10^(output_q3-1-output_jjjj);
                        end
                        for output_jjjj=output_q3+1:output_deng-1
                            abc2(output_i,output_jjjj-output_jian)=caculate(output_i,output_jjjj)*10^(output_q3-output_jjjj);
                        end
                    else
                        for output_jjj=output_jian+1:output_deng-1
                            abc2(output_i,output_jjj-output_jian)=caculate(output_i,output_jjj)*10^(output_deng-1-output_jjj);
                        end
                    end
                    flag=0;
                    for output_jjj=output_deng+1:caculate_lie2
                        if(caculate(output_i,output_jjj)==15)
                            output_q4=output_jjj;
                            flag=1;
                        end
                    end
                    if(flag==1)
                        for output_jjjj=output_deng+1:output_q4-1
                            result_ghi(output_i,output_jjjj-output_deng)=caculate(output_i,output_jjjj)*10^(output_q4-1-output_jjjj);
                        end
                        for output_jjjj=output_q4+1:caculate_lie2
                            result_ghi(output_i,output_jjjj-output_deng)=caculate(output_i,output_jjjj)*10^(output_q4-output_jjjj);
                        end
                    else
                        for output_jjj=output_deng+1:caculate_lie2
                            result_ghi(output_i,output_jjj-output_deng)=caculate(output_i,output_jjj)*10^(caculate_lie2-output_jjj);
                        end
                    end
                end
            end
        else            
            if(output_a==1)
                output_e=output_b+1;
                jkl(output_i,1)=caculate(output_i,output_e);
                flag=0;
                for output_j=output_a+1:output_c-1
                    if(caculate(output_i,output_j)==15)
                        output_g=output_j;
                        flag=1;
                    end
                end
                if(flag==1)
                    for output_jj=output_a+1:output_g-1
                        abc(output_i,output_jj-output_a)=caculate(output_i,output_jj)*10^(output_g-1-output_jj);
                    end
                    for output_jj=output_g+1:output_c-1
                        abc(output_i,output_jj-output_a)=caculate(output_i,output_jj)*10^(output_g-output_jj);
                    end
                else
                    for output_j=output_a+1:output_c-1
                        abc(output_i,output_j-output_a)=caculate(output_i,output_j)*10^(output_c-1-output_j);
                    end
                end
                flag=0;
                for output_j=output_c+1:output_b-1
                    if(caculate(output_i,output_j)==15)
                        output_g1=output_j;
                        flag=1;
                    end
                end
                if(flag==1)
                    for output_jj=output_c+1:output_g1-1
                        abc1(output_i,output_jj-output_c)=caculate(output_i,output_jj)*10^(output_g1-1-output_jj);
                    end
                    for output_jj=output_g1+1:output_b-1
                        abc1(output_i,output_jj-output_c)=caculate(output_i,output_jj)*10^(output_g1-output_jj);
                    end
                else
                    for output_j=output_c+1:output_b-1
                        abc1(output_i,output_j-output_c)=caculate(output_i,output_j)*10^(output_b-1-output_j);
                    end
                end
                flag=0;
                for output_j=output_e+1:output_d-1
                    if(caculate(output_i,output_j)==15)
                        output_g2=output_j;
                        flag=1;
                    end
                end
                if(flag==1)
                    for output_jj=output_e+1:output_g2-1
                        abc2(output_i,output_jj-output_e)=caculate(output_i,output_jj)*10^(output_g2-1-output_jj);
                    end
                    for output_jj=output_g2+1:output_d-1
                        abc2(output_i,output_jj-output_e)=caculate(output_i,output_jj)*10^(output_g2-output_jj);
                    end
                else
                    for output_j=output_e+1:output_d-1
                        abc2(output_i,output_j-output_e)=caculate(output_i,output_j)*10^(output_d-1-output_j);
                    end
                end
                flag=0;
                for output_j=output_d+1:caculate_lie2
                    if(caculate(output_i,output_j)==15)
                        output_g3=output_j;
                        flag=1;
                    end
                end
                if(flag==1)
                    for output_jj=output_d+1:output_g3-1
                        result_ghi(output_i,output_jj-output_d)=caculate(output_i,output_jj)*10^(output_g3-1-output_jj);
                    end
                    for output_jj=output_g3+1:caculate_lie2
                        result_ghi(output_i,output_jj-output_d)=caculate(output_i,output_jj)*10^(output_g3-output_jj);
                    end
                else
                    for output_j=output_d+1:caculate_lie2
                        result_ghi(output_i,output_j-output_d)=caculate(output_i,output_j)*10^(caculate_lie2-output_j);
                    end
                end   
            else
                output_e=output_a-1;
                if(caculate(output_i,output_e)==11||caculate(output_i,output_e)==13)
                    jkl2(output_i,1)=caculate(output_i,output_e);
                else
                    jkl(output_i,1)=caculate(output_i,output_e);
                end
                flag=0;
                for output_j=1:output_e-1
                    if(caculate(output_i,output_j)==15)
                        output_g4=output_j;
                        flag=1;
                    end
                end
                if(flag==1)
                    for output_jj=1:output_g4-1
                        abc2(output_i,output_jj)=caculate(output_i,output_jj)*10^(output_g4-1-output_jj);
                    end
                    for output_jj=output_g4+1:output_e-1
                        abc2(output_i,output_jj)=caculate(output_i,output_jj)*10^(output_g4-output_jj);
                    end
                else
                    for output_j=1:output_e-1
                        abc2(output_i,output_j)=caculate(output_i,output_j)*10^(output_e-1-output_j);
                    end
                end
                flag=0;
                for output_j=output_a+1:output_c-1
                    if(caculate(output_i,output_j)==15)
                        output_g5=output_j;
                        flag=1;
                    end
                end
                if(flag==1)
                    for output_jj=output_a+1:output_g5-1
                        abc(output_i,output_jj-output_a)=caculate(output_i,output_jj)*10^(output_g5-1-output_jj);
                    end
                    for output_jj=output_g5+1:output_c-1
                        abc(output_i,output_jj-output_a)=caculate(output_i,output_jj)*10^(output_g5-output_jj);
                    end
                else
                    for output_j=output_a+1:output_c-1
                        abc(output_i,output_j-output_a)=caculate(output_i,output_j)*10^(output_c-1-output_j);
                    end
                end
                flag=0;
                for output_j=output_c+1:output_b-1
                    if(caculate(output_i,output_j)==15)
                        output_g6=output_j;
                        flag=1;
                    end
                end
                if(flag==1)
                    for output_jj=output_c+1:output_g6-1
                        abc1(output_i,output_jj-output_c)=caculate(output_i,output_jj)*10^(output_g6-1-output_jj);
                    end
                    for output_jj=output_g6+1:output_b-1
                        abc1(output_i,output_jj-output_c)=caculate(output_i,output_jj)*10^(output_g6-output_jj);
                    end
                else
                    for output_j=output_c+1:output_b-1
                        abc1(output_i,output_j-output_c)=caculate(output_i,output_j)*10^(output_b-1-output_j);
                    end
                end
                flag=0;
                for output_j=output_d+1:caculate_lie2
                    if(caculate(output_i,output_j)==15)
                        output_g7=output_j;
                        flag=1;
                    end
                end
                if(flag==1)
                    for output_jj=output_d+1:output_g7-1
                        result_ghi(output_i,output_jj-output_d)=caculate(output_i,output_jj)*10^(output_g7-1-output_jj);
                    end
                    for output_jj=output_g7+1:caculate_lie2
                        result_ghi(output_i,output_jj-output_d)=caculate(output_i,output_jj)*10^(output_g7-output_jj);
                    end
                else
                    for output_j=output_d+1:caculate_lie2
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
disp(jkl2);
disp(result_ghi);
T_image=imread('Ttrue.jpg');
T_image1=double(T_image);
F_image=imread('Ffalse.jpg');
F_image1=double(F_image);
jst_chuli=imread('yuanshi.bmp');
jst_chuli1=double(jst_chuli);
uio_left=zeros(bw_hang_num,2);
uio_right=zeros(bw_hang_num,2);
jst_px0=1;
jst_px1=1;
bw_hang_num=hang_slice(Image_bw);
true_num=0;
for i=1:bw_hang_num%4
    while(matrix_bw_1(jst_px0,1)<1&&jst_px0<=Image_bw_m)
        jst_px0=jst_px0+1;
    end
    jst_px1=jst_px0;
    while(matrix_bw_1(jst_px1,1)>=1&&jst_px1<=Image_bw_m)
        jst_px1=jst_px1+1;
    end
    for ii=(2*i-1):2*i
        if(rem(ii,2)==1)
            if(kongyu>80)
                if(jkl1(ii,1)==10&&jkl(ii,1)==0&&jkl2(ii,1)==0)
                    if(sum(abc(ii,:))+sum(abc1(ii,:))==sum(result_ghi(ii,:)))
                        jst_chuli(jst_px0:jst_px0+52,bw_sign1:bw_sign1+54,:)=T_image1;
                        true_num=true_num+1;
                    else
                        jst_chuli(jst_px0:jst_px0+52,bw_sign1+1:bw_sign1+1+54,:)=F_image1;
                        uio_left(i,1)=jst_px0;
                        uio_left(i,2)=jst_px1;
                    end
                elseif(jkl1(ii,1)==10&&jkl(ii,1)==10)
                    if(sum(abc(ii,:))+sum(abc1(ii,:))+sum(abc2(ii,:))==sum(result_ghi(ii,:)))
                        jst_chuli(jst_px0:jst_px0+52,bw_sign1:bw_sign1+54,:)=T_image1;
                        true_num=true_num+1;
                    else
                        jst_chuli(jst_px0:jst_px0+52,bw_sign1+1:bw_sign1+1+54,:)=F_image1;
                        uio_left(i,1)=jst_px0;
                        uio_left(i,2)=jst_px1;
                    end
                elseif(jkl1(ii,1)==10&&jkl(ii,1)==11)
                    if((sum(abc(ii,:))+sum(abc1(ii,:)))-sum(abc2(ii,:))==sum(result_ghi(ii,:)))
                        jst_chuli(jst_px0:jst_px0+52,bw_sign1:bw_sign1+54,:)=T_image1;
                        true_num=true_num+1;
                    else
                        jst_chuli(jst_px0:jst_px0+52,bw_sign1+1:bw_sign1+1+54,:)=F_image1;
                        uio_left(i,1)=jst_px0;
                        uio_left(i,2)=jst_px1;
                    end
                elseif(jkl1(ii,1)==10&&jkl2(ii,1)==11)
                    if(sum(abc2(ii,:))-(sum(abc(ii,:))+sum(abc1(ii,:)))==sum(result_ghi(ii,:)))
                        jst_chuli(jst_px0:jst_px0+52,bw_sign1:bw_sign1+54,:)=T_image1;
                        true_num=true_num+1;
                    else
                        jst_chuli(jst_px0:jst_px0+52,bw_sign1+1:bw_sign1+1+54,:)=F_image1;
                        uio_left(i,1)=jst_px0;
                        uio_left(i,2)=jst_px1;
                    end
                elseif(jkl1(ii,1)==10&&jkl(ii,1)==12)
                    if((sum(abc(ii,:))+sum(abc1(ii,:)))*sum(abc2(ii,:))==sum(result_ghi(ii,:)))
                        jst_chuli(jst_px0:jst_px0+52,bw_sign1:bw_sign1+54,:)=T_image1;
                        true_num=true_num+1;
                    else
                        jst_chuli(jst_px0:jst_px0+52,bw_sign1+1:bw_sign1+1+54,:)=F_image1;
                        uio_left(i,1)=jst_px0;
                        uio_left(i,2)=jst_px1;
                    end
                elseif(jkl1(ii,1)==10&&jkl(ii,1)==13)
                    if((sum(abc(ii,:))+sum(abc1(ii,:)))/sum(abc2(ii,:))==sum(result_ghi(ii,:)))
                        jst_chuli(jst_px0:jst_px0+52,bw_sign1:bw_sign1+54,:)=T_image1;
                        true_num=true_num+1;
                    else
                        jst_chuli(jst_px0:jst_px0+52,bw_sign1+1:bw_sign1+1+54,:)=F_image1;
                        uio_left(i,1)=jst_px0;
                        uio_left(i,2)=jst_px1;
                    end
                elseif(jkl1(ii,1)==10&&jkl2(ii,1)==13)
                    if(sum(abc2(ii,:))/(sum(abc(ii,:))+sum(abc1(ii,:)))==sum(result_ghi(ii,:)))
                        jst_chuli(jst_px0:jst_px0+52,bw_sign1:bw_sign1+54,:)=T_image1;
                        true_num=true_num+1;
                    else
                        jst_chuli(jst_px0:jst_px0+52,bw_sign1+1:bw_sign1+1+54,:)=F_image1;
                        uio_left(i,1)=jst_px0;
                        uio_left(i,2)=jst_px1;
                    end
                end
                if(jkl1(ii,1)==11&&jkl(ii,1)==0&&jkl2(ii,1)==0)
                    if(sum(abc(ii,:))-sum(abc1(ii,:))==sum(result_ghi(ii,:)))
                        jst_chuli(jst_px0:jst_px0+52,bw_sign1+1:bw_sign1+1+54,:)=T_image1;
                        true_num=true_num+1;
                    else
                        jst_chuli(jst_px0:jst_px0+52,bw_sign1+1:bw_sign1+1+54,:)=F_image1;
                        uio_left(i,1)=jst_px0;
                        uio_left(i,2)=jst_px1;
                    end
                elseif(jkl1(ii,1)==11&&jkl(ii,1)==10)
                    if((sum(abc(ii,:))-sum(abc1(ii,:)))+sum(abc2(ii,:))==sum(result_ghi(ii,:)))
                        jst_chuli(jst_px0:jst_px0+52,bw_sign1+1:bw_sign1+1+54,:)=T_image1;
                        true_num=true_num+1;
                    else
                        jst_chuli(jst_px0:jst_px0+52,bw_sign1+1:bw_sign1+1+54,:)=F_image1;
                        uio_left(i,1)=jst_px0;
                        uio_left(i,2)=jst_px1;
                    end
                elseif(jkl1(ii,1)==11&&jkl(ii,1)==11)
                    if((sum(abc(ii,:))-sum(abc1(ii,:)))-sum(abc2(ii,:))==sum(result_ghi(ii,:)))
                        jst_chuli(jst_px0:jst_px0+52,bw_sign1+1:bw_sign1+1+54,:)=T_image1;
                        true_num=true_num+1;
                    else
                        jst_chuli(jst_px0:jst_px0+52,bw_sign1+1:bw_sign1+1+54,:)=F_image1;
                        uio_left(i,1)=jst_px0;
                        uio_left(i,2)=jst_px1;
                    end
                elseif(jkl1(ii,1)==11&&jkl2(ii,1)==11)
                    if(sum(abc2(ii,:))-(sum(abc(ii,:))-sum(abc1(ii,:)))==sum(result_ghi(ii,:)))
                        jst_chuli(jst_px0:jst_px0+52,bw_sign1+1:bw_sign1+1+54,:)=T_image1;
                        true_num=true_num+1;
                    else
                        jst_chuli(jst_px0:jst_px0+52,bw_sign1+1:bw_sign1+1+54,:)=F_image1;
                        uio_left(i,1)=jst_px0;
                        uio_left(i,2)=jst_px1;
                    end
                elseif(jkl1(ii,1)==11&&jkl(ii,1)==12)
                    if((sum(abc(ii,:))-sum(abc1(ii,:)))*sum(abc2(ii,:))==sum(result_ghi(ii,:)))
                        jst_chuli(jst_px0:jst_px0+52,bw_sign1+1:bw_sign1+1+54,:)=T_image1;
                        true_num=true_num+1;
                    else
                        jst_chuli(jst_px0:jst_px0+52,bw_sign1+1:bw_sign1+1+54,:)=F_image1;
                        uio_left(i,1)=jst_px0;
                        uio_left(i,2)=jst_px1;
                    end
                elseif(jkl1(ii,1)==11&&jkl(ii,1)==13)
                    if((sum(abc(ii,:))-sum(abc1(ii,:)))/sum(abc2(ii,:))==sum(result_ghi(ii,:)))
                        jst_chuli(jst_px0:jst_px0+52,bw_sign1+1:bw_sign1+1+54,:)=T_image1;
                        true_num=true_num+1;
                    else
                        jst_chuli(jst_px0:jst_px0+52,bw_sign1+1:bw_sign1+1+54,:)=F_image1;
                        uio_left(i,1)=jst_px0;
                        uio_left(i,2)=jst_px1;
                    end
                elseif(jkl1(ii,1)==11&&jkl2(ii,1)==13)
                    if(sum(abc2(ii,:))/(sum(abc(ii,:))-sum(abc1(ii,:)))==sum(result_ghi(ii,:)))
                        jst_chuli(jst_px0:jst_px0+52,bw_sign1+1:bw_sign1+1+54,:)=T_image1;
                        true_num=true_num+1;
                    else
                        jst_chuli(jst_px0:jst_px0+52,bw_sign1+1:bw_sign1+1+54,:)=F_image1;
                        uio_left(i,1)=jst_px0;
                        uio_left(i,2)=jst_px1;
                    end
                end
                if(jkl1(ii,1)==12&&jkl(ii,1)==0&&jkl2(ii,1)==0)
                    if(sum(abc(ii,:))*sum(abc1(ii,:))==sum(result_ghi(ii,:)))
                        jst_chuli(jst_px0:jst_px0+52,bw_sign1+1:bw_sign1+1+54,:)=T_image1;
                        true_num=true_num+1;
                    else
                        jst_chuli(jst_px0:jst_px0+52,bw_sign1+1:bw_sign1+1+54,:)=F_image1;
                        uio_left(i,1)=jst_px0;
                        uio_left(i,2)=jst_px1;
                    end
                elseif(jkl1(ii,1)==12&&jkl(ii,1)==10)
                    if((sum(abc(ii,:))*sum(abc1(ii,:)))+sum(abc2(ii,:))==sum(result_ghi(ii,:)))
                        jst_chuli(jst_px0:jst_px0+52,bw_sign1+1:bw_sign1+1+54,:)=T_image1;
                        true_num=true_num+1;
                    else
                        jst_chuli(jst_px0:jst_px0+52,bw_sign1+1:bw_sign1+1+54,:)=F_image1;
                        uio_left(i,1)=jst_px0;
                        uio_left(i,2)=jst_px1;
                    end
                elseif(jkl1(ii,1)==12&&jkl(ii,1)==11)
                    if((sum(abc(ii,:))*sum(abc1(ii,:)))-sum(abc2(ii,:))==sum(result_ghi(ii,:)))
                        jst_chuli(jst_px0:jst_px0+52,bw_sign1+1:bw_sign1+1+54,:)=T_image1;
                        true_num=true_num+1;
                    else
                        jst_chuli(jst_px0:jst_px0+52,bw_sign1+1:bw_sign1+1+54,:)=F_image1;
                        uio_left(i,1)=jst_px0;
                        uio_left(i,2)=jst_px1;
                    end
                elseif(jkl1(ii,1)==12&&jkl2(ii,1)==11)
                    if(sum(abc2(ii,:))-(sum(abc(ii,:))*sum(abc1(ii,:)))==sum(result_ghi(ii,:)))
                        jst_chuli(jst_px0:jst_px0+52,bw_sign1+1:bw_sign1+1+54,:)=T_image1;
                        true_num=true_num+1;
                    else
                        jst_chuli(jst_px0:jst_px0+52,bw_sign1+1:bw_sign1+1+54,:)=F_image1;
                        uio_left(i,1)=jst_px0;
                        uio_left(i,2)=jst_px1;
                    end
                elseif(jkl1(ii,1)==12&&jkl(ii,1)==12)
                    if((sum(abc(ii,:))*sum(abc1(ii,:)))*sum(abc2(ii,:))==sum(result_ghi(ii,:)))
                        jst_chuli(jst_px0:jst_px0+52,bw_sign1+1:bw_sign1+1+54,:)=T_image1;
                        true_num=true_num+1;
                    else
                        jst_chuli(jst_px0:jst_px0+52,bw_sign1+1:bw_sign1+1+54,:)=F_image1;
                        uio_left(i,1)=jst_px0;
                        uio_left(i,2)=jst_px1;
                    end
                elseif(jkl1(ii,1)==12&&jkl(ii,1)==13)
                    if((sum(abc(ii,:))*sum(abc1(ii,:)))/sum(abc2(ii,:))==sum(result_ghi(ii,:)))
                        jst_chuli(jst_px0:jst_px0+52,bw_sign1+1:bw_sign1+1+54,:)=T_image1;
                        true_num=true_num+1;
                    else
                        jst_chuli(jst_px0:jst_px0+52,bw_sign1+1:bw_sign1+1+54,:)=F_image1;
                        uio_left(i,1)=jst_px0;
                        uio_left(i,2)=jst_px1;
                    end
                elseif(jkl1(ii,1)==12&&jkl2(ii,1)==13)
                    if(sum(abc2(ii,:))/(sum(abc(ii,:))*sum(abc1(ii,:)))==sum(result_ghi(ii,:)))
                        jst_chuli(jst_px0:jst_px0+52,bw_sign1+1:bw_sign1+1+54,:)=T_image1;
                        true_num=true_num+1;
                    else
                        jst_chuli(jst_px0:jst_px0+52,bw_sign1+1:bw_sign1+1+54,:)=F_image1;
                        uio_left(i,1)=jst_px0;
                        uio_left(i,2)=jst_px1;
                    end
                end
                if(jkl1(ii,1)==13&&jkl(ii,1)==0&&jkl2(ii,1)==0)
                    if(sum(abc(ii,:))/sum(abc1(ii,:))==sum(result_ghi(ii,:)))
                        jst_chuli(jst_px0:jst_px0+52,bw_sign1+1:bw_sign1+1+54,:)=T_image1;
                        true_num=true_num+1;
                    else
                        jst_chuli(jst_px0:jst_px0+52,bw_sign1+1:bw_sign1+1+54,:)=F_image1;
                        uio_left(i,1)=jst_px0;
                        uio_left(i,2)=jst_px1;
                    end
                elseif(jkl1(ii,1)==13&&jkl(ii,1)==10)
                    if((sum(abc(ii,:))/sum(abc1(ii,:)))+sum(abc2(ii,:))==sum(result_ghi(ii,:)))
                        jst_chuli(jst_px0:jst_px0+52,bw_sign1+1:bw_sign1+1+54,:)=T_image1;
                        true_num=true_num+1;
                    else
                        jst_chuli(jst_px0:jst_px0+52,bw_sign1+1:bw_sign1+1+54,:)=F_image1;
                        uio_left(i,1)=jst_px0;
                        uio_left(i,2)=jst_px1;
                    end
                elseif(jkl1(ii,1)==13&&jkl(ii,1)==11)
                    if((sum(abc(ii,:))/sum(abc1(ii,:)))-sum(abc2(ii,:))==sum(result_ghi(ii,:)))
                        jst_chuli(jst_px0:jst_px0+52,bw_sign1+1:bw_sign1+1+54,:)=T_image1;
                        true_num=true_num+1;
                    else
                        jst_chuli(jst_px0:jst_px0+52,bw_sign1+1:bw_sign1+1+54,:)=F_image1;
                        uio_left(i,1)=jst_px0;
                        uio_left(i,2)=jst_px1;
                    end
                elseif(jkl1(ii,1)==13&&jkl2(ii,1)==11)
                    if(sum(abc2(ii,:))-(sum(abc(ii,:))/sum(abc1(ii,:)))==sum(result_ghi(ii,:)))
                        jst_chuli(jst_px0:jst_px0+52,bw_sign1+1:bw_sign1+1+54,:)=T_image1;
                        true_num=true_num+1;
                    else
                        jst_chuli(jst_px0:jst_px0+52,bw_sign1+1:bw_sign1+1+54,:)=F_image1;
                        uio_left(i,1)=jst_px0;
                        uio_left(i,2)=jst_px1;
                    end
                elseif(jkl1(ii,1)==13&&jkl(ii,1)==12)
                    if((sum(abc(ii,:))/sum(abc1(ii,:)))*sum(abc2(ii,:))==sum(result_ghi(ii,:)))
                        jst_chuli(jst_px0:jst_px0+52,bw_sign1+1:bw_sign1+1+54,:)=T_image1;
                        true_num=true_num+1;
                    else
                        jst_chuli(jst_px0:jst_px0+52,bw_sign1+1:bw_sign1+1+54,:)=F_image1;
                        uio_left(i,1)=jst_px0;
                        uio_left(i,2)=jst_px1;
                    end
                elseif(jkl1(ii,1)==13&&jkl(ii,1)==13)
                    if((sum(abc(ii,:))/sum(abc1(ii,:)))/sum(abc2(ii,:))==sum(result_ghi(ii,:)))
                        jst_chuli(jst_px0:jst_px0+52,bw_sign1+1:bw_sign1+1+54,:)=T_image1;
                        true_num=true_num+1;
                    else
                        jst_chuli(jst_px0:jst_px0+52,bw_sign1+1:bw_sign1+1+54,:)=F_image1;
                        uio_left(i,1)=jst_px0;
                        uio_left(i,2)=jst_px1;
                    end
                elseif(jkl1(ii,1)==13&&jkl2(ii,1)==13)
                    if(sum(abc2(ii,:))/(sum(abc(ii,:))/sum(abc1(ii,:)))==sum(result_ghi(ii,:)))
                        jst_chuli(jst_px0:jst_px0+52,bw_sign1+1:bw_sign1+1+54,:)=T_image1;
                        true_num=true_num+1;
                    else
                        jst_chuli(jst_px0:jst_px0+52,bw_sign1+1:bw_sign1+1+54,:)=F_image1;
                        uio_left(i,1)=jst_px0;
                        uio_left(i,2)=jst_px1;
                    end
                end
            else
                kongyu=min(kongyu,jst_px1-jst_px0);
                T_image=imresize(T_image,[kongyu-1,kongyu-1]);
                F_image=imresize(F_image,[kongyu-1,kongyu-1]);
                T_image1=double(T_image);
                F_image1=double(F_image);
                if(jkl1(ii,1)==10&&jkl(ii,1)==0&&jkl2(ii,1)==0)
                    if(sum(abc(ii,:))+sum(abc1(ii,:))==sum(result_ghi(ii,:)))
                        jst_chuli(jst_px0:jst_px0+kongyu-2,bw_sign1+1:bw_sign1+1+kongyu-2,:)=T_image1;
                        true_num=true_num+1;
                    else
                        jst_chuli(jst_px0:jst_px0+kongyu-2,bw_sign1+1:bw_sign1+1+kongyu-2,:)=F_image1;
                        uio_left(i,1)=jst_px0;
                        uio_left(i,2)=jst_px1;
                    end
                elseif(jkl1(ii,1)==10&&jkl(ii,1)==10)
                    if((sum(abc(ii,:))+sum(abc1(ii,:)))+sum(abc2(ii,:))==sum(result_ghi(ii,:)))
                        jst_chuli(jst_px0:jst_px0+kongyu-2,bw_sign1+1:bw_sign1+1+kongyu-2,:)=T_image1;
                        true_num=true_num+1;
                    else
                        jst_chuli(jst_px0:jst_px0+kongyu-2,bw_sign1+1:bw_sign1+1+kongyu-2,:)=F_image1;
                        uio_left(i,1)=jst_px0;
                        uio_left(i,2)=jst_px1;
                    end
                elseif(jkl1(ii,1)==10&&jkl(ii,1)==11)
                    if((sum(abc(ii,:))+sum(abc1(ii,:)))-sum(abc2(ii,:))==sum(result_ghi(ii,:)))
                        jst_chuli(jst_px0:jst_px0+kongyu-2,bw_sign1+1:bw_sign1+1+kongyu-2,:)=T_image1;
                        true_num=true_num+1;
                    else
                        jst_chuli(jst_px0:jst_px0+kongyu-2,bw_sign1+1:bw_sign1+1+kongyu-2,:)=F_image1;
                        uio_left(i,1)=jst_px0;
                        uio_left(i,2)=jst_px1;
                    end
                elseif(jkl1(ii,1)==10&&jkl2(ii,1)==11)
                    if(sum(abc2(ii,:))-(sum(abc(ii,:))+sum(abc1(ii,:)))==sum(result_ghi(ii,:)))
                        jst_chuli(jst_px0:jst_px0+kongyu-2,bw_sign1+1:bw_sign1+1+kongyu-2,:)=T_image1;
                        true_num=true_num+1;
                    else
                        jst_chuli(jst_px0:jst_px0+kongyu-2,bw_sign1+1:bw_sign1+1+kongyu-2,:)=F_image1;
                        uio_left(i,1)=jst_px0;
                        uio_left(i,2)=jst_px1;
                    end
                elseif(jkl1(ii,1)==10&&jkl(ii,1)==12)
                    if((sum(abc(ii,:))+sum(abc1(ii,:)))*sum(abc2(ii,:))==sum(result_ghi(ii,:)))
                        jst_chuli(jst_px0:jst_px0+kongyu-2,bw_sign1+1:bw_sign1+1+kongyu-2,:)=T_image1;
                        true_num=true_num+1;
                    else
                        jst_chuli(jst_px0:jst_px0+kongyu-2,bw_sign1+1:bw_sign1+1+kongyu-2,:)=F_image1;
                        uio_left(i,1)=jst_px0;
                        uio_left(i,2)=jst_px1;
                    end
                elseif(jkl1(ii,1)==10&&jkl(ii,1)==13)
                    if((sum(abc(ii,:))+sum(abc1(ii,:)))/sum(abc2(ii,:))==sum(result_ghi(ii,:)))
                        jst_chuli(jst_px0:jst_px0+kongyu-2,bw_sign1+1:bw_sign1+1+kongyu-2,:)=T_image1;
                        true_num=true_num+1;
                    else
                        jst_chuli(jst_px0:jst_px0+kongyu-2,bw_sign1+1:bw_sign1+1+kongyu-2,:)=F_image1;
                        uio_left(i,1)=jst_px0;
                        uio_left(i,2)=jst_px1;
                    end
                elseif(jkl1(ii,1)==10&&jkl2(ii,1)==13)
                    if(sum(abc2(ii,:))/(sum(abc(ii,:))+sum(abc1(ii,:)))==sum(result_ghi(ii,:)))
                        jst_chuli(jst_px0:jst_px0+kongyu-2,bw_sign1+1:bw_sign1+1+kongyu-2,:)=T_image1;
                        true_num=true_num+1;
                    else
                        jst_chuli(jst_px0:jst_px0+kongyu-2,bw_sign1+1:bw_sign1+1+kongyu-2,:)=F_image1;
                        uio_left(i,1)=jst_px0;
                        uio_left(i,2)=jst_px1;
                    end
                end
                if(jkl1(ii,1)==11&&jkl(ii,1)==0&&jkl2(ii,1)==0)
                    if(sum(abc(ii,:))-sum(abc1(ii,:))==sum(result_ghi(ii,:)))
                        jst_chuli(jst_px0:jst_px0+kongyu-2,bw_sign1+1:bw_sign1+1+kongyu-2,:)=T_image1;
                        true_num=true_num+1;
                    else
                        jst_chuli(jst_px0:jst_px0+kongyu-2,bw_sign1+1:bw_sign1+1+kongyu-2,:)=F_image1;
                        uio_left(i,1)=jst_px0;
                        uio_left(i,2)=jst_px1;
                    end
                elseif(jkl1(ii,1)==11&&jkl(ii,1)==10)
                    if((sum(abc(ii,:))-sum(abc1(ii,:)))+sum(abc2(ii,:))==sum(result_ghi(ii,:)))
                        jst_chuli(jst_px0:jst_px0+kongyu-2,bw_sign1+1:bw_sign1+1+kongyu-2,:)=T_image1;
                        true_num=true_num+1;
                    else
                        jst_chuli(jst_px0:jst_px0+kongyu-2,bw_sign1+1:bw_sign1+1+kongyu-2,:)=F_image1;
                        uio_left(i,1)=jst_px0;
                        uio_left(i,2)=jst_px1;
                    end
                elseif(jkl1(ii,1)==11&&jkl(ii,1)==11)
                    if((sum(abc(ii,:))-sum(abc1(ii,:)))-sum(abc2(ii,:))==sum(result_ghi(ii,:)))
                        jst_chuli(jst_px0:jst_px0+kongyu-2,bw_sign1+1:bw_sign1+1+kongyu-2,:)=T_image1;
                        true_num=true_num+1;
                    else
                        jst_chuli(jst_px0:jst_px0+kongyu-2,bw_sign1+1:bw_sign1+1+kongyu-2,:)=F_image1;
                        uio_left(i,1)=jst_px0;
                        uio_left(i,2)=jst_px1;
                    end
                elseif(jkl1(ii,1)==11&&jkl2(ii,1)==11)
                    if(sum(abc2(ii,:))-(sum(abc(ii,:))-sum(abc1(ii,:)))==sum(result_ghi(ii,:)))
                        jst_chuli(jst_px0:jst_px0+kongyu-2,bw_sign1+1:bw_sign1+1+kongyu-2,:)=T_image1;
                        true_num=true_num+1;
                    else
                        jst_chuli(jst_px0:jst_px0+kongyu-2,bw_sign1+1:bw_sign1+1+kongyu-2,:)=F_image1;
                        uio_left(i,1)=jst_px0;
                        uio_left(i,2)=jst_px1;
                    end
                elseif(jkl1(ii,1)==11&&jkl(ii,1)==12)
                    if((sum(abc(ii,:))-sum(abc1(ii,:)))*sum(abc2(ii,:))==sum(result_ghi(ii,:)))
                        jst_chuli(jst_px0:jst_px0+kongyu-2,bw_sign1+1:bw_sign1+1+kongyu-2,:)=T_image1;
                        true_num=true_num+1;
                    else
                        jst_chuli(jst_px0:jst_px0+kongyu-2,bw_sign1+1:bw_sign1+1+kongyu-2,:)=F_image1;
                        uio_left(i,1)=jst_px0;
                        uio_left(i,2)=jst_px1;
                    end
                elseif(jkl1(ii,1)==11&&jkl(ii,1)==13)
                    if((sum(abc(ii,:))-sum(abc1(ii,:)))/sum(abc2(ii,:))==sum(result_ghi(ii,:)))
                        jst_chuli(jst_px0:jst_px0+kongyu-2,bw_sign1+1:bw_sign1+1+kongyu-2,:)=T_image1;
                        true_num=true_num+1;
                    else
                        jst_chuli(jst_px0:jst_px0+kongyu-2,bw_sign1+1:bw_sign1+1+kongyu-2,:)=F_image1;
                        uio_left(i,1)=jst_px0;
                        uio_left(i,2)=jst_px1;
                    end
                elseif(jkl1(ii,1)==11&&jkl2(ii,1)==13)
                    if(sum(abc2(ii,:))/(sum(abc(ii,:))-sum(abc1(ii,:)))==sum(result_ghi(ii,:)))
                        jst_chuli(jst_px0:jst_px0+kongyu-2,bw_sign1+1:bw_sign1+1+kongyu-2,:)=T_image1;
                        true_num=true_num+1;
                    else
                        jst_chuli(jst_px0:jst_px0+kongyu-2,bw_sign1+1:bw_sign1+1+kongyu-2,:)=F_image1;
                        uio_left(i,1)=jst_px0;
                        uio_left(i,2)=jst_px1;
                    end
                end
                if(jkl1(ii,1)==12&&jkl(ii,1)==0&&jkl2(ii,1)==0)
                    if(sum(abc(ii,:))*sum(abc1(ii,:))==sum(result_ghi(ii,:)))
                        jst_chuli(jst_px0:jst_px0+kongyu-2,bw_sign1+1:bw_sign1+1+kongyu-2,:)=T_image1;
                        true_num=true_num+1;
                    else
                        jst_chuli(jst_px0:jst_px0+kongyu-2,bw_sign1+1:bw_sign1+1+kongyu-2,:)=F_image1;
                        uio_left(i,1)=jst_px0;
                        uio_left(i,2)=jst_px1;
                    end
                elseif(jkl1(ii,1)==12&&jkl(ii,1)==10)
                    if((sum(abc(ii,:))*sum(abc1(ii,:)))+sum(abc2(ii,:))==sum(result_ghi(ii,:)))
                        jst_chuli(jst_px0:jst_px0+kongyu-2,bw_sign1+1:bw_sign1+1+kongyu-2,:)=T_image1;
                        true_num=true_num+1;
                    else
                        jst_chuli(jst_px0:jst_px0+kongyu-2,bw_sign1+1:bw_sign1+1+kongyu-2,:)=F_image1;
                        uio_left(i,1)=jst_px0;
                        uio_left(i,2)=jst_px1;
                    end
                elseif(jkl1(ii,1)==12&&jkl(ii,1)==11)
                    if((sum(abc(ii,:))*sum(abc1(ii,:)))-sum(abc2(ii,:))==sum(result_ghi(ii,:)))
                        jst_chuli(jst_px0:jst_px0+kongyu-2,bw_sign1+1:bw_sign1+1+kongyu-2,:)=T_image1;
                        true_num=true_num+1;
                    else
                        jst_chuli(jst_px0:jst_px0+kongyu-2,bw_sign1+1:bw_sign1+1+kongyu-2,:)=F_image1;
                        uio_left(i,1)=jst_px0;
                        uio_left(i,2)=jst_px1;
                    end
                elseif(jkl1(ii,1)==12&&jkl2(ii,1)==11)
                    if(sum(abc2(ii,:))-(sum(abc(ii,:))*sum(abc1(ii,:)))==sum(result_ghi(ii,:)))
                        jst_chuli(jst_px0:jst_px0+kongyu-2,bw_sign1+1:bw_sign1+1+kongyu-2,:)=T_image1;
                        true_num=true_num+1;
                    else
                        jst_chuli(jst_px0:jst_px0+kongyu-2,bw_sign1+1:bw_sign1+1+kongyu-2,:)=F_image1;
                        uio_left(i,1)=jst_px0;
                        uio_left(i,2)=jst_px1;
                    end
                elseif(jkl1(ii,1)==12&&jkl(ii,1)==12)
                    if((sum(abc(ii,:))*sum(abc1(ii,:)))*sum(abc2(ii,:))==sum(result_ghi(ii,:)))
                        jst_chuli(jst_px0:jst_px0+kongyu-2,bw_sign1+1:bw_sign1+1+kongyu-2,:)=T_image1;
                        true_num=true_num+1;
                    else
                        jst_chuli(jst_px0:jst_px0+kongyu-2,bw_sign1+1:bw_sign1+1+kongyu-2,:)=F_image1;
                        uio_left(i,1)=jst_px0;
                        uio_left(i,2)=jst_px1;
                    end
                elseif(jkl1(ii,1)==12&&jkl(ii,1)==13)
                    if((sum(abc(ii,:))*sum(abc1(ii,:)))/sum(abc2(ii,:))==sum(result_ghi(ii,:)))
                        jst_chuli(jst_px0:jst_px0+kongyu-2,bw_sign1+1:bw_sign1+1+kongyu-2,:)=T_image1;
                        true_num=true_num+1;
                    else
                        jst_chuli(jst_px0:jst_px0+kongyu-2,bw_sign1+1:bw_sign1+1+kongyu-2,:)=F_image1;
                        uio_left(i,1)=jst_px0;
                        uio_left(i,2)=jst_px1;
                    end
                elseif(jkl1(ii,1)==12&&jkl2(ii,1)==13)
                    if(sum(abc2(ii,:))/(sum(abc(ii,:))*sum(abc1(ii,:)))==sum(result_ghi(ii,:)))
                        jst_chuli(jst_px0:jst_px0+kongyu-2,bw_sign1+1:bw_sign1+1+kongyu-2,:)=T_image1;
                        true_num=true_num+1;
                    else
                        jst_chuli(jst_px0:jst_px0+kongyu-2,bw_sign1+1:bw_sign1+1+kongyu-2,:)=F_image1;
                        uio_left(i,1)=jst_px0;
                        uio_left(i,2)=jst_px1;
                    end
                end
                if(jkl1(ii,1)==13&&jkl(ii,1)==0&&jkl2(ii,1)==0)
                    if(sum(abc(ii,:))/sum(abc1(ii,:))==sum(result_ghi(ii,:)))
                        jst_chuli(jst_px0:jst_px0+kongyu-2,bw_sign1+1:bw_sign1+1+kongyu-2,:)=T_image1;
                        true_num=true_num+1;
                    else
                        jst_chuli(jst_px0:jst_px0+kongyu-2,bw_sign1+1:bw_sign1+1+kongyu-2,:)=F_image1;
                        uio_left(i,1)=jst_px0;
                        uio_left(i,2)=jst_px1;
                    end
                elseif(jkl1(ii,1)==13&&jkl(ii,1)==10)
                    if((sum(abc(ii,:))/sum(abc1(ii,:)))+sum(abc2(ii,:))==sum(result_ghi(ii,:)))
                        jst_chuli(jst_px0:jst_px0+kongyu-2,bw_sign1+1:bw_sign1+1+kongyu-2,:)=T_image1;
                        true_num=true_num+1;
                    else
                        jst_chuli(jst_px0:jst_px0+kongyu-2,bw_sign1+1:bw_sign1+1+kongyu-2,:)=F_image1;
                        uio_left(i,1)=jst_px0;
                        uio_left(i,2)=jst_px1;
                    end
                elseif(jkl1(ii,1)==13&&jkl(ii,1)==11)
                    if((sum(abc(ii,:))/sum(abc1(ii,:)))-sum(abc2(ii,:))==sum(result_ghi(ii,:)))
                        jst_chuli(jst_px0:jst_px0+kongyu-2,bw_sign1+1:bw_sign1+1+kongyu-2,:)=T_image1;
                        true_num=true_num+1;
                    else
                        jst_chuli(jst_px0:jst_px0+kongyu-2,bw_sign1+1:bw_sign1+1+kongyu-2,:)=F_image1;
                        uio_left(i,1)=jst_px0;
                        uio_left(i,2)=jst_px1;
                    end
                elseif(jkl1(ii,1)==13&&jkl2(ii,1)==11)
                    if(sum(abc2(ii,:))-(sum(abc(ii,:))/sum(abc1(ii,:)))==sum(result_ghi(ii,:)))
                        jst_chuli(jst_px0:jst_px0+kongyu-2,bw_sign1+1:bw_sign1+1+kongyu-2,:)=T_image1;
                        true_num=true_num+1;
                    else
                        jst_chuli(jst_px0:jst_px0+kongyu-2,bw_sign1+1:bw_sign1+1+kongyu-2,:)=F_image1;
                        uio_left(i,1)=jst_px0;
                        uio_left(i,2)=jst_px1;
                    end
                elseif(jkl1(ii,1)==13&&jkl(ii,1)==12)
                    if((sum(abc(ii,:))/sum(abc1(ii,:)))*sum(abc2(ii,:))==sum(result_ghi(ii,:)))
                        jst_chuli(jst_px0:jst_px0+kongyu-2,bw_sign1+1:bw_sign1+1+kongyu-2,:)=T_image1;
                        true_num=true_num+1;
                    else
                        jst_chuli(jst_px0:jst_px0+kongyu-2,bw_sign1+1:bw_sign1+1+kongyu-2,:)=F_image1;
                        uio_left(i,1)=jst_px0;
                        uio_left(i,2)=jst_px1;
                    end
                elseif(jkl1(ii,1)==13&&jkl(ii,1)==13)
                    if((sum(abc(ii,:))/sum(abc1(ii,:)))/sum(abc2(ii,:))==sum(result_ghi(ii,:)))
                        jst_chuli(jst_px0:jst_px0+kongyu-2,bw_sign1+1:bw_sign1+1+kongyu-2,:)=T_image1;
                        true_num=true_num+1;
                    else
                        jst_chuli(jst_px0:jst_px0+kongyu-2,bw_sign1+1:bw_sign1+1+kongyu-2,:)=F_image1;
                        uio_left(i,1)=jst_px0;
                        uio_left(i,2)=jst_px1;
                    end
                elseif(jkl1(ii,1)==13&&jkl2(ii,1)==13)
                    if(sum(abc2(ii,:))/(sum(abc(ii,:))/sum(abc1(ii,:)))==sum(result_ghi(ii,:)))
                        jst_chuli(jst_px0:jst_px0+kongyu-2,bw_sign1+1:bw_sign1+1+kongyu-2,:)=T_image1;
                        true_num=true_num+1;
                    else
                        jst_chuli(jst_px0:jst_px0+kongyu-2,bw_sign1+1:bw_sign1+1+kongyu-2,:)=F_image1;
                        uio_left(i,1)=jst_px0;
                        uio_left(i,2)=jst_px1;
                    end
                end
            end
        else
            if(kongyu>80)
                if(jkl1(ii,1)==10&&jkl(ii,1)==0&&jkl2(ii,1)==0)
                    if(sum(abc(ii,:))+sum(abc1(ii,:))==sum(result_ghi(ii,:)))
                        jst_chuli(jst_px0:jst_px0+52,bw_b_max+1:bw_b_max+1+54,:)=T_image1;
                        true_num=true_num+1;
                    else
                        jst_chuli(jst_px0:jst_px0+52,bw_b_max+1:bw_b_max+1+54,:)=F_image1;
                        uio_right(i,1)=jst_px0;
                        uio_right(i,2)=jst_px1;
                    end
                elseif(jkl1(ii,1)==10&&jkl(ii,1)==10)
                    if((sum(abc(ii,:))+sum(abc1(ii,:)))+sum(abc2(ii,:))==sum(result_ghi(ii,:)))
                        jst_chuli(jst_px0:jst_px0+52,bw_b_max+1:bw_b_max+1+54,:)=T_image1;
                        true_num=true_num+1;
                    else
                        jst_chuli(jst_px0:jst_px0+52,bw_b_max+1:bw_b_max+1+54,:)=F_image1;
                        uio_right(i,1)=jst_px0;
                        uio_right(i,2)=jst_px1;
                    end
                elseif(jkl1(ii,1)==10&&jkl(ii,1)==11)
                    if((sum(abc(ii,:))+sum(abc1(ii,:)))-sum(abc2(ii,:))==sum(result_ghi(ii,:)))
                        jst_chuli(jst_px0:jst_px0+52,bw_b_max+1:bw_b_max+1+54,:)=T_image1;
                        true_num=true_num+1;
                    else
                        jst_chuli(jst_px0:jst_px0+52,bw_b_max+1:bw_b_max+1+54,:)=F_image1;
                        uio_right(i,1)=jst_px0;
                        uio_right(i,2)=jst_px1;
                    end
                elseif(jkl1(ii,1)==10&&jkl2(ii,1)==11)
                    if(sum(abc2(ii,:))-(sum(abc(ii,:))+sum(abc1(ii,:)))==sum(result_ghi(ii,:)))
                        jst_chuli(jst_px0:jst_px0+52,bw_b_max+1:bw_b_max+1+54,:)=T_image1;
                        true_num=true_num+1;
                    else
                        jst_chuli(jst_px0:jst_px0+52,bw_b_max+1:bw_b_max+1+54,:)=F_image1;
                        uio_right(i,1)=jst_px0;
                        uio_right(i,2)=jst_px1;
                    end
                elseif(jkl1(ii,1)==10&&jkl(ii,1)==12)
                    if((sum(abc(ii,:))+sum(abc1(ii,:)))*sum(abc2(ii,:))==sum(result_ghi(ii,:)))
                        jst_chuli(jst_px0:jst_px0+52,bw_b_max+1:bw_b_max+1+54,:)=T_image1;
                        true_num=true_num+1;
                    else
                        jst_chuli(jst_px0:jst_px0+52,bw_b_max+1:bw_b_max+1+54,:)=F_image1;
                        uio_right(i,1)=jst_px0;
                        uio_right(i,2)=jst_px1;
                    end
                elseif(jkl1(ii,1)==10&&jkl(ii,1)==13)
                    if((sum(abc(ii,:))+sum(abc1(ii,:)))/sum(abc2(ii,:))==sum(result_ghi(ii,:)))
                        jst_chuli(jst_px0:jst_px0+52,bw_b_max+1:bw_b_max+1+54,:)=T_image1;
                        true_num=true_num+1;
                    else
                        jst_chuli(jst_px0:jst_px0+52,bw_b_max+1:bw_b_max+1+54,:)=F_image1;
                        uio_right(i,1)=jst_px0;
                        uio_right(i,2)=jst_px1;
                    end
                elseif(jkl1(ii,1)==10&&jkl2(ii,1)==13)
                    if(sum(abc2(ii,:))/(sum(abc(ii,:))+sum(abc1(ii,:)))==sum(result_ghi(ii,:)))
                        jst_chuli(jst_px0:jst_px0+52,bw_b_max+1:bw_b_max+1+54,:)=T_image1;
                        true_num=true_num+1;
                    else
                        jst_chuli(jst_px0:jst_px0+52,bw_b_max+1:bw_b_max+1+54,:)=F_image1;
                        uio_right(i,1)=jst_px0;
                        uio_right(i,2)=jst_px1;
                    end
                end
                if(jkl1(ii,1)==11&&jkl(ii,1)==0&&jkl2(ii,1)==0)
                    if(sum(abc(ii,:))-sum(abc1(ii,:))==sum(result_ghi(ii,:)))
                        jst_chuli(jst_px0:jst_px0+52,bw_b_max+1:bw_b_max+1+54,:)=T_image1;
                        true_num=true_num+1;
                    else
                        jst_chuli(jst_px0:jst_px0+52,bw_b_max+1:bw_b_max+1+54,:)=F_image1;
                        uio_right(i,1)=jst_px0;
                        uio_right(i,2)=jst_px1;
                    end
                elseif(jkl1(ii,1)==11&&jkl(ii,1)==10)
                    if((sum(abc(ii,:))-sum(abc1(ii,:)))+sum(abc2(ii,:))==sum(result_ghi(ii,:)))
                        jst_chuli(jst_px0:jst_px0+52,bw_b_max+1:bw_b_max+1+54,:)=T_image1;
                        true_num=true_num+1;
                    else
                        jst_chuli(jst_px0:jst_px0+52,bw_b_max+1:bw_b_max+1+54,:)=F_image1;
                        uio_right(i,1)=jst_px0;
                        uio_right(i,2)=jst_px1;
                    end
                elseif(jkl1(ii,1)==11&&jkl(ii,1)==11)
                    if((sum(abc(ii,:))-sum(abc1(ii,:)))-sum(abc2(ii,:))==sum(result_ghi(ii,:)))
                        jst_chuli(jst_px0:jst_px0+52,bw_b_max+1:bw_b_max+1+54,:)=T_image1;
                        true_num=true_num+1;
                    else
                        jst_chuli(jst_px0:jst_px0+52,bw_b_max+1:bw_b_max+1+54,:)=F_image1;
                        uio_right(i,1)=jst_px0;
                        uio_right(i,2)=jst_px1;
                    end
                elseif(jkl1(ii,1)==11&&jkl2(ii,1)==11)
                    if(sum(abc2(ii,:))-(sum(abc(ii,:))-sum(abc1(ii,:)))==sum(result_ghi(ii,:)))
                        jst_chuli(jst_px0:jst_px0+52,bw_b_max+1:bw_b_max+1+54,:)=T_image1;
                        true_num=true_num+1;
                    else
                        jst_chuli(jst_px0:jst_px0+52,bw_b_max+1:bw_b_max+1+54,:)=F_image1;
                        uio_right(i,1)=jst_px0;
                        uio_right(i,2)=jst_px1;
                    end
                elseif(jkl1(ii,1)==11&&jkl(ii,1)==12)
                    if((sum(abc(ii,:))-sum(abc1(ii,:)))*sum(abc2(ii,:))==sum(result_ghi(ii,:)))
                        jst_chuli(jst_px0:jst_px0+52,bw_b_max+1:bw_b_max+1+54,:)=T_image1;
                        true_num=true_num+1;
                    else
                        jst_chuli(jst_px0:jst_px0+52,bw_b_max+1:bw_b_max+1+54,:)=F_image1;
                        uio_right(i,1)=jst_px0;
                        uio_right(i,2)=jst_px1;
                    end
                elseif(jkl1(ii,1)==11&&jkl(ii,1)==13)
                    if((sum(abc(ii,:))-sum(abc1(ii,:)))/sum(abc2(ii,:))==sum(result_ghi(ii,:)))
                        jst_chuli(jst_px0:jst_px0+52,bw_b_max+1:bw_b_max+1+54,:)=T_image1;
                        true_num=true_num+1;
                    else
                        jst_chuli(jst_px0:jst_px0+52,bw_b_max+1:bw_b_max+1+54,:)=F_image1;
                        uio_right(i,1)=jst_px0;
                        uio_right(i,2)=jst_px1;
                    end
                elseif(jkl1(ii,1)==11&&jkl2(ii,1)==13)
                    if(sum(abc2(ii,:))/(sum(abc(ii,:))-sum(abc1(ii,:)))==sum(result_ghi(ii,:)))
                        jst_chuli(jst_px0:jst_px0+52,bw_b_max+1:bw_b_max+1+54,:)=T_image1;
                        true_num=true_num+1;
                    else
                        jst_chuli(jst_px0:jst_px0+52,bw_b_max+1:bw_b_max+1+54,:)=F_image1;
                        uio_right(i,1)=jst_px0;
                        uio_right(i,2)=jst_px1;
                    end
                end
                if(jkl1(ii,1)==12&&jkl(ii,1)==0&&jkl2(ii,1)==0)
                    if(sum(abc(ii,:))*sum(abc1(ii,:))==sum(result_ghi(ii,:)))
                        jst_chuli(jst_px0:jst_px0+52,bw_b_max+1:bw_b_max+1+54,:)=T_image1;
                        true_num=true_num+1;
                    else
                        jst_chuli(jst_px0:jst_px0+52,bw_b_max+1:bw_b_max+1+54,:)=F_image1;
                        uio_right(i,1)=jst_px0;
                        uio_right(i,2)=jst_px1;
                    end
                elseif(jkl1(ii,1)==12&&jkl(ii,1)==10)
                    if((sum(abc(ii,:))*sum(abc1(ii,:)))+sum(abc2(ii,:))==sum(result_ghi(ii,:)))
                        jst_chuli(jst_px0:jst_px0+52,bw_b_max+1:bw_b_max+1+54,:)=T_image1;
                        true_num=true_num+1;
                    else
                        jst_chuli(jst_px0:jst_px0+52,bw_b_max+1:bw_b_max+1+54,:)=F_image1;
                        uio_right(i,1)=jst_px0;
                        uio_right(i,2)=jst_px1;
                    end
                elseif(jkl1(ii,1)==12&&jkl(ii,1)==11)
                    if((sum(abc(ii,:))*sum(abc1(ii,:)))-sum(abc2(ii,:))==sum(result_ghi(ii,:)))
                        jst_chuli(jst_px0:jst_px0+52,bw_b_max+1:bw_b_max+1+54,:)=T_image1;
                        true_num=true_num+1;
                    else
                        jst_chuli(jst_px0:jst_px0+52,bw_b_max+1:bw_b_max+1+54,:)=F_image1;
                        uio_right(i,1)=jst_px0;
                        uio_right(i,2)=jst_px1;
                    end
                elseif(jkl1(ii,1)==12&&jkl2(ii,1)==11)
                    if(sum(abc2(ii,:))-(sum(abc(ii,:))*sum(abc1(ii,:)))==sum(result_ghi(ii,:)))
                        jst_chuli(jst_px0:jst_px0+52,bw_b_max+1:bw_b_max+1+54,:)=T_image1;
                        true_num=true_num+1;
                    else
                        jst_chuli(jst_px0:jst_px0+52,bw_b_max+1:bw_b_max+1+54,:)=F_image1;
                        uio_right(i,1)=jst_px0;
                        uio_right(i,2)=jst_px1;
                    end
                elseif(jkl1(ii,1)==12&&jkl(ii,1)==12)
                    if((sum(abc(ii,:))*sum(abc1(ii,:)))*sum(abc2(ii,:))==sum(result_ghi(ii,:)))
                        jst_chuli(jst_px0:jst_px0+52,bw_b_max+1:bw_b_max+1+54,:)=T_image1;
                        true_num=true_num+1;
                    else
                        jst_chuli(jst_px0:jst_px0+52,bw_b_max+1:bw_b_max+1+54,:)=F_image1;
                        uio_right(i,1)=jst_px0;
                        uio_right(i,2)=jst_px1;
                    end
                elseif(jkl1(ii,1)==12&&jkl(ii,1)==13)
                    if((sum(abc(ii,:))*sum(abc1(ii,:)))/sum(abc2(ii,:))==sum(result_ghi(ii,:)))
                        jst_chuli(jst_px0:jst_px0+52,bw_b_max+1:bw_b_max+1+54,:)=T_image1;
                        true_num=true_num+1;
                    else
                        jst_chuli(jst_px0:jst_px0+52,bw_b_max+1:bw_b_max+1+54,:)=F_image1;
                        uio_right(i,1)=jst_px0;
                        uio_right(i,2)=jst_px1;
                    end
                elseif(jkl1(ii,1)==12&&jkl2(ii,1)==13)
                    if(sum(abc2(ii,:))/(sum(abc(ii,:))*sum(abc1(ii,:)))==sum(result_ghi(ii,:)))
                        jst_chuli(jst_px0:jst_px0+52,bw_b_max+1:bw_b_max+1+54,:)=T_image1;
                        true_num=true_num+1;
                    else
                        jst_chuli(jst_px0:jst_px0+52,bw_b_max+1:bw_b_max+1+54,:)=F_image1;
                        uio_right(i,1)=jst_px0;
                        uio_right(i,2)=jst_px1;
                    end
                end
                if(jkl1(ii,1)==13&&jkl(ii,1)==0&&jkl2(ii,1)==0)
                    if(sum(abc(ii,:))/sum(abc1(ii,:))==sum(result_ghi(ii,:)))
                        jst_chuli(jst_px0:jst_px0+52,bw_b_max+1:bw_b_max+1+54,:)=T_image1;
                        true_num=true_num+1;
                    else
                        jst_chuli(jst_px0:jst_px0+52,bw_b_max+1:bw_b_max+1+54,:)=F_image1;
                        uio_right(i,1)=jst_px0;
                        uio_right(i,2)=jst_px1;
                    end
                elseif(jkl1(ii,1)==13&&jkl(ii,1)==10)
                    if((sum(abc(ii,:))/sum(abc1(ii,:)))+sum(abc2(ii,:))==sum(result_ghi(ii,:)))
                        jst_chuli(jst_px0:jst_px0+52,bw_b_max+1:bw_b_max+1+54,:)=T_image1;
                        true_num=true_num+1;
                    else
                        jst_chuli(jst_px0:jst_px0+52,bw_b_max+1:bw_b_max+1+54,:)=F_image1;
                        uio_right(i,1)=jst_px0;
                        uio_right(i,2)=jst_px1;
                    end
                elseif(jkl1(ii,1)==13&&jkl(ii,1)==11)
                    if((sum(abc(ii,:))/sum(abc1(ii,:)))-sum(abc2(ii,:))==sum(result_ghi(ii,:)))
                        jst_chuli(jst_px0:jst_px0+52,bw_b_max+1:bw_b_max+1+54,:)=T_image1;
                        true_num=true_num+1;
                    else
                        jst_chuli(jst_px0:jst_px0+52,bw_b_max+1:bw_b_max+1+54,:)=F_image1;
                        uio_right(i,1)=jst_px0;
                        uio_right(i,2)=jst_px1;
                    end
                elseif(jkl1(ii,1)==13&&jkl2(ii,1)==11)
                    if(sum(abc2(ii,:))-(sum(abc(ii,:))/sum(abc1(ii,:)))==sum(result_ghi(ii,:)))
                        jst_chuli(jst_px0:jst_px0+52,bw_b_max+1:bw_b_max+1+54,:)=T_image1;
                        true_num=true_num+1;
                    else
                        jst_chuli(jst_px0:jst_px0+52,bw_b_max+1:bw_b_max+1+54,:)=F_image1;
                        uio_right(i,1)=jst_px0;
                        uio_right(i,2)=jst_px1;
                    end
                elseif(jkl1(ii,1)==13&&jkl(ii,1)==12)
                    if((sum(abc(ii,:))/sum(abc1(ii,:)))*sum(abc2(ii,:))==sum(result_ghi(ii,:)))
                        jst_chuli(jst_px0:jst_px0+52,bw_b_max+1:bw_b_max+1+54,:)=T_image1;
                        true_num=true_num+1;
                    else
                        jst_chuli(jst_px0:jst_px0+52,bw_b_max+1:bw_b_max+1+54,:)=F_image1;
                        uio_right(i,1)=jst_px0;
                        uio_right(i,2)=jst_px1;
                    end
                elseif(jkl1(ii,1)==13&&jkl(ii,1)==13)
                    if((sum(abc(ii,:))/sum(abc1(ii,:)))/sum(abc2(ii,:))==sum(result_ghi(ii,:)))
                        jst_chuli(jst_px0:jst_px0+52,bw_b_max+1:bw_b_max+1+54,:)=T_image1;
                        true_num=true_num+1;
                    else
                        jst_chuli(jst_px0:jst_px0+52,bw_b_max+1:bw_b_max+1+54,:)=F_image1;
                        uio_right(i,1)=jst_px0;
                        uio_right(i,2)=jst_px1;
                    end
                elseif(jkl1(ii,1)==13&&jkl2(ii,1)==13)
                    if(sum(abc2(ii,:))/(sum(abc(ii,:))/sum(abc1(ii,:)))==sum(result_ghi(ii,:)))
                        jst_chuli(jst_px0:jst_px0+52,bw_b_max+1:bw_b_max+1+54,:)=T_image1;
                        true_num=true_num+1;
                    else
                        jst_chuli(jst_px0:jst_px0+52,bw_b_max+1:bw_b_max+1+54,:)=F_image1;
                        uio_right(i,1)=jst_px0;
                        uio_right(i,2)=jst_px1;
                    end
                end
            else
                kongyu=min(kongyu,jst_px1-jst_px0);
                T_image=imresize(T_image,[kongyu-1,kongyu-1]);
                F_image=imresize(F_image,[kongyu-1,kongyu-1]);
                T_image1=double(T_image);
                F_image1=double(F_image);
                if(jkl1(ii,1)==10&&jkl(ii,1)==0&&jkl2(ii,1)==0)
                    if(sum(abc(ii,:))+sum(abc1(ii,:))==sum(result_ghi(ii,:)))
                        jst_chuli(jst_px0:jst_px0+kongyu-2,bw_b_max+1:bw_b_max+1+kongyu-2,:)=T_image1;
                        true_num=true_num+1;
                    else
                        jst_chuli(jst_px0:jst_px0+kongyu-2,bw_b_max+1:bw_b_max+1+kongyu-2,:)=F_image1;
                        uio_right(i,1)=jst_px0;
                        uio_right(i,2)=jst_px1;
                    end
                elseif(jkl1(ii,1)==10&&jkl(ii,1)==10)
                    if((sum(abc(ii,:))+sum(abc1(ii,:)))+sum(abc2(ii,:))==sum(result_ghi(ii,:)))
                        jst_chuli(jst_px0:jst_px0+kongyu-2,bw_b_max+1:bw_b_max+1+kongyu-2,:)=T_image1;
                        true_num=true_num+1;
                    else
                        jst_chuli(jst_px0:jst_px0+kongyu-2,bw_b_max+1:bw_b_max+1+kongyu-2,:)=F_image1;
                        uio_right(i,1)=jst_px0;
                        uio_right(i,2)=jst_px1;
                    end
                elseif(jkl1(ii,1)==10&&jkl(ii,1)==11)
                    if((sum(abc(ii,:))+sum(abc1(ii,:)))-sum(abc2(ii,:))==sum(result_ghi(ii,:)))
                        jst_chuli(jst_px0:jst_px0+kongyu-2,bw_b_max+1:bw_b_max+1+kongyu-2,:)=T_image1;
                        true_num=true_num+1;
                    else
                        jst_chuli(jst_px0:jst_px0+kongyu-2,bw_b_max+1:bw_b_max+1+kongyu-2,:)=F_image1;
                        uio_right(i,1)=jst_px0;
                        uio_right(i,2)=jst_px1;
                    end
                elseif(jkl1(ii,1)==10&&jkl2(ii,1)==11)
                    if(sum(abc2(ii,:))-(sum(abc(ii,:))+sum(abc1(ii,:)))==sum(result_ghi(ii,:)))
                        jst_chuli(jst_px0:jst_px0+kongyu-2,bw_b_max+1:bw_b_max+1+kongyu-2,:)=T_image1;
                        true_num=true_num+1;
                    else
                        jst_chuli(jst_px0:jst_px0+kongyu-2,bw_b_max+1:bw_b_max+1+kongyu-2,:)=F_image1;
                        uio_right(i,1)=jst_px0;
                        uio_right(i,2)=jst_px1;
                    end
                elseif(jkl1(ii,1)==10&&jkl(ii,1)==12)
                    if((sum(abc(ii,:))+sum(abc1(ii,:)))*sum(abc2(ii,:))==sum(result_ghi(ii,:)))
                        jst_chuli(jst_px0:jst_px0+kongyu-2,bw_b_max+1:bw_b_max+1+kongyu-2,:)=T_image1;
                        true_num=true_num+1;
                    else
                        jst_chuli(jst_px0:jst_px0+kongyu-2,bw_b_max+1:bw_b_max+1+kongyu-2,:)=F_image1;
                        uio_right(i,1)=jst_px0;
                        uio_right(i,2)=jst_px1;
                    end
                elseif(jkl1(ii,1)==10&&jkl(ii,1)==13)
                    if((sum(abc(ii,:))+sum(abc1(ii,:)))/sum(abc2(ii,:))==sum(result_ghi(ii,:)))
                        jst_chuli(jst_px0:jst_px0+kongyu-2,bw_b_max+1:bw_b_max+1+kongyu-2,:)=T_image1;
                        true_num=true_num+1;
                    else
                        jst_chuli(jst_px0:jst_px0+kongyu-2,bw_b_max+1:bw_b_max+1+kongyu-2,:)=F_image1;
                        uio_right(i,1)=jst_px0;
                        uio_right(i,2)=jst_px1;
                    end
                elseif(jkl1(ii,1)==10&&jkl2(ii,1)==13)
                    if(sum(abc2(ii,:))/(sum(abc(ii,:))+sum(abc1(ii,:)))==sum(result_ghi(ii,:)))
                        jst_chuli(jst_px0:jst_px0+kongyu-2,bw_b_max+1:bw_b_max+1+kongyu-2,:)=T_image1;
                        true_num=true_num+1;
                    else
                        jst_chuli(jst_px0:jst_px0+kongyu-2,bw_b_max+1:bw_b_max+1+kongyu-2,:)=F_image1;
                        uio_right(i,1)=jst_px0;
                        uio_right(i,2)=jst_px1;
                    end
                end
                if(jkl1(ii,1)==11&&jkl(ii,1)==0&&jkl2(ii,1)==0)
                    if(sum(abc(ii,:))-sum(abc1(ii,:))==sum(result_ghi(ii,:)))
                        jst_chuli(jst_px0:jst_px0+kongyu-2,bw_b_max+1:bw_b_max+1+kongyu-2,:)=T_image1;
                        true_num=true_num+1;
                    else
                        jst_chuli(jst_px0:jst_px0+kongyu-2,bw_b_max+1:bw_b_max+1+kongyu-2,:)=F_image1;
                        uio_right(i,1)=jst_px0;
                        uio_right(i,2)=jst_px1;
                    end
                elseif(jkl1(ii,1)==11&&jkl(ii,1)==10)
                    if((sum(abc(ii,:))-sum(abc1(ii,:)))+sum(abc2(ii,:))==sum(result_ghi(ii,:)))
                        jst_chuli(jst_px0:jst_px0+kongyu-2,bw_b_max+1:bw_b_max+1+kongyu-2,:)=T_image1;
                        true_num=true_num+1;
                    else
                        jst_chuli(jst_px0:jst_px0+kongyu-2,bw_b_max+1:bw_b_max+1+kongyu-2,:)=F_image1;
                        uio_right(i,1)=jst_px0;
                        uio_right(i,2)=jst_px1;
                    end
                elseif(jkl1(ii,1)==11&&jkl(ii,1)==11)
                    if((sum(abc(ii,:))-sum(abc1(ii,:)))-sum(abc2(ii,:))==sum(result_ghi(ii,:)))
                        jst_chuli(jst_px0:jst_px0+kongyu-2,bw_b_max+1:bw_b_max+1+kongyu-2,:)=T_image1;
                        true_num=true_num+1;
                    else
                        jst_chuli(jst_px0:jst_px0+kongyu-2,bw_b_max+1:bw_b_max+1+kongyu-2,:)=F_image1;
                        uio_right(i,1)=jst_px0;
                        uio_right(i,2)=jst_px1;
                    end
                elseif(jkl1(ii,1)==11&&jkl2(ii,1)==11)
                    if(sum(abc2(ii,:))-(sum(abc(ii,:))-sum(abc1(ii,:)))==sum(result_ghi(ii,:)))
                        jst_chuli(jst_px0:jst_px0+kongyu-2,bw_b_max+1:bw_b_max+1+kongyu-2,:)=T_image1;
                        true_num=true_num+1;
                    else
                        jst_chuli(jst_px0:jst_px0+kongyu-2,bw_b_max+1:bw_b_max+1+kongyu-2,:)=F_image1;
                        uio_right(i,1)=jst_px0;
                        uio_right(i,2)=jst_px1;
                    end
                elseif(jkl1(ii,1)==11&&jkl(ii,1)==12)
                    if((sum(abc(ii,:))-sum(abc1(ii,:)))*sum(abc2(ii,:))==sum(result_ghi(ii,:)))
                        jst_chuli(jst_px0:jst_px0+kongyu-2,bw_b_max+1:bw_b_max+1+kongyu-2,:)=T_image1;
                        true_num=true_num+1;
                    else
                        jst_chuli(jst_px0:jst_px0+kongyu-2,bw_b_max+1:bw_b_max+1+kongyu-2,:)=F_image1;
                        uio_right(i,1)=jst_px0;
                        uio_right(i,2)=jst_px1;
                    end
                elseif(jkl1(ii,1)==11&&jkl(ii,1)==13)
                    if((sum(abc(ii,:))-sum(abc1(ii,:)))/sum(abc2(ii,:))==sum(result_ghi(ii,:)))
                        jst_chuli(jst_px0:jst_px0+kongyu-2,bw_b_max+1:bw_b_max+1+kongyu-2,:)=T_image1;
                        true_num=true_num+1;
                    else
                        jst_chuli(jst_px0:jst_px0+kongyu-2,bw_b_max+1:bw_b_max+1+kongyu-2,:)=F_image1;
                        uio_right(i,1)=jst_px0;
                        uio_right(i,2)=jst_px1;
                    end
                elseif(jkl1(ii,1)==11&&jkl2(ii,1)==13)
                    if(sum(abc2(ii,:))/(sum(abc(ii,:))-sum(abc1(ii,:)))==sum(result_ghi(ii,:)))
                        jst_chuli(jst_px0:jst_px0+kongyu-2,bw_b_max+1:bw_b_max+1+kongyu-2,:)=T_image1;
                        true_num=true_num+1;
                    else
                        jst_chuli(jst_px0:jst_px0+kongyu-2,bw_b_max+1:bw_b_max+1+kongyu-2,:)=F_image1;
                        uio_right(i,1)=jst_px0;
                        uio_right(i,2)=jst_px1;
                    end
                end
                if(jkl1(ii,1)==12&&jkl(ii,1)==0&&jkl2(ii,1)==0)
                    if(sum(abc(ii,:))*sum(abc1(ii,:))==sum(result_ghi(ii,:)))
                        jst_chuli(jst_px0:jst_px0+kongyu-2,bw_b_max+1:bw_b_max+1+kongyu-2,:)=T_image1;
                        true_num=true_num+1;
                    else
                        jst_chuli(jst_px0:jst_px0+kongyu-2,bw_b_max+1:bw_b_max+1+kongyu-2,:)=F_image1;
                        uio_right(i,1)=jst_px0;
                        uio_right(i,2)=jst_px1;
                    end
                elseif(jkl1(ii,1)==12&&jkl(ii,1)==10)
                    if((sum(abc(ii,:))*sum(abc1(ii,:)))+sum(abc2(ii,:))==sum(result_ghi(ii,:)))
                        jst_chuli(jst_px0:jst_px0+kongyu-2,bw_b_max+1:bw_b_max+1+kongyu-2,:)=T_image1;
                        true_num=true_num+1;
                    else
                        jst_chuli(jst_px0:jst_px0+kongyu-2,bw_b_max+1:bw_b_max+1+kongyu-2,:)=F_image1;
                        uio_right(i,1)=jst_px0;
                        uio_right(i,2)=jst_px1;
                    end
                elseif(jkl1(ii,1)==12&&jkl(ii,1)==11)
                    if((sum(abc(ii,:))*sum(abc1(ii,:)))-sum(abc2(ii,:))==sum(result_ghi(ii,:)))
                        jst_chuli(jst_px0:jst_px0+kongyu-2,bw_b_max+1:bw_b_max+1+kongyu-2,:)=T_image1;
                        true_num=true_num+1;
                    else
                        jst_chuli(jst_px0:jst_px0+kongyu-2,bw_b_max+1:bw_b_max+1+kongyu-2,:)=F_image1;
                        uio_right(i,1)=jst_px0;
                        uio_right(i,2)=jst_px1;
                    end
                elseif(jkl1(ii,1)==12&&jkl2(ii,1)==11)
                    if(sum(abc2(ii,:))-(sum(abc(ii,:))*sum(abc1(ii,:)))==sum(result_ghi(ii,:)))
                        jst_chuli(jst_px0:jst_px0+kongyu-2,bw_b_max+1:bw_b_max+1+kongyu-2,:)=T_image1;
                        true_num=true_num+1;
                    else
                        jst_chuli(jst_px0:jst_px0+kongyu-2,bw_b_max+1:bw_b_max+1+kongyu-2,:)=F_image1;
                        uio_right(i,1)=jst_px0;
                        uio_right(i,2)=jst_px1;
                    end
                elseif(jkl1(ii,1)==12&&jkl(ii,1)==12)
                    if((sum(abc(ii,:))*sum(abc1(ii,:)))*sum(abc2(ii,:))==sum(result_ghi(ii,:)))
                        jst_chuli(jst_px0:jst_px0+kongyu-2,bw_b_max+1:bw_b_max+1+kongyu-2,:)=T_image1;
                        true_num=true_num+1;
                    else
                        jst_chuli(jst_px0:jst_px0+kongyu-2,bw_b_max+1:bw_b_max+1+kongyu-2,:)=F_image1;
                        uio_right(i,1)=jst_px0;
                        uio_right(i,2)=jst_px1;
                    end
                elseif(jkl1(ii,1)==12&&jkl(ii,1)==13)
                    if((sum(abc(ii,:))*sum(abc1(ii,:)))/sum(abc2(ii,:))==sum(result_ghi(ii,:)))
                        jst_chuli(jst_px0:jst_px0+kongyu-2,bw_b_max+1:bw_b_max+1+kongyu-2,:)=T_image1;
                        true_num=true_num+1;
                    else
                        jst_chuli(jst_px0:jst_px0+kongyu-2,bw_b_max+1:bw_b_max+1+kongyu-2,:)=F_image1;
                        uio_right(i,1)=jst_px0;
                        uio_right(i,2)=jst_px1;
                    end
                elseif(jkl1(ii,1)==12&&jkl2(ii,1)==13)
                    if(sum(abc2(ii,:))/(sum(abc(ii,:))*sum(abc1(ii,:)))==sum(result_ghi(ii,:)))
                        jst_chuli(jst_px0:jst_px0+kongyu-2,bw_b_max+1:bw_b_max+1+kongyu-2,:)=T_image1;
                        true_num=true_num+1;
                    else
                        jst_chuli(jst_px0:jst_px0+kongyu-2,bw_b_max+1:bw_b_max+1+kongyu-2,:)=F_image1;
                        uio_right(i,1)=jst_px0;
                        uio_right(i,2)=jst_px1;
                    end
                end
                if(jkl1(ii,1)==13&&jkl(ii,1)==0&&jkl2(ii,1)==0)
                    if(sum(abc(ii,:))/sum(abc1(ii,:))==sum(result_ghi(ii,:)))
                        jst_chuli(jst_px0:jst_px0+kongyu-2,bw_b_max+1:bw_b_max+1+kongyu-2,:)=T_image1;
                        true_num=true_num+1;
                    else
                        jst_chuli(jst_px0:jst_px0+kongyu-2,bw_b_max+1:bw_b_max+1+kongyu-2,:)=F_image1;
                        uio_right(i,1)=jst_px0;
                        uio_right(i,2)=jst_px1;
                    end
                elseif(jkl1(ii,1)==13&&jkl(ii,1)==10)
                    if((sum(abc(ii,:))/sum(abc1(ii,:)))+sum(abc2(ii,:))==sum(result_ghi(ii,:)))
                        jst_chuli(jst_px0:jst_px0+kongyu-2,bw_b_max+1:bw_b_max+1+kongyu-2,:)=T_image1;
                        true_num=true_num+1;
                    else
                        jst_chuli(jst_px0:jst_px0+kongyu-2,bw_b_max+1:bw_b_max+1+kongyu-2,:)=F_image1;
                        uio_right(i,1)=jst_px0;
                        uio_right(i,2)=jst_px1;
                    end
                elseif(jkl1(ii,1)==13&&jkl(ii,1)==11)
                    if((sum(abc(ii,:))/sum(abc1(ii,:)))-sum(abc2(ii,:))==sum(result_ghi(ii,:)))
                        jst_chuli(jst_px0:jst_px0+kongyu-2,bw_b_max+1:bw_b_max+1+kongyu-2,:)=T_image1;
                        true_num=true_num+1;
                    else
                        jst_chuli(jst_px0:jst_px0+kongyu-2,bw_b_max+1:bw_b_max+1+kongyu-2,:)=F_image1;
                        uio_right(i,1)=jst_px0;
                        uio_right(i,2)=jst_px1;
                    end
                elseif(jkl1(ii,1)==13&&jkl2(ii,1)==11)
                    if(sum(abc2(ii,:))-(sum(abc(ii,:))/sum(abc1(ii,:)))==sum(result_ghi(ii,:)))
                        jst_chuli(jst_px0:jst_px0+kongyu-2,bw_b_max+1:bw_b_max+1+kongyu-2,:)=T_image1;
                        true_num=true_num+1;
                    else
                        jst_chuli(jst_px0:jst_px0+kongyu-2,bw_b_max+1:bw_b_max+1+kongyu-2,:)=F_image1;
                        uio_right(i,1)=jst_px0;
                        uio_right(i,2)=jst_px1;
                    end
                elseif(jkl1(ii,1)==13&&jkl(ii,1)==12)
                    if((sum(abc(ii,:))/sum(abc1(ii,:)))*sum(abc2(ii,:))==sum(result_ghi(ii,:)))
                        jst_chuli(jst_px0:jst_px0+kongyu-2,bw_b_max+1:bw_b_max+1+kongyu-2,:)=T_image1;
                        true_num=true_num+1;
                    else
                        jst_chuli(jst_px0:jst_px0+kongyu-2,bw_b_max+1:bw_b_max+1+kongyu-2,:)=F_image1;
                        uio_right(i,1)=jst_px0;
                        uio_right(i,2)=jst_px1;
                    end
                elseif(jkl1(ii,1)==13&&jkl(ii,1)==13)
                    if((sum(abc(ii,:))/sum(abc1(ii,:)))/sum(abc2(ii,:))==sum(result_ghi(ii,:)))
                        jst_chuli(jst_px0:jst_px0+kongyu-2,bw_b_max+1:bw_b_max+1+kongyu-2,:)=T_image1;
                        true_num=true_num+1;
                    else
                        jst_chuli(jst_px0:jst_px0+kongyu-2,bw_b_max+1:bw_b_max+1+kongyu-2,:)=F_image1;
                        uio_right(i,1)=jst_px0;
                        uio_right(i,2)=jst_px1;
                    end
                elseif(jkl1(ii,1)==13&&jkl2(ii,1)==13)
                    if(sum(abc2(ii,:))/(sum(abc(ii,:))/sum(abc1(ii,:)))==sum(result_ghi(ii,:)))
                        jst_chuli(jst_px0:jst_px0+kongyu-2,bw_b_max+1:bw_b_max+1+kongyu-2,:)=T_image1;
                        true_num=true_num+1;
                    else
                        jst_chuli(jst_px0:jst_px0+kongyu-2,bw_b_max+1:bw_b_max+1+kongyu-2,:)=F_image1;
                        uio_right(i,1)=jst_px0;
                        uio_right(i,2)=jst_px1;
                    end
                end
            end
        end
    end
    jst_px0=jst_px1;
end
disp(true_num);                
            
disp(uio_left);
disp(uio_right);
hundred=imread('100.bmp');
good=imread('good.bmp');
good1=imread('continue.jpg');
kongyu_down=Image_bw_m-bw_a_max;
if(kongyu_down>500)
    if(true_num/(bw_hang_num*2)==1)
       jst_chuli(Image_bw_m-399:Image_bw_m,Image_bw_n-399:Image_bw_n,:)=hundred;
    end
    if((true_num/(bw_hang_num*2))>=0.6&&(true_num/(bw_hang_num*2))<1)
       jst_chuli(Image_bw_m-399:Image_bw_m,Image_bw_n-399:Image_bw_n,:)=good;
    end
    if(true_num/(bw_hang_num*2)<0.6)
       jst_chuli(Image_bw_m-95:Image_bw_m,Image_bw_n-299:Image_bw_n,:)=good1;
    end
elseif(kongyu_down>400&&kongyu_down<=500)
    hundred=imresize(hundred,[200,200]);
    good=imresize(good,[200,200]);
    if(true_num/(bw_hang_num*2)==1)
       jst_chuli(Image_bw_m-199:Image_bw_m,Image_bw_n-199:Image_bw_n,:)=hundred;
    end
    if((true_num/(bw_hang_num*2))>=0.6&&(true_num/(bw_hang_num*2))<1)
       jst_chuli(Image_bw_m-199:Image_bw_m,Image_bw_n-199:Image_bw_n,:)=good;
    end
    if(true_num/(bw_hang_num*2)<0.6)
       jst_chuli(Image_bw_m-95:Image_bw_m,Image_bw_n-299:Image_bw_n,:)=good1;
    end
elseif(kongyu_down>300&&kongyu_down<=400)
    hundred=imresize(hundred,[150,150]);
    good=imresize(good,[150,150]);
    good1=imresize(good1,[48,150]);
    if(true_num/(bw_hang_num*2)==1)
       jst_chuli(Image_bw_m-149:Image_bw_m,Image_bw_n-149:Image_bw_n,:)=hundred;
    end
    if((true_num/(bw_hang_num*2))>=0.6&&(true_num/(bw_hang_num*2))<1)
       jst_chuli(Image_bw_m-149:Image_bw_m,Image_bw_n-149:Image_bw_n,:)=good;
    end
    if(true_num/(bw_hang_num*2)<0.6)
       jst_chuli(Image_bw_m-47:Image_bw_m,Image_bw_n-149:Image_bw_n,:)=good1;
    end
else
    hundred=imresize(hundred,[kongyu_down,kongyu_down]);
    good=imresize(good,[kongyu_down,kongyu_down]);
    good1=imresize(good1,[kongyu_down,2*kongyu_down]);
    if(true_num/(bw_hang_num*2)==1)
       jst_chuli(Image_bw_m-kongyu_down+1:Image_bw_m,Image_bw_n-kongyu_down+1:Image_bw_n,:)=hundred;
    end
    if((true_num/(bw_hang_num*2))>=0.6&&(true_num/(bw_hang_num*2))<1)
       jst_chuli(Image_bw_m-kongyu_down+1:Image_bw_m,Image_bw_n-kongyu_down+1:Image_bw_n,:)=good;
    end
    if(true_num/(bw_hang_num*2)<0.6)
       jst_chuli(Image_bw_m-kongyu_down+1:Image_bw_m,Image_bw_n-2*kongyu_down+1:Image_bw_n,:)=good1;
    end
end
axes(handles.axes10);
imshow(jst_chuli);
set(handles.text9,'string',num2str(bw_hang_num));
set(handles.text11,'string',num2str(true_num));
set(handles.text13,'string',num2str(bw_hang_num*2-true_num));
set(handles.text15,'string',num2str(true_num/(bw_hang_num*2)));
bw_px0=1;
bw_px1=1;
bw_hang_num=hang_slice(Image_bw);
for i=1:bw_hang_num
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
        line([bw_left,bw_sign1+80],[bw_px0,bw_px0],'color','g');
        line([bw_left,bw_sign1+80],[bw_px1,bw_px1],'color','g');
        line([bw_left1,bw_b_max+80],[bw_px0,bw_px0],'color','g');
        line([bw_left1,bw_b_max+80],[bw_px1,bw_px1],'color','g');
        line([bw_left,bw_left],[bw_px0,bw_px1],'color','g');
        line([bw_sign1+80,bw_sign1+80],[bw_px0,bw_px1],'color','g');
        line([bw_left1,bw_left1],[bw_px0,bw_px1],'color','g');
        line([bw_b_max+80,bw_b_max+80],[bw_px0,bw_px1],'color','g');
    else
        line([bw_left,bw_sign1+kongyu],[bw_px0,bw_px0],'color','g');
        line([bw_left,bw_sign1+kongyu],[bw_px1,bw_px1],'color','g');
        line([bw_left1,bw_b_max+kongyu],[bw_px0,bw_px0],'color','g');
        line([bw_left1,bw_b_max+kongyu],[bw_px1,bw_px1],'color','g');
        line([bw_left,bw_left],[bw_px0,bw_px1],'color','g');
        line([bw_sign1+kongyu,bw_sign1+kongyu],[bw_px0,bw_px1],'color','g');
        line([bw_left1,bw_left1],[bw_px0,bw_px1],'color','g');
        line([bw_b_max+kongyu,bw_b_max+kongyu],[bw_px0,bw_px1],'color','g');
    end
    bw_px0=bw_px1;
end
for uio_i=1:bw_hang_num
    if(uio_left(uio_i,1)~=0||uio_left(uio_i,2)~=0)
        if(kongyu>80)
            line([bw_left,bw_sign1+80],[uio_left(uio_i,1),uio_left(uio_i,1)],'color','r');
            line([bw_left,bw_sign1+80],[uio_left(uio_i,2),uio_left(uio_i,2)],'color','r');
            line([bw_left,bw_left],[uio_left(uio_i,1),uio_left(uio_i,2)],'color','r');
            line([bw_sign1+80,bw_sign1+80],[uio_left(uio_i,1),uio_left(uio_i,2)],'color','r');
        else
            line([bw_left,bw_sign1+kongyu],[uio_left(uio_i,1),uio_left(uio_i,1)],'color','r');
            line([bw_left,bw_sign1+kongyu],[uio_left(uio_i,2),uio_left(uio_i,2)],'color','r');
            line([bw_left,bw_left],[uio_left(uio_i,1),uio_left(uio_i,2)],'color','r');
            line([bw_sign1+kongyu,bw_sign1+kongyu],[uio_left(uio_i,1),uio_left(uio_i,2)],'color','r');
        end
    end
    if(uio_right(uio_i,1)~=0||uio_right(uio_i,2)~=0)
        if(kongyu>80)
            line([bw_left1,bw_b_max+80],[uio_right(uio_i,1),uio_right(uio_i,1)],'color','r');
            line([bw_left1,bw_b_max+80],[uio_right(uio_i,2),uio_right(uio_i,2)],'color','r');
            line([bw_left1,bw_left1],[uio_right(uio_i,1),uio_right(uio_i,2)],'color','r');
            line([bw_b_max+80,bw_b_max+80],[uio_right(uio_i,1),uio_right(uio_i,2)],'color','r');
        else
            line([bw_left1,bw_b_max+kongyu],[uio_right(uio_i,1),uio_right(uio_i,1)],'color','r');
            line([bw_left1,bw_b_max+kongyu],[uio_right(uio_i,2),uio_right(uio_i,2)],'color','r');
            line([bw_left1,bw_left1],[uio_right(uio_i,1),uio_right(uio_i,2)],'color','r');
            line([bw_b_max+kongyu,bw_b_max+kongyu],[uio_right(uio_i,1),uio_right(uio_i,2)],'color','r');
        end
    end
end
h=getframe(handles.axes10);
imwrite(h.cdata,'jieguoshuchu.bmp','bmp');



% --- Executes during object deletion, before destroying properties.
function uipanel2_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to uipanel2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
