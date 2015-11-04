function varargout = INK(varargin)

%% This is an Interface for capturing digital ink during sketching
% INK M-file for INK.fig
%      INK, by itself, creates a new INK or raises the existing
%      singleton*.
%
%      H = INK returns the handle to a new INK or the handle to
%      the existing singleton*.
%
%      INK('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in INK.M with the given input arguments.
%
%      INK('Property','Value',...) creates a new INK or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before INK_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to INK_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help INK

% Last Modified by GUIDE v2.5 19-Apr-2015 22:25:15

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @INK_OpeningFcn, ...
    'gui_OutputFcn',  @INK_OutputFcn, ...
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


% --- Executes just before INK is made visible.



function INK_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to INK (see VARARGIN)

% Choose default command line output for INK
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes INK wait for user response (see UIRESUME)
% uiwait(handles.figure1);

global ghandles;
global points;
global pID;
global drawing;
global sketchID;

global index;
index=1;

ghandles = handles;
tic
axis([0 1 0 1])
hold on
set(gca,'XTick',[],'Ytick',[],'Box','on')
set(ghandles.pushbutton1,'Enable','off')
set(ghandles.pushbutton2,'Enable','off')
set(gcf,'WindowButtonDownFcn',@mouseDown,'WindowButtonMotionFcn',@mouseMoving,'WindowButtonUpFcn',@mouseUp)

points = zeros(1000,4);
pID = 0;
drawing = 0;
sketchID = 0;
% --- Outputs from this function are returned to the command line.
function varargout = INK_OutputFcn(hObject, eventdata, handles)
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
global points;
global pID;
global sketchID;
global index;
cla
points = zeros(1000,4);
pID = 0;
index=1;
close Figure 20;
close Figure 11;
% close Figure 1;
% close Figure 2;
close Figure 4;




% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global points;
global pID;
global sketchID;

if pID < 1000
    points(pID+1:end,:)=[];
end


save(['data_' num2str(sketchID)],'points')

function mouseDown(hObject, eventdata, handles)

global ghandles;
global points;
global pID;
global drawing;

cp = get(gca,'CurrentPoint');

if cp(1,1)<1 && cp(1,1)>0 && cp(1,2)<1 && cp(1,2)>0
    drawing = 1;
    
end


function mouseMoving(hObject, eventdata, handles)
global ghandles;
global points;
global pID;
global drawing;
global index ;

if drawing
    t = toc;
    cp = get(gca,'CurrentPoint');
    
    pID = pID + 1;
    points(pID,1) = cp(1,1);
    points(pID,2) = cp(1,2);
    points(pID,3) = t;
    points(pID,4) = index;
    plot(cp(1,1),cp(1,2),'.')
    
end


function mouseUp(hObject, eventdata, handles)
global ghandles;
global points;
global pID;
global drawing;
global sketchID;
global break_point;
global index;


if drawing
    drawing = 0;
    sketchID = sketchID+1;
    break_point(1,sketchID)=pID;
    index=index+1;
    
    
end

set(ghandles.pushbutton1,'Enable','on')
set(ghandles.pushbutton2,'Enable','on')


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1




% --- Executes on button press in pushbutton3.
%function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% ha=axes('units','normalized','position',[0 0 1 1]);
% uistack(ha,'down')
% II=imread('test.JPG');
% image(II)
% colormap gray
% set(ha,'handlevisibility','off','visible','off');


% RGB=imread('C:\Users\michael\Desktop\3D_Constraction_1\ddd.JPG');
%
% image(RGB);
% imshow(RGB);

% img=imread('ddd.JPG')%1.jpg表示文件名
% image(img),set(gca,'visible','on');
% axes(handles.axes1);
% imshow(img);


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%figure;
% axes;
% img=imread('test.JPG');%P8270091.JPG是你?前工作目?下的?片
% image(img)

% %用GUI中的axes?件
% axes(handles.axes1);
% [A,map]=imread('test.JPG');
% imshow(A,map);

% [filename,pathname] = ...
%     uigetfile({'*.jpg';'*.bmp';'*.gif';'*.png';'*.tif'},'Read Pic');
% str = [pathname filename];
% im = imread(str);
% axes(handles.axes1);
% imshow(im);
%

% global im
%
% [filename pathname] = uigetfile({'*.jpg';'*.bmp';'*.gif'}, 'chose');
%
% str=[pathname filename];
%
% im=imread(str);
% axes(handles.axes1);
% imshow(im);



%
% I=imread('test.JPG');
% imshow(I);

% filename='ddd.jpg' ;
% org=imread(filename);
% imshow(org);

ha=axes('units','normalized','position',[0 0 0.7 0.7]);
uistack(ha,'down')
II=imread('pic44.JPG');
image(II)
colormap gray
set(ha,'handlevisibility','off','visible','off');


%% Today !!
% % --- Executes during object creation, after setting all properties.
% function pushbutton3_CreateFcn(hObject, eventdata, handles)
% % hObject    handle to pushbutton3 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    empty - handles not created until after all CreateFcns called

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global points;
% data_struct=load(['data_12.mat']);
% data= points;
ShapeConstruction(points);


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% backgroundImage = importdata('pic44.JPG');
% axes(handles.axes1);
% image(backgroundImage);


ha=axes('units','normalized','position',[0.1 0.1 0.8 0.8]);
uistack(ha,'up')
II=imread('pic44.JPG');
image(II)
colormap gray
set(ha,'handlevisibility','off','visible','off');


% --- Executes on mouse press over axes background.
function axes1_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
