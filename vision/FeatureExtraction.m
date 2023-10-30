function [tagPose] = FeatureExtraction(image,intrinsics,tagSize,output)
if nargin <=3
    output= 0;
end
% APRIL TAG DETECTION
tagFamily = ["tag36h11","tagCircle21h7","tagCircle49h12","tagCustom48h12","tagStandard41h12"];

image = undistortImage(image,intrinsics,OutputView="same");

[id, loc, tagPose] = readAprilTag(image, tagFamily(1), intrinsics, tagSize);

if output ==1

    worldPoints = [0 0 0; tagSize/2 0 0; 0 tagSize/2 0; 0 0 tagSize/2];

    for i = 1:length(tagPose)
        % Get image coordinates for axes.
        imagePoints = world2img(worldPoints,tagPose(i),intrinsics);

        % Draw colored axes.
        image = insertShape(image,Line=[imagePoints(1,:) imagePoints(2,:); ...
            imagePoints(1,:) imagePoints(3,:); imagePoints(1,:) imagePoints(4,:)], ...
            ShapeColor=["red","green","blue"],LineWidth=7);

        image = insertText(image,loc(1,:,i),id(i),BoxOpacity=1,FontSize=25);
    end

    imshow(image)

end
end

%% Different detect feature methods
% type = "BRISK";

% if nargin ==0
%     image = im2gray(imread("vision\tag_rot_60.jpg"));
%     reference = im2gray(imread("vision\tag.jpg"));
% end

% switch type
%     case "SIFT"
%         reference_points = detectSIFTFeatures(reference);
%         image_points = detectSIFTFeatures(image);
%     case "SURF"
%         reference_points = detectSURFFeatures(reference);
%         image_points = detectSURFFeatures(image);
%     case "ORB"
%         reference_points = detectORBFeatures(reference);
%         image_points = detectORBFeatures(image);
%     case "BRISK"
%         reference_points = detectBRISKFeatures(reference);
%         image_points = detectBRISKFeatures(image);
%     case "KAZE"
%         reference_points = detectKAZEFeatures(reference);
%         image_points = detectKAZEFeatures(image);
%     otherwise
%         disp("NO TYPE SET");
% end
%
% [reference_features, reference_validPoints] = extractFeatures(reference,reference_points,"Upright",false);
% [image_features, image_validPoints] = extractFeatures(image,image_points,"Upright",false);
%
% indexPairs = matchFeatures(reference_features,image_features);
% reference_matchedPoints = reference_validPoints(indexPairs(:,1));
% image_matchedPoints = image_validPoints(indexPairs(:,2));
% [tform, inlierDistorted, inlierOriginal] = estimateGeometricTransform(image_matchedPoints,reference_matchedPoints,'similarity');
%
% % % Displaying scale and rotation of transform.
% Tinv = tform.invert.T;
% ss = Tinv(2,1);
% sc = Tinv(1,1);
% scale = sqrt(ss*ss+sc*sc)
%
% % Accessing for output from function.
% T = tform.T
%
% rot = atan2(ss,sc)*180/pi
%
% disp("Rot = "+rot)
% disp("Scale = " + scale)
%
% if output
%     figure('Name',"OUTPUT IMAGES: Filtering: "+type)
%     tiledlayout(1,3);
%     nexttile(1);
%     showMatchedFeatures(reference,image,reference_matchedPoints,image_matchedPoints,'montage');
%     title("Showing matched pairs. Filtering type: "+type);
%
%     nexttile(2);
%     showMatchedFeatures(reference,image,inlierOriginal,inlierDistorted);
%     title("Matching points (inliers only)");
%     legend('ptsOriginal','ptsDistorted');
%     outputView = imref2d(size(image));
%     recovered = imwarp(image,tform, 'OutputView',outputView);
%
%     nexttile(3);
%     imshowpair(reference,recovered,'montage');
%     title('Image and Reference - 2nd rotated to match 1st perspective');
% end






