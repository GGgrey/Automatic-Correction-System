function varargout = GUI(varargin)
% GUI MATLAB code for GUI.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI

% Last Modified by GUIDE v2.5 29-May-2019 20:03:17

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_OutputFcn, ...
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


% --- Executes just before GUI is made visible.
function GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI (see VARARGIN)

% Choose default command line output for GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



% Hint: place code in OpeningFcn to populate axes1


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
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
baocun=zeros(1,char_num);
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
    baocun(1,num+1)=biaozhun_m;
    matrix_1=matrix_2;
end
dot=min(baocun);
disp(dot);

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
    elseif(biaozhun_m<=28&&biaozhun_n<=28)
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
    str_num=strcat('moban_abc',str);
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
yinshua=imread('moban_aaa.jpg');
axes(handles.axes1); 
imshow(yinshua);
level_yinshua=graythresh(yinshua);
yinshua1=im2bw(yinshua,level_yinshua);
yinshua3=(yinshua1~=1);
%figure,imshow(yinshua3);
yinshua2=double(yinshua3);
[yinshua_hang,yinshua_lie,~]=size(yinshua1);
lie_num=lie_slice(yinshua3);
%disp(lie_num);%6
baocun1=zeros(1,lie_num);
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
     baocun1(1,yinshua_num)=ys_n;
     yinshua_px0=yinshua_px1;
end
dot1=min(baocun1);
disp(dot1);

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
     elseif(ys_n<=dot1)
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
set(handles.text4,'string',num2str(save_figure(1,1)));
set(handles.text5,'string',num2str(save_figure(2,1)));
set(handles.text6,'string',num2str(save_figure(3,1)));
set(handles.text7,'string',num2str(save_figure(4,1)));
set(handles.text8,'string',num2str(save_figure(5,1)));
set(handles.text9,'string',num2str(save_figure(6,1)));
set(handles.text10,'string',num2str(save_figure(7,1)));
set(handles.text11,'string',num2str(save_figure(8,1)));
set(handles.text12,'string',num2str(save_figure(9,1)));
set(handles.text13,'string',num2str(save_figure(10,1)));
set(handles.text14,'string',num2str(save_figure(11,1)));
set(handles.text15,'string',num2str(save_figure(12,1)));
set(handles.text16,'string',num2str(save_figure(13,1)));
set(handles.text17,'string',num2str(save_figure(14,1)));
set(handles.text18,'string',num2str(save_figure(15,1)));
set(handles.text19,'string',num2str(save_figure(16,1)));
set(handles.text20,'string',num2str(save_figure(17,1)));
set(handles.text21,'string',num2str(save_figure(18,1)));
