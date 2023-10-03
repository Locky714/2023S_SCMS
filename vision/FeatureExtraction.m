function [tform,scale,rot] = FeatureExtraction(image, reference,output)
if nargin==2
    output= 0;
end
reference = rgb2gray(reference);
image = rgb2gray(image);

points1 = detectSURFFeatures(reference);
points2 = detectSURFFeatures(image);

[features1, validPoints1] = extractFeatures(reference,points1);
[features2, validPoints2] = extractFeatures(image,points2);

indexPairs = matchFeatures(features1,features2);
matchedPoints1 = validPoints1(indexPairs(:,1));
matchedPoints2 = validPoints2(indexPairs(:,2));

[tform, inlierDistorted, inlierOriginal] = estimateGeometricTransform(matchedPoints2,matchedPoints1,'similarity');
Tinv = tform.invert.T;
ss = Tinv(2,1);
sc = Tinv(1,1);
scale = sqrt(ss*ss+sc*sc);
rot = atan2(ss,sc)*180/pi;
if output
    figure('Name',"OUTPUT IMAGES")
    tiledlayout('flow');
    nexttile;
    showMatchedFeatures(reference,image,matchedPoints1,matchedPoints2,'montage');
    title("Showing matched pairs");

    nexttile;
    showMatchedFeatures(reference,image,inlierOriginal,inlierDistorted);
    title("Matching points (inliers only)");
    legend('ptsOriginal','ptsDistorted');
    outputView = imref2d(size(image));
    recovered = imwarp(image,tform, 'OutputView',outputView);

    nexttile;
    imshowpair(reference,recovered,'montage');
    title('kfc1 and 2 - 2nd rotated to match 1st perspective');
end
end