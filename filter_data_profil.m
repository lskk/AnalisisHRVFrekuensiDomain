function [ data_filter, data_level ] = filter_data_profil( input_data, profil, handles )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
[b k] = size(input_data);

data_filter = [];
data_level = [];

for i = 1:b
    data = input_data(i,1);
    
    %profil = -1 used for SVM classifier only, do not using for training
    if(profil == -1)
        isi = [data.ratio_lf_hf data.nLF data.nHF];
        data_filter = [data_filter;isi];
        data_level = [data_level;-1];
    end
    
    if(strcmp(data.profil,num2str(profil))==1)
        isi = [data.ratio_lf_hf data.nLF data.nHF];
        data_filter = [data_filter;isi];
        data_level = [data_level;profil+1];
    end
    
end

end

