function features = ExtractFeatures(filepath, radiusFactor)


I0 = imread(filepath); I0 = I0(:,:,1);

sizeX = 500;
sizeY = 500;
max_centroid_radius = 1; %What is the min distance for several structures to count as the same?
body_radii_min =100;
body_radii_max = 120;
body_radii = body_radii_min:10:body_radii_max; %min radi:step size:max radi
no_bodies = 1; %In this script - can only detect 1 body
%core_radii = 3:1:5; %min radi:step size:max radi
plot_me = 0;

e = edge(I0, 'canny');
%% Carry out the HT

body_h = circle_hough(e, body_radii, 'same', 'normalise');

%core_h = circle_hough(e, core_radii, 'same', 'normalise');
%same: only circles whose center is inside image are detected.
%normalise: prevents larger circles from getting more votes

%% Find some peaks in the accumulator
body_peaks = circle_houghpeaks(body_h, body_radii, 'nhoodxy', 15, 'nhoodr', 21, 'npeaks', no_bodies);
%returns (x,y,radius)
for peak=body_peaks
    comp_cen_x = peak(1);
    comp_cen_y = peak(2);
    radius = peak(3);
        [x, y] = circlepoints(peak(3)); %Compute vector of points with radius peak(3)
if plot_me == 1
figure(1); imshow(I0); axis on; hold on;

% plot(x+peak(1), y+peak(2), 'c-', 'lineWidth', 2); 
plot(comp_cen_x, comp_cen_y, 'c*');
end;
end;

 %%
% pos = ginput(2)
% diff = (pos(2,:) - pos(1,:))/2
% radius = sqrt(dot(diff,diff)/2)
% center = pos(1,:) + diff
center = [comp_cen_x comp_cen_y];
radius = radius/radiusFactor; % Uncomment to reduce radius by factor
[X,Y] = ndgrid((1:sizeY) - center(2),(1:sizeX) - center(1) );
emb_mask = (X.^2 + Y.^2)>radius^2;
% [X,Y] = ndgrid((1:600) - center(2),(1:1500) - center(1) );
% mask = (X.^2 + Y.^2)>radius^2;

if plot_me == 1
contour(emb_mask, 'Color', 'w', 'lineWidth', 2);
end;

I4 = double(I0(find(emb_mask == 0))); % pixels without NaN
emb_mask = abs(emb_mask-1);
I1 = nan(sizeY,sizeX);
I1(emb_mask == 1) = 1;
I2 = (I1).*double(I0); % Fullsize vector with NaN
% figure(4)
% imshow(I2)
% figure(2); imshow(Imask);
I3 = double(reshape(I2, 250000,1)); % Fullsize vector with NaN, reshaped
I5 = (emb_mask).*double(I0); % Fullsize vector with 0
I6 = double(reshape(I5, 250000,1)); % Fullsize vector with 0, reshaped
features = zeros(12,1);
features(1) = mean(I4); % Mean
features(2) = var(I4); % Variance
features(3) = max(I4); % Max
features(4) = min(I4); % Min
features(5) = sqrt(sum(I4.*conj(I4))/size(I4,1)); % RMS
features(6) = kurtosis(I4); % Kurtosis
features(7) = skewness(I4); % Skewness
stats = graycoprops(I5);
features(8) = stats.Energy; % T Energy
features(9) = entropy(I4); % T Entropy
features(10) = stats.Contrast;% T Contrast
features(11) = stats.Correlation;% T Correlation
features(12) = stats.Homogeneity;% T Homogeneity



