function T = harrisCornerFeatureMatching()


I = im2gray(imread("I1.jpg"));
I2 = im2gray(imread("I2.jpg"));
T = 0;
minQuality =0.3;

[imagePoints,boardSize] = detectCheckerboardPoints(I);

  % Insert markers at detected point locations
  I = insertMarker(I, imagePoints, 'o', 'Color', 'red', 'Size', 10);

  % Display image
  imshow(I);


% cp = detectHarrisFeatures(I,"MinQuality",minQuality);
% cp_w = detectHarrisFeatures(I2,"MinQuality",minQuality);
% 
% 
% [I_features, I_validPoints] = extractFeatures(I,cp,"Upright",false);
% [I2_features, I2_validPoints] = extractFeatures(I2,cp_w,"Upright",false);
% 
% 
% indexPairs = matchFeatures(I2_features,I_features);
% I_matchedPoints = I_validPoints(indexPairs(:,2));
% I2_matchedPoints = I2_validPoints(indexPairs(:,1));
% 
% showMatchedFeatures(I,I2,I_matchedPoints,I2_matchedPoints,'montage');
% 
% [tform, inlierDistorted, inlierOriginal] = estimateGeometricTransform(I2_matchedPoints,I_matchedPoints,'similarity');

Target = cp.Location;
Obs = cp_w.Location;
imshow(I)
% imshowpair(I,I2)
hold on;
plot(cp)

%%%%%%%% Camera parameters
f = 400;
p = length(I)/2;
Z = 50;
l = 0.1; %lambda 

%%%%%%%
xy = (Target-p)/f;
Obsxy = (Obs-p)/f;

n = length(Target(:,1));

Lx = [];
for i=1:n;
    Lxi = FuncLx(xy(i,1),xy(i,2),Z);
    Lx = [Lx;Lxi];
end

e2 = Obsxy-xy;
e = reshape(e2',[],1);
de = -e*l;

Lx2 = inv(Lx'*Lx)*Lx';
Vc = -l*Lx2*e


