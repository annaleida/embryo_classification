 function svmstruct = Construct1v1svm(feat, group, val1, val2)
% Train an SVM to separate <feat> in thw two groups <val1> and <val2>,
% where <val1> and <val2> are classes in <group>.
 
train_feat = [];
    train_res = [];
    c = 1;
        for k=1:length(group)
           if (group(k)==val1)
               train_res(c) = val1;
               train_feat(c,:) = feat(k,:);
               c = c+1;
           elseif (group(k)==val2)
               train_res(c) = val2;
               train_feat(c,:) = feat(k,:);
               c = c+1;
            end;
       end;
       svmstruct = svmtrain(train_feat,train_res);