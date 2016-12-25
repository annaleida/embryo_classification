allControl = D1_K; 
 allTreated = D1_E05; 

 cats = {'Found in frame ID','Covered by regions','Scale factor [µm/pxl]','Laser wavelength [nm]','Refractive index cell','Refractive index medium','Area (pxl)','Area (µm²)','Boxed breadth (pxl)','Boxed breadth (µm)','Boxed center pos X (pxl)','Boxed center pos Y (pxl)','Boxed length (pxl)','Boxed length (µm)','Centroid pos X (pxl)','Centroid pos Y (pxl)','Eccentricity','Hull convexity','Irregularity','Optical path length avg (µm)','Optical path length max (µm)','Peak pos X (pxl)','Peak pos Y (pxl)','Perimeter length (pxl)','Perimeter length (µm)','Phaseshift avg','Phaseshift max','Phaseshift min','Phaseshift std. dev.','Phaseshift sum','Roughness avg','Roughness kurtosis','Roughness RMS','Roughness skewness','Shape convexity','Texture clustershade','Texture clustertendency','Texture contrast','Texture correlation','Texture correlation info1','Texture correlation info2','Texture energy','Texture entropy','Texture homogeneity','Texture maxprob','Thickness avg (µm)','Thickness max (µm)','Volume (µm³)'};
% indecesToKeep = [7,24,30]; % 3 PCA
 indecesToKeep = [7,24,30,32,34,42,43,44]; % 8 stat sig
% indecesToKeep = [7,17,18,19,24,26,27,28,29,30,31,32,33,34,35,36,37,38,39,42,43,44]; % 22 tested
cats = removeIrrelevant(cats,cats,indecesToKeep,'cell')

 [allCells,allResults] = removeIrrelevant(allControl, allTreated, indecesToKeep,'double'); 

  perc = 30;
 for i=1:10
 [training, trainingResult,testset,testsetResult] = TrainingSet(allCells, allResults,perc);
% % Create tree

 [tree_,numnodes_,resuberror_,crossvalerror_,sensitivity_,specificity_1_,pos_predict_,neg_predict_] = DecisionTree(training,trainingResult,testset,testsetResult,cats);    
 nodes(i) = numnodes_;resuberr(i) = resuberror_;cverr(i) = crossvalerror_;
 sensitivity(i) = sensitivity_; specificity_1(i) = specificity_1_; 
 pos_predict(i) = pos_predict_; neg_predict(i) = neg_predict_;
 end;
 
 h_nodes(perc,:) = nodes(:);
 h_sensitivity(perc,:) = sensitivity(:);
 h_specificity_1(perc,:) = specificity_1(:);
 h_cverr(perc,:) = cverr(:);
 h_resuberr(perc,:) = resuberr(:);
 h_pos_predict(perc,:) = pos_predict(:);
 h_neg_predict(perc,:) = neg_predict(:);
 
 % Sort out results from simple trees nodes < threshold
 maxNodes = 10;
 nodes2 = nodes(nodes <= maxNodes);
 resuberr2 = resuberr(nodes <= maxNodes);
 cverr2 = cverr(nodes <= maxNodes);
 specificity_12 = specificity_1(nodes <= maxNodes);
 sensitivity2 = sensitivity(nodes <= maxNodes);
 figure(1)
 clf
 plot(nodes,resuberr,'ks','MarkerSize',8,'MarkerFaceColor','k'); hold on;
 plot(nodes2,resuberr2,'ks','MarkerSize',8,'MarkerFaceColor','w'); hold on;
 plot(nodes,cverr,'ko','MarkerSize',8,'MarkerFaceColor','k'); hold on;
 plot(nodes2,cverr2,'ko','MarkerSize',8,'MarkerFaceColor','w'); hold on;
 ylabel('Mean square error');
 xlabel('Number of nodes');
 axis([0 50 0 0.5]);
%  plot(nodes,sensitivity,'g.'); hold on;
%  plot(nodes,specificity_1,'r.'); hold on;
%  plot(nodes,pos_predict,'m.'); hold on;
%  plot(nodes,neg_predict,'c.'); hold on;
hold off;
 figure(2)
 clf
 plot(specificity_1,nodes,'ks','MarkerSize',8,'MarkerFaceColor','k'); hold on;
 plot(specificity_12,nodes2,'ks','MarkerSize',8,'MarkerFaceColor','w');
 axis([0 1 0 50]);
 ylabel('Number of nodes');
 xlabel('1 - Specificity');
 hold off;
 figure(3)
 clf
 plot(specificity_1,sensitivity,'ks','MarkerSize',8,'MarkerFaceColor','k'); hold on;
 plot(specificity_12,sensitivity2,'ks','MarkerSize',8,'MarkerFaceColor','w');
 axis([0 1 0 1]);
 ylabel('Sensitivity');
 xlabel('1 - Specificity');
 hold off;
 
 
 if (1 == 0) % Plot number of training cells
     figure(5)
clf
marker = {'kx','k+','k*'};
for i = 10:10:30
plot(h_nodes(i,:),h_sensitivity(i,:),char(marker(i/10)),'MarkerSize',8,'MarkerFaceColor','k'); hold on;
end;
axis([0 100 0 1]);
hold off;
 end;
 
 % Plot all concentrations for one day
 if (1 == 0)
     figure(6)
clf
marker = {'kd','ks','ko','k.'};
maxNodes = 10;
for i = 1:3
     
%  nodes2 = nodes(h_nodes(i,:) <= maxNodes);
%  resuberr2 = resuberr(h_nodes(i,:) <= maxNodes);
%  cverr2 = cverr(h_nodes(i,:) <= maxNodes);
 specificity_12 = h_specificity_1(i,(h_nodes(i,:) <= maxNodes));
 sensitivity2 = h_sensitivity(i,(h_nodes(i,:) <= maxNodes));
 
plot(h_specificity_1(i,:),h_sensitivity(i,:),char(marker(i)),'MarkerSize',8,'MarkerFaceColor','k'); hold on;
plot(specificity_12,sensitivity2,char(marker(i)),'MarkerSize',8,'MarkerFaceColor','w'); hold on;
end;
axis([0 1 0 1]);
ylabel('Sensitivity');
 xlabel('1 - Specificity');
 title('Day 3');
hold off;
 end;