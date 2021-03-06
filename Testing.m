% clear all; close all;

% I = zeros(500);
path = 'C:\Temp\Testimages\0 cell\';
listing = dir(strcat(path,'*.jpg'))
ss = size(listing); nbr_im = ss(1);
ff = zeros(nbr_im, 12);
nn = zeros(nbr_im,1);

for i=1:nbr_im
    filename = listing(i).name
    nn(i) = str2num(filename(29:31));
    ff(i,:) = ExtractFeatures(strcat(path,filename),1);
    fh(i,:) = ExtractFeatures(strcat(path,filename),2);
end;

% Manually:
% Save contents of ff + nbr of cells

% ff(:,13) = 1;
% ff_all(1:50,1:13) = ff;

cats = {'Mean','Variance','Max','Min','RMS','Kurtosis','Skewness','Energy','Entropy','Contrast','Correlation','Homogeneity'};
% feature = ff_all(:,1:12);
% result = ff_all(:,13);
%  perc = 30;
%  for i=1:10
%  [training, trainingResult,testset,testsetResult] = TrainingSet(features, result ,perc);
% % % Create tree
% 
%  [tree_,numnodes_,resuberror_,crossvalerror_,sensitivity_,specificity_1_,pos_predict_,neg_predict_] = DecisionTree(training,trainingResult,testset,testsetResult,cats);    
%  nodes(i) = numnodes_;resuberr(i) = resuberror_;cverr(i) = crossvalerror_;
%  sensitivity(i) = sensitivity_; specificity_1(i) = specificity_1_; 
%  pos_predict(i) = pos_predict_; neg_predict(i) = neg_predict_;
%  end;
% 
%  % Sort out results from simple trees nodes < threshold
%  maxNodes = 10;
%  nodes2 = nodes(nodes <= maxNodes);
%  resuberr2 = resuberr(nodes <= maxNodes);
%  cverr2 = cverr(nodes <= maxNodes);
%  specificity_12 = specificity_1(nodes <= maxNodes);
%  sensitivity2 = sensitivity(nodes <= maxNodes);

%% Print result (evaluate manually)

res = zeros(nbr_im,1);
res(1:nbr_im) = 0;
% res(87:134) = 2;
% res(135:210) = 4;
% res(211:227) = 6;
% res(199:293) = 8;
% res(228:423) = 0;
% res(424:454) = 10;



%% set first image to 1
for i=1:12
ff_(:,i) = ff(:,i)/ff(1,i);
fh_(:,i) = fh(:,i)/fh(1,i);
end;

%% rescale to 10 max
for i = 1:12
ff__(:,i) = (ff_(:,i)-min(ff_(:,i))).*10./(max(ff_(:,i))-min(ff_(:,i)));
fh__(:,i) = (fh_(:,i)-min(fh_(:,i))).*10./(max(fh_(:,i))-min(fh_(:,i)));
end;

%% Combine several to the same feature matrix

features(:,1:12) = ff__(:,1:12);
features(:,13:24) = fh__(:,1:12);
features(:,25) = res;
features(:,26) = nn;

% Save and clear
csvwrite('C:\Temp\0_c.csv',features);
clear ff ff_ ff__ fh fh_ fh__ features nn res

if 1==0
    
%% Principal component analysis

% **************************************************
[pc, zscores, pcvars] = princomp(allCells);
relVarSum = cumsum(pcvars./sum(pcvars) * 100);
% figure(1)
% hold on
% clf
% plot(pc(:,1),'b.');
% figure(2)
% hold on
% clf
% plot(relVarSum,'b.');

pc1(:,myInd) = pc(:,1);
relVar(:,myInd) = relVarSum;

% Plot the whole thing
if (1 == 1)
    figure(31)
    clf
bar(relVar(1:6,1)) %Dag 1
% bar(relVar(1:4,5:7)) %Dag 2
% bar(relVar(1:4,9:11)) %Dag 3
colormap gray
axis([0.5 6.5 20 100])
ylabel('%')
xlabel('Number of principal components')
title('Day 1')
figure(31)
end;

if (1 == 1)
    figure(32)
    clf
% bar(pc1(:,9:11)) %Dag 3
% bar(pc1(:,5:7)) %Dag 2
bar(pc1(:,1)) %Dag 1
colormap gray
axis([0.5 24.5 0 1])
ylabel('Coefficient')
xlabel('Component')
title('Day 1')
set(gca,'XTick',30);
figure(32)
end;

%% Read contents

features_6_4 = csvread('C:\Temp\6_4.csv'); s_6_4 = size(features_6_4);  
features_6_5 = csvread('C:\Temp\6_5.csv'); s_6_5 = size(features_6_5); 
features_6_6 = csvread('C:\Temp\6_6.csv'); s_6_6 = size(features_6_6); 
features_9_1 = csvread('C:\Temp\9_1.csv'); s_9_1 = size(features_9_1); 
features_9_2 = csvread('C:\Temp\9_2.csv'); s_9_2 = size(features_9_2); 
features_9_3 = csvread('C:\Temp\9_3.csv'); s_9_3 = size(features_9_3); 
features_12_1 = csvread('C:\Temp\12_1.csv'); s_12_1 = size(features_12_1); 
features_12_2 = csvread('C:\Temp\12_2.csv'); s_12_2 = size(features_12_2); 
features_12_2x = csvread('C:\Temp\12_2x.csv'); s_12_2x = size(features_12_2x); 
features_12_4 = csvread('C:\Temp\12_4.csv'); s_12_4 = size(features_12_4); 
features_12_3 = csvread('C:\Temp\12_3.csv'); s_12_3 = size(features_12_3); 

numel_ = s_6_4(1) + s_6_5(1) + s_6_6(1) + s_9_1(1) + s_9_2(1) + s_9_3(1) + s_12_1(1) + s_12_2(1) + s_12_3(1) + s_12_4(1);
features = zeros(numel_,s_6_4(2)); s_feat = size(features);
v_length = 0;
features(v_length+1:v_length+s_6_4(1),1:s_6_4(2)) = features_6_4; v_length = v_length + s_6_4(1);
features(v_length+1:v_length+s_6_5(1),1:s_6_5(2)) = features_6_5; v_length = v_length + s_6_5(1);
features(v_length+1:v_length+s_6_6(1),1:s_6_6(2)) = features_6_6; v_length = v_length + s_6_6(1);
features(v_length+1:v_length+s_9_1(1),1:s_9_1(2)) = features_9_1; v_length = v_length + s_9_1(1);
features(v_length+1:v_length+s_9_2(1),1:s_9_2(2)) = features_9_2; v_length = v_length + s_9_2(1);
features(v_length+1:v_length+s_9_3(1),1:s_9_3(2)) = features_9_3; v_length = v_length + s_9_3(1);
features(v_length+1:v_length+s_12_1(1),1:s_12_1(2)) = features_12_1; v_length = v_length + s_12_1(1);
features(v_length+1:v_length+s_12_2(1),1:s_12_2(2)) = features_12_2; v_length = v_length + s_12_2(1);
features(v_length+1:v_length+s_12_3(1),1:s_12_3(2)) = features_12_3; v_length = v_length + s_12_3(1);
features(v_length+1:v_length+s_12_4(1),1:s_12_4(2)) = features_12_4; v_length = v_length + s_12_4(1);

%% Create training set

perc = 25;
[training, trainingResult,testset,testsetResult] = TrainingSet(features_12_2x(:,1:24), features_12_2x(:,25),perc);
[tree,numnodes,resuberror,cverror,F,T] = DecisionTree(training,trainingResult,testset,testsetResult,cats);
[T' F']

%% Randomise tree ten times

 for i=1:10
[training, trainingResult,testset,testsetResult] = TrainingSet(features(:,1:24), features(:,25),perc);
% % Create tree

 [tree_,numnodes_,resuberror_,crossvalerror_,F_,T_] = DecisionTree(training,trainingResult,testset,testsetResult,cats);    
 nodes(i) = numnodes_;resuberr(i) = resuberror_;cverr(i) = crossvalerror_;
 F(i) = F_; T(i) = T_; 
 end;
 
 
end; % end if
 