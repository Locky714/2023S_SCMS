function [T, rot,scale,tform] = FeatureExtraction(image, reference,output,type)
if nargin ==0
image = imread("tag_rot_60.jpg");
reference = imread("tag.jpg");
end
if nargin<3
    output= 0; 
end
if nargin < 4
    type = "SIFT";
end
% 
% image_harris_corners = detectHarrisFeatures(image,"MinQuality",0.3);
% reference_harris_corners = detectHarrisFeatures(reference,"MinQuality",0.3);
% 
% figure("Name","Harris")
% tiledlayout( "flow")
% nexttile;
% imshow(image);
% hold on;
% plot(image_harris_corners);
% hold off
% title("Image")
% 
% nexttile
% imshow(reference);
% hold on
% plot(reference_harris_corners);
% hold off
% title("harris")

switch type
    case "SIFT"
        reference_points = detectSIFTFeatures(reference);
        image_points = detectSIFTFeatures(image);
    case "SURF"
        reference_points = detectSURFFeatures(reference);
        image_points = detectSURFFeatures(image);
    case "ORB"
        reference_points = detectORBFeatures(reference);
        image_points = detectORBFeatures(image);
    case "BRISK"
        reference_points = detectBRISKFeatures(reference);
        image_points = detectBRISKFeatures(image);
    case "KAZE"
        reference_points = detectKAZEFeatures(reference);
        image_points = detectKAZEFeatures(image);
    otherwise
        disp("NO TYPE SET");
end

[reference_features, reference_validPoints] = extractFeatures(reference,reference_points,"Upright",false);
[image_features, image_validPoints] = extractFeatures(image,image_points,"Upright",false); 

indexPairs = matchFeatures(reference_features,image_features);
reference_matchedPoints = reference_validPoints(indexPairs(:,1));
image_matchedPoints = image_validPoints(indexPairs(:,2));
[tform, inlierDistorted, inlierOriginal] = estimateGeometricTransform(image_matchedPoints,reference_matchedPoints,'similarity');

% Displaying scale and rotation of transform.
Tinv = tform.invert.T;
ss = Tinv(2,1);
sc = Tinv(1,1);
scale = sqrt(ss*ss+sc*sc);

% Accessing for output from function.
T = tform.T;

rot = atan2(ss,sc)*180/pi;
% 
% disp("Rot = "+rot)
% disp("Scale = " + scale)

if output
    figure('Name',"OUTPUT IMAGES")
    tiledlayout('flow');
    nexttile;
    showMatchedFeatures(reference,image,reference_matchedPoints,image_matchedPoints,'montage');
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