function [C,T,F] = EvalVarDAGSVM(featureV, featT, cats, perc,f_min,f_max,res)

% DAGSVM (variation of)
disp 'var DAGSVM'
C = zeros(max(max(featureV(:,res))));
for i=1:10
Ci = zeros(max(max(featureV(:,res))));
false_hits = 0;
u_max = max(max(featureV(:,res)));
[training, trainingResult,testset,testsetResult] = TrainingSet(featureV(:,f_min:f_max), featureV(:,res),perc);
% Make sure we have all groups in the training set
while length(unique(trainingResult))~=length(unique(featureV(:,res)))
[training, trainingResult,testset,testsetResult] = TrainingSet(featureV(:,f_min:f_max), featureV(:,res),perc);
end;
testset = featT(:,f_min:f_max);
testsetResult = featT(:,res);

uni=unique(featureV(:,res));
    train_res = trainingResult(:);
    test_res = testsetResult(:);
    train_feat = training(:,:);
    test_feat = testset(:,:);
for u_ind=1:length(uni)
    u = uni(u_ind);
    if (u<u_max)
        
    % Rewrite results to only 2 classes
    train_res0 = zeros(size(train_res));
    test_res0 = zeros(size(test_res));
        for k=1:length(train_res)
           if (train_res(k)>u)
               train_res0(k) = 1;
           elseif (train_res(k)==u)
               train_res0(k) = 0;
            end;
       end;

       for k=1:length(test_res)
           if (test_res(k)>u)
               test_res0(k) = 1;
           elseif (test_res(k)==u)
               test_res0(k) = 0;
           end;
       end;  
       
% Classify
% size(train_feat)
% size(train_res0)
% unique(train_res0)
svmStruct = svmtrain(train_feat,train_res0);
test_pred = svmclassify(svmStruct,test_feat);
F_ = abs(test_res0-test_pred);
false_hits = false_hits + sum(sum(F_));

% Remove what has been classified
count = 1;
count2 = 1;
count3 = 1;
train_res2 = [];
train_feat2 = [];
test_res2 = [];
test_feat2 = [];
test_res3 = [];
test_pred3 = [];
test_pred2 = [];

    for k=1:length(train_res)
           if (train_res0(k)==1)
               train_res2(count) = train_res(k);
               train_feat2(count,:) = train_feat(k,:);
                count = count+1;
            end;
       end;
     for k=1:length(test_pred)
           if (test_pred(k)==1)
               test_res2(count2) = test_res(k);
               test_feat2(count2,:) = test_feat(k,:);
               test_pred2(count2) = u+1;
                count2 = count2+1;
           elseif (test_pred(k) == 0)
               % Save what has been classified for construction of
               % confusion matrix
               test_res3(count3) = test_res(k);
               test_pred3(count3) = u;
               count3 = count3+1;
            end;
       end;
test_feat = test_feat2;
test_res = test_res2';
train_feat = train_feat2;
train_res = train_res2';

% Construct confusion matrix
conf_ = ConstructConfusion(test_pred3,test_res3,u_max);
 C = C + conf_;
 Ci = Ci + conf_;
    else
 % Add last class to confusion matrix
 conf_ = ConstructConfusion(test_pred2,test_res2,u_max);
 C = C + conf_;
 Ci = Ci + conf_;
end;
end;
T(i) = sum(diag(Ci))/sum(sum(Ci));  F(i) = 1-T(i); 
end;