function varargout = tabel(varargin)
% TABEL MATLAB code for tabel.fig
%      TABEL, by itself, creates a new TABEL or raises the existing
%      singleton*.
%
%      H = TABEL returns the handle to a new TABEL or the handle to
%      the existing singleton*.
%
%      TABEL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TABEL.M with the given input arguments.
%
%      TABEL('Property','Value',...) creates a new TABEL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before tabel_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to tabel_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help tabel

% Last Modified by GUIDE v2.5 03-Jun-2016 07:53:57

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @tabel_OpeningFcn, ...
                   'gui_OutputFcn',  @tabel_OutputFcn, ...
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


% --- Executes just before tabel is made visible.
function tabel_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to tabel (see VARARGIN)

% Choose default command line output for tabel
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

movegui(gcf,'east');

set_table(handles);


% UIWAIT makes tabel wait for user response (see UIRESUME)
% uiwait(handles.figure1);

function set_table(handles)
global rekap_data_stress;
global rekap_data_flu;


rekap_stress = [];
[b,k] = size(rekap_data_stress);

for i = 1:b
data_stress = rekap_data_stress(i);
data_stress = [data_stress.sum_vlf_data data_stress.sum_lf_data data_stress.sum_hf_data data_stress.ratio_lf_hf data_stress.nLF data_stress.nHF];
rekap_stress = [rekap_stress;data_stress];
end

set(handles.tblStress,'data',rekap_stress);
drawnow;

rekap_flu = [];
[b,k] = size(rekap_data_flu);

for i = 1:b
data_flu = rekap_data_flu(i);
data_flu = [data_flu.sum_vlf_data data_flu.sum_lf_data data_flu.sum_hf_data data_flu.ratio_lf_hf data_flu.nLF data_flu.nHF];
rekap_flu = [rekap_flu;data_flu];
end

set(handles.tblFlu,'data',rekap_flu);
drawnow;


% --- Outputs from this function are returned to the command line.
function varargout = tabel_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
