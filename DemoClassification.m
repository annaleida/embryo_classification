clear all; close all;
numel_ = 50;
feat = magic(numel_);
tmp = linspace(1,4,4);
true_ =  randn(1,numel_);
true = ones(size(true_));
% true(find(true_>0.7)) = 3;
true(find(true_>0.2)) = 2;
true(find(true_>0.7)) = 3;
true(find(true_>1.2)) = 4;
feat(:,numel_+1) = true;
cats = {};
perc = 20;


[c,t,f] = EvalPlattDAGSVM(feat,cats,perc,numel_);
 [t' f']
 c
 sum(sum(c))