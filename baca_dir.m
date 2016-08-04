function [ list_data ] = baca_dir( dir_file, profil, handles )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
list_data = [];
C='';

%dir_all = fullfile(pwd,dir_file);
dir_all = dir_file;

%read list of files with *.txt extension
list = dir(dir_all);
[b k] = size(list);

x = 0;
for i = 1:b
    if~(list(i).isdir)
        disp(['Read File : ' list(i).name]);
        C = [C char(10) 'Read File : ' list(i).name];
        set(handles.edProses,'String',C);
        drawnow;
        
        txt_file = fullfile(dir_all,list(i).name);
        
        %pre-processing data
        [ freq, pow ] = pre_processing(txt_file,false);
        
        data.profil = profil;
        data.file_name = txt_file;
        data.name = list(i).name;
        data.freq = freq';
        data.pow = pow;
        
        list_data = [list_data;data];
        x = x+1;
    end
end

disp(['Successfully Read : (' num2str(x) ') files']);
        C = [C char(10) 'Successfully Read : (' num2str(x) ') files'];
        set(handles.edProses,'String',C);
        drawnow;
end

