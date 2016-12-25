function [training, trainingResult,testset,testsetResult] = TrainingSet(allCells, allResults,perc)
sizeAll = size(allCells);
nbrOfTrainingCells = round(sizeAll(1)*perc./100);
training = zeros(nbrOfTrainingCells,sizeAll(2));
%testset = zeros(sizeAll(1)-nbrOfTrainingCells,sizeAll(2));
testset = allCells;
testsetResult = allResults;
for i=1:nbrOfTrainingCells
    tempSize = size(testset);
    x = randint(1,1,[1,tempSize(1)]);
    %check1 = testset(x,:)'
    training(i,:) = testset(x,:);
    trainingResult(i,:) = testsetResult(x,:);
    testset = testset([1:x-1,x+1:tempSize(1)],:);
    testsetResult = testsetResult([1:x-1,x+1:tempSize(1)],:);
    %check2 = testset(x,:)'
end;

% disp 'TrainingSet complete';

