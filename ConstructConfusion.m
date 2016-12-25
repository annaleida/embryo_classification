function conf = ConstructConfusion(pred, true, forceSize)

pred;
true;
maxPred = max(max(unique(pred)));
maxTrue = max(max(unique(true)));
numel_ = max(maxPred,max(maxTrue, forceSize));
if length(numel_) == 0
    numel_ = forceSize;
end;
conf = zeros(numel_);
Corr = abs(1-im2bw(abs(pred-true)));

% Off diagonal
for row = 1:numel_
    for col = 1:numel_
        if (row ~= col)
            True_ = zeros(size(true));
            True_(find(true-col==0)) = 1;
            Pred_ = zeros(size(pred));
            Pred_(find(pred-row==0)) = 1;
            conf(col,row) = sum(True_.*Pred_);
        end;
    end;
end;

% Diagonal - correct hits
for d = 1:numel_
    Tmp1 = zeros(size(pred));
    Tmp1(find(true-d==0)) = 1;
    Tmp = Tmp1.*Corr; % This matrx has 1 only for correct classification of class in question(d)
    conf(d,d) = numel(find(Tmp==1));
end;

    if (sum(sum(conf)) ~= length(pred))
%         disp 'WARNING: Incorrect confusion!';
    end;
    