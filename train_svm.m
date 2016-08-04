function [ svm_struct ] = train_svm( input_data, level_min, level_max, handles )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

addpath(fullfile(pwd,'/svm/'));

C = '';
data = input_data.data;
level = input_data.level;

% multi class problem, solve with 15 bit code
net = ecoc(level_max + 1,15);
net.verbosity = 2;

net = ecocload(net,fullfile(pwd,'/svm/','code15-11'));

% Initialise an instance of the base learning algorithm
[b k] = size(data);
pilih = 0;

if(pilih==1)
    learner = svm(3, 'linear', [36], 5000, 1);   
else
    learner = svm(3, 'rbf', [36], 5000, 1);   
end 
learner.recompute = Inf;

% Train the individual bit learners, all starting out from the parameter
% setting in the SVM structure LEARNER
svm_struct = ecoctrain(net, learner, data, level, handles);

% pred = ecocfwd(svm_struct, data(20,:));
% msgbox(num2str(pred));