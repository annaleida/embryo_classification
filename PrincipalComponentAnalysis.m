myInd = 12; % change for each konc.
clear vComp allCells allResults control treated
% **************************************************
% Single cell
if (1 == 1)
allControl = D3_K; 
allTreated = D3_E5; 
[allCells,allResults] = removeIrrelevant(allControl, allTreated, indecesToKeep,'double'); 
end;
% **************************************************
% Per sample
if (1 == 0)
% vComp = {cells_D1_E5_1a,cells_D1_E5_1b};
% vComp = {cells_D1_E1_1a,cells_D1_E1_1b,cells_D1_E1_2a,cells_D1_E1_2b};
% vComp = {cells_D1_E05_1a,cells_D1_E05_1b,cells_D1_E05_1c,cells_D1_E05_1d,cells_D1_E05_2a,cells_D1_E05_2b,cells_D1_E05_2c,cells_D1_E05_2d};
% vComp = {cells_D1_E025_1a,cells_D1_E025_1b,cells_D1_E025_1c,cells_D1_E025_2a,cells_D1_E025_2b,cells_D1_E025_2c};
% vCompC = {cells_D1_K_1a,cells_D1_K_1b,cells_D1_K_1c,cells_D1_K_1d,cells_D1_K_1e,cells_D1_K_2a,cells_D1_K_2b,cells_D1_K_2c,cells_D1_K_2d,cells_D1_K_2e};
% vComp = {cells_D2_E5_1a,cells_D2_E5_1b};
% vComp = {cells_D2_E1_1a,cells_D2_E1_1b,cells_D2_E1_2a,cells_D2_E1_2b};
% vComp = {cells_D2_E05_1a,cells_D2_E05_1b,cells_D2_E05_1c,cells_D2_E05_1d,cells_D2_E05_2a,cells_D2_E05_2b,cells_D2_E05_2c,cells_D2_E05_2d};
% vComp = {cells_D2_E025_1a,cells_D2_E025_1b,cells_D2_E025_1c,cells_D2_E025_2a,cells_D2_E025_2b,cells_D2_E025_2c};
% vCompC = {cells_D2_K_1a,cells_D2_K_1b,cells_D2_K_1c,cells_D2_K_1d,cells_D2_K_1e,cells_D2_K_2a,cells_D2_K_2b,cells_D2_K_2c,cells_D2_K_2d,cells_D2_K_2e};
vComp = {cells_D3_E5_1a,cells_D3_E5_1b};
% vComp = {cells_D3_E1_1a,cells_D3_E1_1b,cells_D3_E1_2a,cells_D3_E1_2b};
% vComp = {cells_D3_E05_1a,cells_D3_E05_1b,cells_D3_E05_1c,cells_D3_E05_1d,cells_D3_E05_2a,cells_D3_E05_2b,cells_D3_E05_2c,cells_D3_E05_2d};
% vComp = {cells_D3_E025_1a,cells_D3_E025_1b,cells_D3_E025_1c,cells_D3_E025_2a,cells_D3_E025_2b,cells_D3_E025_2c};
vCompC = {cells_D3_K_1a,cells_D3_K_1b,cells_D3_K_1c,cells_D3_K_1d,cells_D3_K_1e,cells_D3_K_2a,cells_D3_K_2b,cells_D3_K_2c,cells_D3_K_2d,cells_D3_K_2e};
ss = size(vComp);
sss = ss(2);
clear meanTmp_ meanTreat_;
for i = 1:sss 
    clear temp_;
temp_ = removeIrrelevant(allControl, vComp{i}, indecesToKeep,'singleVector'); 
meanTreat_(i,:) = mean(temp_);
meanTmp_(i,:) = (mean(temp_)-meanC)./meanC.*100;
end;
ss2 = size(vCompC);
sss2 = ss2(2);
clear meanCon_;
for i = 1:sss2 
    clear tempC_;
tempC_ = removeIrrelevant(allControl, vCompC{i}, indecesToKeep,'singleVector'); 
meanCon_(i,:) = mean(tempC_);
end;
treated = {'t'};
for i=2:sss;
    treated = [treated;'t'];
end;
control = {'c'};
for i=2:sss2
    control = [control;'c'];
end;
allCells = [meanCon_;meanTreat_];
end;
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
if (1 == 0)
    figure(1)
    clf
bar(relVar(1:4,1:3)) %Dag 1
% bar(relVar(1:4,5:7)) %Dag 2
% bar(relVar(1:4,9:11)) %Dag 3
colormap gray
axis([0.5 4.5 80 100])
ylabel('%')
xlabel('Number of principal components')
title('Day 1')
figure(1)
end;

if (1 == 0)
    figure(2)
    clf
% bar(pc1(:,9:11)) %Dag 3
% bar(pc1(:,5:7)) %Dag 2
bar(pc1(:,1:3)) %Dag 1
colormap gray
axis([0.5 24.5 0 1])
ylabel('Coefficient')
xlabel('Component')
title('Day 1')
set(gca,'XTick',30);
figure(2)
end;


% 
% [1] Jackson, J. E., A User's Guide to Principal Components, John Wiley and Sons, 1991, p. 592.
% 
% [2] Jolliffe, I. T., Principal Component Analysis, 2nd edition, Springer, 2002.
% 
% [3] Krzanowski, W. J. Principles of Multivariate Analysis: A User's Perspective. New York: Oxford University Press, 1988.
% 
% [4] Seber, G. A. F., Multivariate Observations, Wiley, 1984