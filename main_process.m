function [ svm_struct_stress, svm_struct_flu ] = main_process( dirstr, handles )
%MAIN_PROCESS Summary of this function goes here
%   Detailed explanation goes here
clc;
warning off;

%set contant level profile classifier
level_max = 10;
level_min = 0;

global list_data_stress;
list_data_stress = [];
C='';

%read data input for stress profile
dir_file = [dirstr '\stress\'];
%read list of sub-folders
list = dir(dir_file);
[b k] = size(list);

for i=1:b
    sub_dir = list(i);
    %read level profile from string name file
    txt_sub_dir = strsplit(sub_dir.name,'\s*','DelimiterType','RegularExpression');
    
    if(strcmp(sub_dir.name,'.')==0 && strcmp(sub_dir.name,'..')==0)
        
        profil = num2str(txt_sub_dir{3});
        
        disp(['Read Directory : ' sub_dir.name]);
        C = [C char(10) 'Read Directory : ' sub_dir.name];
        set(handles.edProses,'String',C);
        drawnow;
        
        list_data = baca_dir([dir_file sub_dir.name],profil,handles);
        list_data_stress = [list_data_stress;list_data];
    end
end

    disp('Read data input for stress profile...OK');
    disp(char(10));
    C = [C char(10) 'Read data input for stress profile...OK' char(10)];
    set(handles.edProses,'String',C);
    drawnow;
    
%save to mat file for used in next level
rst_file = fullfile(pwd,'\data_stress.mat');
save(rst_file,'list_data_stress');

global list_data_flu;
list_data_flu = [];    
    
%read data input for flu (influenza) profile
dir_file = [dirstr '\flu\'];
%read list of sub-folders
list = dir(dir_file);
[b k] = size(list);

for i=1:b
    sub_dir = list(i);
    %read level profile from string name file
    txt_sub_dir = strsplit(sub_dir.name,'\s*','DelimiterType','RegularExpression');
    
    if(strcmp(sub_dir.name,'.')==0 && strcmp(sub_dir.name,'..')==0)
        
        profil = txt_sub_dir{3};
        
        disp(['Read Directory : ' sub_dir.name]);
        C = [C char(10) 'Read Directory : ' sub_dir.name];
        set(handles.edProses,'String',C);
        drawnow;
        
        list_data = baca_dir([dir_file sub_dir.name],profil,handles);
        list_data_flu = [list_data_flu;list_data];
    end
end

    disp('Read data input for influenza profile...OK');
    disp(char(10));
    C = [C char(10) 'Read data input for influenza profile...OK'];
    set(handles.edProses,'String',C);
    drawnow;


%save to mat file for used in next level
rst_file = fullfile(pwd,'\data_flu.mat');
save(rst_file,'list_data_flu');

global rekap_data_stress;
rekap_data_stress = [];

%pre-processing all stress data input for SVM training data 
disp(char(10));
disp('pre-processing all stress data input for SVM training data...');
  C = [C char(10) char(10) 'pre-processing all stress data input for SVM training data...'];
        set(handles.edProses,'String',C);
        drawnow;
        
[b,k] = size(list_data_stress);

for i = 1:b
    rekap_data = rekap_one(list_data_stress(i,1), handles);
    rekap_data_stress = [rekap_data_stress;rekap_data];
end;

disp(['Successfully Pre-Processing : (' num2str(b) ') files']);
  C = [C char(10) 'Successfully Pre-Processing : (' num2str(b) ') files'];
        set(handles.edProses,'String',C);
        drawnow;

%save to mat file for used in next level
rst_file = fullfile(pwd,'\rekap_stress.mat');
save(rst_file,'rekap_data_stress');


global rekap_data_flu
rekap_data_flu = [];

%pre-processing all influenza data input for SVM training data 
disp(char(10));
disp('pre-processing all influenza data input for SVM training data...');
  C = [C char(10) char(10) 'pre-processing all influenza data input for SVM training data...'];
        set(handles.edProses,'String',C);
        drawnow;
        
[b,k] = size(list_data_flu);

for i = 1:b
    rekap_data = rekap_one(list_data_flu(i,1), handles);
    rekap_data_flu = [rekap_data_flu;rekap_data];
end;

disp(['Successfully Pre-Processing : (' num2str(b) ') files']);
  C = [C 'Successfully Pre-Processing : (' num2str(b) ') files' char(10)];
        set(handles.edProses,'String',C);
        drawnow;

%save to mat file for used in next level
rst_file = fullfile(pwd,'\rekap_flu.mat');
save(rst_file,'rekap_data_flu');

data_stress = [];
data_stress_level = [];

%filter data structure for stress profile (pre-req SVM)
for i = level_min:level_max
    [data level] = filter_data_profil(rekap_data_stress,i, handles);
    data_stress = [data_stress;data];
    data_stress_level = [data_stress_level;level];
end

disp(char(10));
disp('Filter data structure for stress profile (pre-req SVM)...OK');
  C = [C char(10) 'Filter data structure for stress profile (pre-req SVM)...OK'];
        set(handles.edProses,'String',C);
        drawnow;
        

data_flu = [];
data_flu_level = [];

%filter data structure for influenza profile (pre-req SVM)
for i = level_min:level_max
    [data level] = filter_data_profil(rekap_data_flu,i, handles);
    data_flu = [data_flu;data];
    data_flu_level = [data_flu_level;level];
end

disp('Filter data structure for influenza profile (pre-req SVM)...OK');
  C = [C char(10) 'Filter data structure for influenza profile (pre-req SVM)...OK' char(10)];
        set(handles.edProses,'String',C);
        drawnow;
        

%Training SVM for data structure for stress profile;
input_data.data = data_stress;
input_data.level = data_stress_level;

svm_struct_stress = train_svm(input_data,level_min,level_max,handles);

disp('Training SVM for data structure for stress profile...Completed');
  C = [C char(10) 'Training SVM for data structure for stress profile...Completed'];
        set(handles.edProses,'String',C);
        drawnow;

%save to mat file for used in next level
rst_file = fullfile(pwd,'\svm_stress_train.mat');
save(rst_file,'svm_struct_stress');


%Training SVM for data structure for influenza profile;
input_data.data = data_flu;
input_data.level = data_flu_level;

svm_struct_flu = train_svm(input_data,level_min,level_max,handles);

disp('Training SVM for data structure for influenza profile...Completed');
  C = [C char(10) 'Training SVM for data structure for influenza profile...Completed'];
        set(handles.edProses,'String',C);
        drawnow;

%save to mat file for used in next level
rst_file = fullfile(pwd,'\svm_flu_train.mat');
save(rst_file,'svm_struct_flu');

grafik;
tabel;
drawnow;

msgbox('Training SVM Completed','Information');
end

