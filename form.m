function varargout = form(varargin)
% FORM MATLAB code for form.fig
%      FORM, by itself, creates a new FORM or raises the existing
%      singleton*.
%
%      H = FORM returns the handle to a new FORM or the handle to
%      the existing singleton*.
%
%      FORM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FORM.M with the given input arguments.
%
%      FORM('Property','Value',...) creates a new FORM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before form_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to form_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help form

% Last Modified by GUIDE v2.5 17-Dec-2020 03:42:21

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @form_OpeningFcn, ...
                   'gui_OutputFcn',  @form_OutputFcn, ...
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

% --- Executes just before form is made visible.
function form_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to form (see VARARGIN)

% Choose default command line output for form
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% This sets up the initial plot - only do when we are invisible
% so window can get raised using form.
%if strcmp(get(hObject,'Visible'),'off')
%    plot(rand(5));
%end

% UIWAIT makes form wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = form_OutputFcn(hObject, eventdata, handles)
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
axes(handles.axes1);
cla;

popup_sel_index = get(handles.popupmenu1, 'Value');
switch popup_sel_index
    case 1
        %default values
        start_x = 1;
        start_y = 1;
        start_t = 0;
        end_t =50;
        %
        hGui = findobj('Tag','figure1');
        if ~isempty(hGui)
            handles = guidata(hGui);    
            if isfield(handles,'edit7')
                temp = str2double(get(handles.edit7,'String'));
                if ~isnan(temp)
                    start_x = temp;
                end
            end
            if isfield(handles,'edit8')
                temp = str2double(get(handles.edit8, 'String'));
                if ~isnan(temp)
                    start_y = temp;
                end
            end
            if isfield(handles,'edit9')
                temp = str2double(get(handles.edit9, 'String'));
                if ~isnan(temp)
                    start_t = temp;
                end
            end
            if isfield(handles,'edit10')
                temp = str2double(get(handles.edit10, 'String'));
                if ~isnan(temp)
                    end_t = temp;
                end
            end
        end
        y0 = [start_x start_y];
        t = [start_t end_t];
        [t,y] = ode45('calculate', t, y0);
        plot(t, y(:,1), 'c');
        hold on;
        plot(t, y(:,2), 'r');

    case 2
        %default values
        start_x = 1;
        start_y = 1;
        start_t = 0;
        end_t =50;
        edit7_existed = false;
        edit8_existed = false;
        %
        hGui = findobj('Tag','figure1');
        if ~isempty(hGui)
            handles = guidata(hGui);    
            if isfield(handles,'edit7')
                temp = str2double(get(handles.edit7,'String'));
                if ~isnan(temp)
                    start_x = temp;
                    edit7_existed = true;
                end
            end
            if isfield(handles,'edit8')
                temp = str2double(get(handles.edit8, 'String'));
                if ~isnan(temp)
                    start_y = temp;
                    edit8_existed = true;
                end
            end
            if isfield(handles,'edit9')
                temp = str2double(get(handles.edit9, 'String'));
                if ~isnan(temp)
                    start_t = temp;
                end
            end
            if isfield(handles,'edit10')
                temp = str2double(get(handles.edit10, 'String'));
                if ~isnan(temp)
                    end_t = temp;
                end
            end
        end
        y0 = [start_x start_y];
        t = [start_t end_t];
        %plot set of trajectories
        
        %plot with starting conditions user provided
        [t,y] = ode45('calculate', t, y0);
        plot(y(:,1), y(:,2), 'r')

        %plot with starting conditions multiplied by 0.8, 0.9, 1.1, 1.2
        %0.8
        set(handles.edit7,'string',num2str(start_x*0.8));
        set(handles.edit8,'string',num2str(start_y*0.8));
        y0 = [start_x*0.8 start_y*0.8];
        [t,y] = ode45('calculate', t, y0);
        hold on
        plot(y(:,1), y(:,2), 'b')
        
        %0.9
        set(handles.edit7,'string',num2str(start_x*0.9));
        set(handles.edit8,'string',num2str(start_y*0.9));
        y0 = [start_x*0.9 start_y*0.9];
        [t,y] = ode45('calculate', t, y0);
        hold on
        plot(y(:,1), y(:,2), 'g')
        
        %1.1
        set(handles.edit7,'string',num2str(start_x*1.1));
        set(handles.edit8,'string',num2str(start_y*1.1));
        y0 = [start_x*1.1 start_y*1.1];
        [t,y] = ode45('calculate', t, y0);
        hold on
        plot(y(:,1), y(:,2), 'c')
        
        %1.2
        set(handles.edit7,'string',num2str(start_x*1.2));
        set(handles.edit8,'string',num2str(start_y*1.2));
        y0 = [start_x*1.2 start_y*1.2];
        [t,y] = ode45('calculate', t, y0);
        hold on
        plot(y(:,1), y(:,2), 'y')
        
        %restore user's values in gui
        if edit7_existed
            set(handles.edit7,'string',num2str(start_x));
        else
            set(handles.edit7,'string','');
        end
        if edit8_existed  
            set(handles.edit8,'string',num2str(start_y));
        else
            set(handles.edit8,'string','');
        end
    case 3
        %default values
        start_t = 0;
        end_t =50;
        syms x y a b m n r s
        a = 1;
        b = 1;
        m = 1.2;
        n = 0.8;
        r = 0.1;
        s = 0.1;
        %
        hGui = findobj('Tag','figure1');
        if ~isempty(hGui)
            handles = guidata(hGui);
            if isfield(handles,'edit9')
                temp = str2double(get(handles.edit9, 'String'));
                if ~isnan(temp)
                    start_t = temp;
                end
            end
            if isfield(handles,'edit10')
                temp = str2double(get(handles.edit10, 'String'));
                if ~isnan(temp)
                    end_t = temp;
                end
            end
            if isfield(handles,'edit1')
                temp = str2double(get(handles.edit1,'String'));
                if ~isnan(temp)
                    a = temp;
                end
            end
            if isfield(handles,'edit2')
                temp = str2double(get(handles.edit2,'String'));
                if ~isnan(temp)
                    b = temp;
                end
            end
            if isfield(handles,'edit3')
                temp = str2double(get(handles.edit3,'String'));
                if ~isnan(temp)
                    m = temp;
                end
            end
            if isfield(handles,'edit4')
                temp = str2double(get(handles.edit4,'String'));
                if ~isnan(temp)
                    n = temp;
                end
            end
            if isfield(handles,'edit5')
                temp = str2double(get(handles.edit5,'String'));
                if ~isnan(temp)
                    r = temp;
                end
            end
            if isfield(handles,'edit6')
                temp = str2double(get(handles.edit6,'String'));
                if ~isnan(temp)
                    s = temp;
                end
            end
        end
        %equlibrium point
        eq1 = (m/a)*x-(r/a)-y
        eq2 = (b/n)*x+(s/n)-y
        Ts=solve(eq1,eq2,x,y);
        Tn=structfun(@double, Ts)
        if Tn(1) > 0 & Tn(2) > 0
            M=[0:0.02:2*pi];
            R=0.01;
            x1=R*sin(M)+Tn(1);
            x2=R*cos(M)+Tn(2);
            plot(x1,x2,'r.-')
            hold on;
        end
        %
        x=start_t:0.01:end_t;
        y = (m/a)*x-(r/a);
        plot(y, x, 'r')
        hold on;
        y = (b/n)*x+(s/n);
        plot(y, x, 'b')
end


% --------------------------------------------------------------------
function FileMenu_Callback(hObject, eventdata, handles)
% hObject    handle to FileMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function OpenMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to OpenMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
file = uigetfile('*.fig');
if ~isequal(file, 0)
    open(file);
end

% --------------------------------------------------------------------
function PrintMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to PrintMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
printdlg(handles.figure1)

% --------------------------------------------------------------------
function CloseMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to CloseMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
selection = questdlg(['Close ' get(handles.figure1,'Name') '?'],...
                     ['Close ' get(handles.figure1,'Name') '...'],...
                     'Yes','No','Yes');
if strcmp(selection,'No')
    return;
end

delete(handles.figure1)


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
     set(hObject,'BackgroundColor','white');
end

set(hObject, 'String', {'Time series plot', 'Phase portrait', 'Equlibrium point'});



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



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



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit10_Callback(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit10 as text
%        str2double(get(hObject,'String')) returns contents of edit10 as a double


% --- Executes during object creation, after setting all properties.
function edit10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit9_Callback(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit9 as text
%        str2double(get(hObject,'String')) returns contents of edit9 as a double


% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1
