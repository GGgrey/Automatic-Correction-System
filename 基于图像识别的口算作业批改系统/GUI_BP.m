function varargout = GUI_BP(varargin)
% GUI_BP MATLAB code for GUI_BP.fig
%      GUI_BP, by itself, creates a new GUI_BP or raises the existing
%      singleton*.
%
%      H = GUI_BP returns the handle to a new GUI_BP or the handle to
%      the existing singleton*.
%
%      GUI_BP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_BP.M with the given input arguments.
%
%      GUI_BP('Property','Value',...) creates a new GUI_BP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_BP_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_BP_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_BP

% Last Modified by GUIDE v2.5 30-May-2019 13:05:43

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_BP_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_BP_OutputFcn, ...
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


% --- Executes just before GUI_BP is made visible.
function GUI_BP_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_BP (see VARARGIN)

% Choose default command line output for GUI_BP
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI_BP wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_BP_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
I=imread('shouxieyangben1 - ¸±±¾ (3).jpg');
axes(handles.axes1);   
imshow(I);
I0=imread('handwrite1.bmp');
a0=handwrite_num_out(I0);
I1=imread('handwrite2.bmp');
a1=handwrite_num_out(I1);
I2=imread('handwrite3.bmp');
a2=handwrite_num_out(I2);
I3=imread('handwrite4.bmp');
a3=handwrite_num_out(I3);
I4=imread('handwrite5.bmp');
a4=handwrite_num_out(I4);
I5=imread('handwrite6.bmp');
a5=handwrite_num_out(I5);
I6=imread('handwrite7.bmp');
a6=handwrite_num_out(I6);
I7=imread('handwrite8.bmp');
a7=handwrite_num_out(I7);
I8=imread('handwrite9.bmp');
a8=handwrite_num_out(I8);
I9=imread('handwrite10.bmp');
a9=handwrite_num_out(I9);
set(handles.text2,'string',num2str(a0));
set(handles.text4,'string',num2str(a1));
set(handles.text5,'string',num2str(a2));
set(handles.text6,'string',num2str(a3));
set(handles.text7,'string',num2str(a4));
set(handles.text8,'string',num2str(a5));
set(handles.text9,'string',num2str(a6));
set(handles.text10,'string',num2str(a7));
set(handles.text11,'string',num2str(a8));
set(handles.text12,'string',num2str(a9));
