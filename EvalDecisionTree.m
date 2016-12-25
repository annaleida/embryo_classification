function [C,T,F] = EvalDecisionTree(featureV, featT, cats, perc,f_min,f_max,res)

C = zeros(max(max(featureV(:,res))));
unique_results = unique(featureV(:,res));

disp 'DecTree'
for i=1:10
    
[training, trainingResult,testset,testsetResult] = TrainingSet(featureV(:,f_min:f_max), featureV(:,res),perc);
% % Create tree
testset = featT(:,f_min:f_max);
testsetResult = featT(:,res);

 [tree_,numnodes_,resuberror_,crossvalerror_,F_,T_,fit] = DecisionTree(training,trainingResult,testset,testsetResult,cats);    
 nodes(i) = numnodes_;resuberr(i) = resuberror_;cverr(i) = crossvalerror_;
 conf_ = ConstructConfusion(fit,testsetResult,max(max(unique_results)));
 C = C + conf_;
 F(i) = F_; T(i) = T_; 
 end;