

% Fisher iris example:

% % % load fisheriris
% % % d = pdist(meas, 'cosine');
% % % Z = linkage(d, 'complete');
% % % cophen = cophenet(Z,d)
% % % %c = cluster(Z,'maxclust',2:4);
% % % c = cluster(Z,'criterion','distance','cutoff',.006); %Not defining maxclust gives separation between parameter
% % % 
% % % [h,nodes] = dendrogram(Z,6);
% % % [sum(ismember(nodes,[1])) sum(ismember(nodes,[2])) sum(ismember(nodes,[3])) sum(ismember(nodes,[4]))]
% % % 
% % % [table, chi2, p, label] = crosstab(c(:,2),species) %Does NOT produce the same result as hierarchal cluster
% % % 
% % % ptsymb = {'bs','r^','md','go','c+'};
% % % hidx = cluster(Z,'criterion','distance','cutoff',.006);
% % % size(hidx)
% % % max(hidx)
% % % for i = 1:5
% % %     clust = find(hidx==i);
% % %     ssize = size(clust)
% % %     plot3(meas(clust,1),meas(clust,2),meas(clust,3),ptsymb{i}); %Plot the first three dimensions
% % %     % Correlation between 3 and 4 is very strong
% % %     % [table, chi2, p, label] = crosstab(meas(:,3),meas(:,4));
% % %     % Probably meaning they belong to the same set - we do not need to plot
% % %     % this dimension
% % %     hold on
% % % end
% % % hold off
% % % xlabel('Sepal Length'); ylabel('Sepal Width'); zlabel('Petal Length');
% % % view(-137,10);
% % % grid on

allControl = D3_K; 
allTreated = D3_E5; 


[allCells,allResults] = removeIrrelevant(allControl, allTreated, indecesToKeep,'double'); 


meas = allCells;
%d = pdist(meas, 'euclidean');
Z = linkage(meas, 'average', 'euclidean');
%cophen = cophenet(Z,d)
%c = cluster(Z,'maxclust',2:4);
hidx = cluster(Z,'criterion','distance','maxclust',6); %Not defining maxclust gives separation between parameter

[h,nodes] = dendrogram(Z,4);
[sum(ismember(nodes,[1])) sum(ismember(nodes,[2])) sum(ismember(nodes,[3])) sum(ismember(nodes,[4])) sum(ismember(nodes,[5])) sum(ismember(nodes,[6])) sum(ismember(nodes,[7])) sum(ismember(nodes,[8])) sum(ismember(nodes,[9])) sum(ismember(nodes,[10]))]'
figure(41)
ptsymb = {'bs','r^','md','go','c+','ko'};
%size(hidx)
%max(hidx)
for i = 1:6
    clust = find(hidx==i);
    ssize = size(clust);
    plot3(meas(clust,1),meas(clust,2), meas(clust,3),ptsymb{i}); %Plot the first three dimensions
    % Correlation between 3 and 4 is very strong
    % [table, chi2, p, label] = crosstab(meas(:,3),meas(:,4));
    % Probably meaning they belong to the same set - we do not need to plot
    % this dimension
    hold on
end
hold off
xlabel('Area'); ylabel('Phaseshift sum'); zlabel('??');
view(-137,10);
grid on

disp 'HierarchalAnalysis complete';