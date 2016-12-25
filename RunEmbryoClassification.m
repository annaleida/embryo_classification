clear all;close all;

cats = {'Mean','Variance','Max','Min','RMS','Kurtosis','Skewness','Energy','Entropy','Contrast','Correlation','Homogeneity'};

features_1_c = csvread('C:\Temp\1_c.csv'); s_1_c = size(features_1_c); 
features_2_c = csvread('C:\Temp\2_c.csv'); s_2_c = size(features_2_c); 
features_3_c = csvread('C:\Temp\3_c.csv'); s_3_c = size(features_3_c); 
features_4_c = csvread('C:\Temp\4_c.csv'); s_4_c = size(features_4_c); 
features_5_c = csvread('C:\Temp\5_c.csv'); s_5_c = size(features_5_c); 
features_6_c = csvread('C:\Temp\6_c.csv'); s_6_c = size(features_6_c); 
features_7_c = csvread('C:\Temp\7_c.csv'); s_7_c = size(features_7_c); 
features_8_c = csvread('C:\Temp\8_c.csv'); s_8_c = size(features_8_c); 
% features_0_c = csvread('C:\Temp\0_c.csv'); s_0_c = size(features_0_c); 
% features_6_4 = csvread('C:\Temp\6_4.csv'); s_6_4 = size(features_6_4);  
% features_6_5 = csvread('C:\Temp\6_5.csv'); s_6_5 = size(features_6_5); 
% features_6_6 = csvread('C:\Temp\6_6.csv'); s_6_6 = size(features_6_6); 
% features_9_1 = csvread('C:\Temp\9_1.csv'); s_9_1 = size(features_9_1); 
% features_9_2 = csvread('C:\Temp\9_2.csv'); s_9_2 = size(features_9_2); 
% features_9_3 = csvread('C:\Temp\9_3.csv'); s_9_3 = size(features_9_3); 
% features_12_1 = csvread('C:\Temp\12_1.csv'); s_12_1 = size(features_12_1); 
% features_12_2 = csvread('C:\Temp\12_2.csv'); s_12_2 = size(features_12_2); 
% features_12_2x = csvread('C:\Temp\12_2x.csv'); s_12_2x = size(features_12_2x); 
% features_12_4 = csvread('C:\Temp\12_4.csv'); s_12_4 = size(features_12_4); 
% features_12_3 = csvread('C:\Temp\12_3.csv'); s_12_3 = size(features_12_3); 

% numel_1 = s_6_5(1) + s_6_6(1) + s_9_2(1) + s_9_3(1) + s_12_2(1) + s_12_3(1) + s_12_4(1) + s_6_4(1) + s_9_1(1)+ s_12_1(1);
% numel_2 = s_6_4(1) + s_9_1(1)+ s_12_1(1);
% numel_ = s_1_c(1) + s_2_c(1) + s_4_c(1) + s_6_c(1);
numel_1 = s_1_c(1) + s_2_c(1) + s_3_c(1) + s_4_c(1) + s_5_c(1) + s_6_c(1) + s_7_c(1) + s_8_c(1);
% numel_1 = numel_1 + numel_2;;
features = zeros(numel_1,s_1_c(2));
% features2 = zeros(numel_2,s_6_4(2));
v_length = 0;
features(v_length+1:v_length+s_1_c(1),1:s_1_c(2)) = features_1_c; v_length = v_length + s_1_c(1);
features(v_length+1:v_length+s_2_c(1),1:s_2_c(2)) = features_2_c; v_length = v_length + s_2_c(1);
features(v_length+1:v_length+s_3_c(1),1:s_3_c(2)) = features_3_c; v_length = v_length + s_3_c(1);
features(v_length+1:v_length+s_4_c(1),1:s_4_c(2)) = features_4_c; v_length = v_length + s_4_c(1);
features(v_length+1:v_length+s_5_c(1),1:s_5_c(2)) = features_5_c; v_length = v_length + s_5_c(1);
features(v_length+1:v_length+s_6_c(1),1:s_6_c(2)) = features_6_c; v_length = v_length + s_6_c(1);
features(v_length+1:v_length+s_7_c(1),1:s_7_c(2)) = features_7_c; v_length = v_length + s_7_c(1);
features(v_length+1:v_length+s_8_c(1),1:s_8_c(2)) = features_8_c; v_length = v_length + s_8_c(1);
% features(v_length+1:v_length+s_0_c(1),1:s_0_c(2)) = features_0_c; v_length = v_length + s_0_c(1);
% features(v_length+1:v_length+s_6_5(1),1:s_6_5(2)) = features_6_5; v_length = v_length + s_6_5(1);
% features(v_length+1:v_length+s_6_6(1),1:s_6_6(2)) = features_6_6; v_length = v_length + s_6_6(1);
% features(v_length+1:v_length+s_9_2(1),1:s_9_2(2)) = features_9_2; v_length = v_length + s_9_2(1);
% features(v_length+1:v_length+s_9_3(1),1:s_9_3(2)) = features_9_3; v_length = v_length + s_9_3(1);
% features(v_length+1:v_length+s_12_2(1),1:s_12_2(2)) = features_12_2; v_length = v_length + s_12_2(1);
% features(v_length+1:v_length+s_12_3(1),1:s_12_3(2)) = features_12_3; v_length = v_length + s_12_3(1);
% features(v_length+1:v_length+s_12_4(1),1:s_12_4(2)) = features_12_4; v_length = v_length + s_12_4(1);
% v_length = 0;
% features(v_length+1:v_length+s_6_4(1),1:s_6_4(2)) = features_6_4; v_length = v_length + s_6_4(1);
% features(v_length+1:v_length+s_9_1(1),1:s_9_1(2)) = features_9_1; v_length = v_length + s_9_1(1);
% features(v_length+1:v_length+s_12_1(1),1:s_12_1(2)) = features_12_1; v_length = v_length + s_12_1(1);

disp 'Start'
perc =20
f_min = 1
f_max = 24
res = 25;


if 3==30
    tic
    try
[C,T,F] = EvalPlattDAGSVM(features,features2, cats,perc,f_min,f_max,res);
  [T' F']
 C
 sum(sum(C))
    catch
    end
 toc
end;
if 2==20
tic
 try
[C,T,F] = EvalVarDAGSVM(features,features2, cats, perc,f_min,f_max,res);
  [T' F']
%  C
%  sum(sum(C))
      catch
     end
 toc
end;
if 4 == 4
    tic
%     try
[C,T,F] = EvalNaiveBayes(features,cats, perc,f_min,f_max,res);
  [T' F']
%  C
%  sum(sum(C))
%      catch
%     end
 toc
end;
% Decsion t0ree
if 1==10
    tic
    try
 [C,T,F] = EvalDecisionTree(features, features2,cats, perc,f_min,f_max,res);
  [T' F']
%      C
%      sum(sum(C))
         catch
    end
     toc
end;

%  