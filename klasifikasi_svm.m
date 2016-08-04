function [ hasil_akhir ] = klasifikasi_svm( svm_struct_stress, svm_struct_flu, txt_file, handles )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

addpath(fullfile(pwd,'/svm/'));

%pre-processing data
[ freq, pow ] = pre_processing(txt_file,false);

        data.profil = '';
        data.file_name = '';
        data.name = '';
        data.freq = freq';
        data.pow = pow;
        
rekap_data = rekap_one(data, handles);
[test_data level] = filter_data_profil(rekap_data, -1, handles);

pred_stress = ecocfwd(svm_struct_stress, test_data);
pred_flu = ecocfwd(svm_struct_flu, test_data);

if((pred_stress-1)<4)
    cond_stress = 'No Stress';
else
    cond_stress = 'Stress';
end
    
if((pred_flu-1)<4)
    cond_flu = 'No Influenza';
else
    cond_flu = 'Influenza';
end



C='';
msgbox('Testing SVM Completed','Information');
disp('Testing SVM Completed');
  C = [C char(10) char(10) 'Testing SVM Completed'];
        set(handles.edProses,'String',C);
        drawnow;
        
kelas_stress = ['Prediction Level for Stress Profile = ' num2str(pred_stress-1)];
kelas_flu = ['Prediction Level for Influenza Profile = ' num2str(pred_flu-1)];
kond =['Prediction Condition = ' cond_stress ' and ' cond_flu];


disp('Result =');
disp(kelas_stress);
disp(kelas_flu);
disp(kond);

  C = [C char(10) char(10) 'Result = ' char(10) kelas_stress char(10) kelas_flu char(10) kond];
        set(handles.edProses,'String',C);
        drawnow;

end

