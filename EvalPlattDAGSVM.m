function [C,T,F] = EvalPlattDAGSVM(featureV, cats, perc,f_min,f_max,res)

% DAGSVM Platt
disp 'Platt'
unique_results = unique(featureV(:,res));
C = zeros(max(max(unique_results)));


for i=1:10
false_hits = 0;
[training, trainingResult,testset,testsetResult] = TrainingSet(featureV(:,f_min:f_max), featureV(:,res),perc);
% Make sure all results are present in training set
while length(unique(trainingResult))~=length(unique(featureV(:,res)))
[training, trainingResult,testset,testsetResult] = TrainingSet(featureV(:,f_min:f_max), featureV(:,res),perc);
end;

    test_id = linspace(1,length(testsetResult),length(testsetResult));
    % Result vectors
    total_result_ids = [];
    total_pred = [];
    
    % Initialize
    nodes = {};
    nodes{1}{1} = sort(unique_results(:));  % options: list of options for classification
    nodes{1}{2} = test_id; % ids: list of ids (rows in the original feature vector)
    %   Each member of ids will eventually be classified in one of the classes in options.
    %   Each classification is only between two values in options.
    %   Iteration continues until options only contains two values.
    
    while length(nodes) ~= 0
        % Read the first node
        this_node = nodes{1};
        test_feat = [];
        for k = 1:length(this_node{2})
         test_feat(k,:) = testset(this_node{2}(k),:);
        end;
        
        if length(test_feat)==0
        disp 'WARNING: Empty feature vector!'
        else
        % Process node
        class_op1 = this_node{1}(1);
        class_op2 = this_node{1}(length(this_node{1}));
        svmStruct = Construct1v1svm(training,trainingResult,class_op1,class_op2);
        
        test_pred = svmclassify(svmStruct, test_feat);
        %Separate results
        pred1 = []; new_id1 = []; c1 = 1;
        not_id1 = []; c1_0 = 1;
        pred2 = []; new_id2 = []; c2 = 1;
        not_id2 = []; c2_0 = 1;
        for k=1:length(test_pred)
            if test_pred(k)==class_op1
                pred1(c1) = test_pred(k);
                new_id1(c1) = this_node{2}(k);
                c1 = c1+1;
            else
                not_id1(c1_0) = this_node{2}(k);
                c1_0 = c1_0 +1;
            end;
            if test_pred(k)==class_op2
                pred2(c2) = test_pred(k);
                new_id2(c2) = this_node{2}(k);
                c2 = c2+1;
            else
                not_id2(c2_0) = this_node{2}(k);
                c2_0 = c2_0 +1;
            end;
        end;
        
                % Test for completeness
        if min(this_node{1}) == max(this_node{1})-1
            total_pred(length(total_pred)+1:length(total_pred)+length(pred1)) = pred1;
            total_result_ids(end+1:end+length(new_id1)) = new_id1;
            total_pred(length(total_pred)+1:length(total_pred)+length(pred2)) = pred2;
            total_result_ids(end+1:end+length(new_id2)) = new_id2;
        else
            % Create 2 new branches
            new_node1 = length(nodes)+1;
            nodes{new_node1}{1} = this_node{1}(1:end-1);
            nodes{new_node1}{2} = not_id2;
%             nodes{new_node1}
            new_node2 = length(nodes)+1;
            nodes{new_node2}{1} = this_node{1}(2:end);
            nodes{new_node2}{2} = not_id1;
%             nodes{new_node2}
        end;
        end;
        
        % Remove the last read node
            new_nodes = {};
            for k = 2:length(nodes)
            new_nodes{k-1} = nodes{k};
            end;
            nodes = new_nodes;
    end;
    
    
    % COmbine result
    total_result = zeros(length(total_pred),3);
    total_result(:,1) = total_result_ids;
    total_result(:,2) = total_pred;
    for k=1:length(total_pred)
        total_result(k,3) = testsetResult(total_result_ids(k));
        if (total_result(k,2)~=total_result(k,3))
            false_hits = false_hits + 1;
        end;
    end;
    total_result = sortrows(total_result,1);
    % Remove doublets from result
    total_result = unique(total_result,'rows');
    ss = size(total_result); len_pred = ss(1);
    if len_pred> length(testsetResult)
        disp 'Warning: doublets!'    
    end;
    % Create confusion matrix
    conf_ = ConstructConfusion(total_result(:,2),total_result(:,3),max(max(unique_results)));
    C = C + conf_;
    T(i) = sum(diag(conf_))/sum(sum(conf_));  F(i) = 1-T(i);
end;