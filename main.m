clc
clear all
%% add path
addpath(genpath('data'))
addpath(genpath('functions'))

%% load data
 Files = dir(fullfile('data', '*.mat'));
 
data_num = 1; %  The test data number
Dname = Files(data_num).name; % data name
disp(['***********The test data name is: ***' num2str(data_num) '***'  Dname '****************'])
load(Dname);
disp(['Test our method'])
tic
result = Test_SMSC(X,Y);
temp_time = toc;
Measure_result = ClusteringMeasure_new(Y, result);
