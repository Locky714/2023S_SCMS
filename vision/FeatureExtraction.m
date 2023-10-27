function [T, rot,scale,tform] = FeatureExtraction(image, reference,output,type)
if nargin ==0
image = im2gray(imread("vision\demo_tag_paint.jpg"));
reference = im2gray(imread("vision\demo_tag_paint.jpg"));
end
if nargin<3
    output= 0; 
end
if nargin < 4
    type = "SIFT";
end


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

% [reference_features, reference_validPoints] = extractFeatures(reference,reference_points,"Upright",false);
% [image_features, image_validPoints] = extractFeatures(image,image_points,"Upright",false); 
% 
% indexPairs = matchFeatures(reference_features,image_features);
% reference_matchedPoints = reference_validPoints(indexPairs(:,1));
% image_matchedPoints = image_validPoints(indexPairs(:,2));
% [tform, inlierDistorted, inlierOriginal] = estimateGeometricTransform(image_matchedPoints,reference_matchedPoints,'similarity');

% Displaying scale and rotation of transform.
% Tinv = tform.invert.T;
% ss = Tinv(2,1);
% sc = Tinv(1,1);
% scale = sqrt(ss*ss+sc*sc);
% 
% % Accessing for output from function.
% T = tform.T;
% 
% rot = atan2(ss,sc)*180/pi;
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

%%%%%%%%%%%%%%%% APRIL TAG DETECTION
tagFamily = ["tag36h11","tagCircle21h7","tagCircle49h12","tagCustom48h12","tagStandard41h12"];
load("vision\D435i_intrinsics.mat");

tagSize = 140;

image = undistortImage(image,cameraParams.Intrinsics,OutputView="same");

% [id,loc,pose] = readAprilTag(image,"tag36h11",cameraParams.Intrinsics,tagSize);
% 
% worldPoints = [0 0 0; tagSize/2 0 0; 0 tagSize/2 0; 0 0 tagSize/2];
% 
% for i = 1:length(pose)
% 
%     % Get image coordinates for axes.
%     imagePoints = worldToImage(cameraParams.Intrinsics,pose(i),worldPoints);
% 
%     % Draw colored axes.
%     image = insertShape(image,Line=[imagePoints(1,:) imagePoints(2,:); ...
%         imagePoints(1,:) imagePoints(3,:); imagePoints(1,:) imagePoints(4,:)], ...
%         Color=["red","green","blue"],LineWidth=7);
%     
%     image = insertText(image,loc(1,:,i),id(i),BoxOpacity=1,FontSize=25);
% end

[~, ~, tagPose] = readAprilTag(image, tagFamily(1), cameraParams.Intrinsics, tagSize);

[cubeWidth, cubeHeight, cubeDepth] = deal(tagSize);

vertices = [ cubeWidth/2 -cubeHeight/2; 
             cubeWidth/2  cubeHeight/2;
            -cubeWidth/2  cubeHeight/2;
            -cubeWidth/2 -cubeHeight/2 ];

cuboidVertices = [vertices zeros(4,1);
                  vertices (cubeDepth)*ones(4,1)];

projectedVertices = worldToImage(cameraParams.Intrinsics, tagPose(1), cuboidVertices);
figure
augmentedImage = insertShape(image, "projected-cuboid", projectedVertices, ...
    ShapeColor="green", LineWidth=6);
imshow(augmentedImage)


% imshow(image)
end



