function [ data ] = rekap_one( input_data, handles )
%REKAP_ALL Summary of this function goes here
%   Detailed explanation goes here
C = '';
disp(['Pre-Processing File : ' input_data.name]);

pow_list = input_data.pow;
pow_list = pow_list(:,1);

freq_list = input_data.freq;
freq_list = freq_list(:,1);

%sum all power value with freq. range from 0.003 to 0.04 for VLF criteria
vlf_data = pow_list(freq_list >= 0.003 & freq_list < 0.04);
sum_vlf_data = sum(vlf_data);
  C = [C char(10) 'sum all power value with freq. range from 0.003 to 0.04 for VLF criteria...'];
        set(handles.edProses,'String',C);
        drawnow;

%sum all power value with freq. range from 0.04 to 0.15 for LF criteria
lf_data = pow_list(freq_list >= 0.04 & freq_list < 0.15);
sum_lf_data = sum(lf_data);
  C = [C char(10) 'sum all power value with freq. range from 0.04 to 0.15 for LF criteria...'];
        set(handles.edProses,'String',C);
        drawnow;

%sum all power value with freq. range from 0.15 to 0.4 for HF criteria
hf_data = pow_list(freq_list >= 0.15 & freq_list <= 0.4);
sum_hf_data = sum(hf_data);
  C = [C char(10) 'sum all power value with freq. range from 0.15 to 0.4 for HF criteria...'];
        set(handles.edProses,'String',C);
        drawnow;

%ratio LF/HF
ratio_lf_hf = sum_lf_data / sum_hf_data;
  C = [C char(10) 'ratio LF/HF...'];
        set(handles.edProses,'String',C);
        drawnow;

%sum of VLF + LF + HF
total_all = sum_vlf_data + sum_lf_data + sum_hf_data;
  C = [C char(10) 'sum of VLF + LF + HF...'];
        set(handles.edProses,'String',C);
        drawnow;

%formulation of nLF
nLF = (sum_lf_data * 100)/total_all;
  C = [C char(10) 'formulation of nLF...'];
        set(handles.edProses,'String',C);
        drawnow;

%formulation of nHF
nHF = (sum_hf_data * 100)/total_all;
  C = [C char(10) 'formulation of nHF...'];
        set(handles.edProses,'String',C);
        drawnow;

%return all data with addition of vlf / lf / hf data
data.profil = input_data.profil;
data.file_name = input_data.file_name;
data.name = input_data.name;
data.freq = input_data.freq;
data.pow = input_data.pow;

data.vlf_data = vlf_data;
data.sum_vlf_data = sum_vlf_data;

data.lf_data = lf_data;
data.sum_lf_data = sum_lf_data;

data.hf_data = hf_data;
data.sum_hf_data = sum_hf_data;

data.ratio_lf_hf = ratio_lf_hf;
data.nLF = nLF;
data.nHF = nHF;

end

