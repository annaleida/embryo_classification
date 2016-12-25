function [tree,numnodes,resuberror,cverror,F,T,sfit] = DecisionTree(training,trainingResult,testset,testsetResult,cats)

 
 tree = ClassificationTree.fit(training,trainingResult);
 resuberror = resubLoss(tree);
 cvrtree = crossval(tree);
cverror = kfoldLoss(cvrtree);

% Prune to best level
[~,~,~,bestlevel] = cvLoss(tree,'subtrees','all','treesize','min');
tree = prune(tree,'Level',bestlevel);
numnodes = tree.NumNodes;
%  view(tree,'mode','graph')

%Apply tree
sfit = predict(tree,testset);

T = 0;
for i = 1:numel(sfit)
if (testsetResult(i)==sfit(i))
T = T+1;
end;
end;
F = (numel(sfit) - T)/numel(sfit);
T = T/numel(sfit);
% FN = sum(strcmp(testsetResult,'t')) - TP;
% FP = sum(strcmp(testsetResult,testsetResult)) - TN;
% sensitivity = T/(T+F);
% specificity_1 = 1 - TN/(TN+FP);
% pos_predict = TP/(TP+FP);
% neg_predict = TN/(TN+FN);


% disp 'DecisionTree complete';