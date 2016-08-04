function varargout = grafik(varargin)
% grafik MATLAB code for grafik.fig
%      grafik, by itself, creates a new grafik or raises the existing
%      singleton*.
%
%      H = grafik returns the handle to a new grafik or the handle to
%      the existing singleton*.
%
%      grafik('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in grafik.M with the given input arguments.
%
%      grafik('Property','Value',...) creates a new grafik or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before grafik_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to grafik_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help grafik

% Last Modified by GUIDE v2.5 05-Jun-2016 11:42:59

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @grafik_OpeningFcn, ...
                   'gui_OutputFcn',  @grafik_OutputFcn, ...
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


% --- Executes just before grafik is made visible.
function grafik_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to grafik (see VARARGIN)

% Choose default command line output for grafik
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

movegui(gcf,'west');

set(handles.lsStress,'string','');
set(handles.lsFlu,'string','');

set(handles.edStress,'string','');
set(handles.edFlu,'string','');
%set_table(handles);
% UIWAIT makes grafik wait for user response (see UIRESUME)
% uiwait(handles.figure1);


function [rekap_data, test_data, level] = set_pre_processing(txt_file, handles)
%pre-processing data
[ freq, pow ] = pre_processing(txt_file,false);

        data.profil = '';
        data.file_name = '';
        data.name = '';
        data.freq = freq';
        data.pow = pow;
        
rekap_data = rekap_one(data, handles);
[test_data level] = filter_data_profil(rekap_data, -1, handles);


function set_table_stress(rekap_data, handles)

[b,k] = size(rekap_data.pow);

    axes(handles.axStress);
    plot(rekap_data.freq(1:b),rekap_data.pow(1:b)),xlabel('freq.'),ylabel('power');
    
    
function set_table_flu(rekap_data, handles)

[b,k] = size(rekap_data.pow);

    axes(handles.axFlu);
    plot(rekap_data.freq(1:b),rekap_data.pow(1:b)),xlabel('freq.'),ylabel('power');
    

function set_table(handles)
global list_data_stress;
global list_data_flu;

list_stress = [];
[b,k] = size(list_data_stress);

for i = 1:b
list_stress = list_data_stress(i);

[b,k] = size(list_stress.freq);
[b,k] = size(list_stress.pow);

freq = list_stress.freq(1:b,k);
pow = list_stress.pow;

list_stress = [freq pow];
list_stress = [list_stress;list_stress];
end

    axes(handles.axStress);
    plot(list_stress(:,1),list_stress(:,2)),xlabel('freq.'),ylabel('power');
    

list_flu = [];
[b,k] = size(list_data_flu);

for i = 1:b
list_flu = list_data_flu(i);

[b,k] = size(list_flu.freq);
[b,k] = size(list_flu.pow);

freq = list_flu.freq(1:b,k)
pow = list_flu.pow

list_flu = [freq pow];
list_flu = [list_flu;list_flu];
end

axes(handles.axFlu);
plot(list_flu(:,1),list_flu(:,2)),xlabel('freq.'),ylabel('power');


% --- Outputs from this function are returned to the command line.
function varargout = grafik_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in lsStress.
function lsStress_Callback(hObject, eventdata, handles)
% hObject    handle to lsStress (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns lsStress contents as cell array
%        contents{get(hObject,'Value')} returns selected item from lsStress


% --- Executes during object creation, after setting all properties.
function lsStress_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lsStress (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in lsFlu.
function lsFlu_Callback(hObject, eventdata, handles)
% hObject    handle to lsFlu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns lsFlu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from lsFlu


% --- Executes during object creation, after setting all properties.
function lsFlu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lsFlu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.edStress,'String','');
[filename,pathname] = uigetfile( ...
{'*.txt',  'Select Heart Rate Data File (*.txt)'; ...
'*.txt',  'Text File (*.txt)'}, ...
   'Select Heart Rate Data File :');

filestr=strcat(pathname,filename);
exts=filename(length(filename)-2:length(filename));

if(isempty(filestr))
    msgbox('Please select heart rate data file first','Information');
    return;
end

set(handles.lsStress,'string',filestr);

[rekap_data, test_data, level] = set_pre_processing(filestr, handles);

  C = '';
  C = [C char(10) 'sum VLF = ' num2str(rekap_data.sum_vlf_data)];
  C = [C char(10) 'sum LF = ' num2str(rekap_data.sum_lf_data)];
  C = [C char(10) 'sum HF = ' num2str(rekap_data.sum_hf_data)];
  C = [C char(10) 'Ratio LF/HF = ' num2str(rekap_data.ratio_lf_hf)];
  C = [C char(10) 'nLF = ' num2str(rekap_data.nLF)];
  C = [C char(10) 'nHF = ' num2str(rekap_data.nHF)];
        set(handles.edStress,'String',C);
        drawnow;
        
 set_table_stress(rekap_data,handles);




% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,pathname] = uigetfile( ...
{'*.txt',  'Select Heart Rate Data File (*.txt)'; ...
'*.txt',  'Text File (*.txt)'}, ...
   'Select Heart Rate Data File :');

filestr=strcat(pathname,filename);
exts=filename(length(filename)-2:length(filename));

if(isempty(filestr))
    msgbox('Please select heart rate data file first','Information');
    return;
end

set(handles.lsFlu,'string',filestr);

[rekap_data, test_data, level] = set_pre_processing(filestr, handles);

  C = '';
  C = [C char(10) 'sum VLF = ' num2str(rekap_data.sum_vlf_data)];
  C = [C char(10) 'sum LF = ' num2str(rekap_data.sum_lf_data)];
  C = [C char(10) 'sum HF = ' num2str(rekap_data.sum_hf_data)];
  C = [C char(10) 'Ratio LF/HF = ' num2str(rekap_data.ratio_lf_hf)];
  C = [C char(10) 'nLF = ' num2str(rekap_data.nLF)];
  C = [C char(10) 'nHF = ' num2str(rekap_data.nHF)];
        set(handles.edFlu,'String',C);
        drawnow;

 set_table_flu(rekap_data,handles);
 

function edStress_Callback(hObject, eventdata, handles)
% hObject    handle to edStress (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edStress as text
%        str2double(get(hObject,'String')) returns contents of edStress as a double


% --- Executes during object creation, after setting all properties.
function edStress_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edStress (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edFlu_Callback(hObject, eventdata, handles)
% hObject    handle to edFlu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edFlu as text
%        str2double(get(hObject,'String')) returns contents of edFlu as a double


% --- Executes during object creation, after setting all properties.
function edFlu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edFlu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edProses_Callback(hObject, eventdata, handles)
% hObject    handle to edProses (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edProses as text
%        str2double(get(hObject,'String')) returns contents of edProses as a double


% --- Executes during object creation, after setting all properties.
function edProses_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edProses (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
