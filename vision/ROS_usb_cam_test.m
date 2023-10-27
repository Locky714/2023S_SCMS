clc
close all
clear
try
    rosshutdown
    disp("ROSCORE Shutdown")
catch ME
    disp("No roscore running")
end
%% Initialise core and subscribers

setenv('ROS_MASTER_URI','http://192.168.2.1:11311'); % LAN Connection - "rosinit(pi)" works for wlan0 ??????????
setenv('ROS_MASTER_IP_ADDRESS','192.168.2.1');
try
    rosinit;
catch
    disp("ROSCORE unable to start, may already be running, attempting to continue.")
end

% display available topics
% rostopic list;

sub_image = rossubscriber('/camera/color/image_raw');
sub_depth = rossubscriber("/camera/depth/image_rect_raw");

pub1 = rospublisher("/PBVS/T","geometry_msgs/Transform");
pause(1);

%% Extract image
% if still, vid =0
clc;
close all;
loop = true;
vid =1;
frame_ID = 0;
figure("Name","Stream: RGBD");
tiledlayout(1,2);

% min_depth = 25; %Min depth in 0-1
max_depth = 4000; %Max depth in 0-65535

depth_scale = 0.1015; %conversion to cm, =0.001015 for meters.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% https://au.mathworks.com/help/vision/ref/pcfromdepth.html

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

tag = imread("tag.jpg");

while(loop)
    frame_ID = frame_ID+1;


    extract_image = receive(sub_image,3);
    extract_depth = receive(sub_depth,3);


    I  = readImage(extract_image);
    I_depth  = readImage(extract_depth);
    scaled_depth_matrix_image = depth_scale.*I_depth;


    nexttile(1)
    imshow(I);
%     title("RGB: Frame = "+frame_ID)


    nexttile(2)
    imshow(I_depth,"Colormap",jet,"DisplayRange",[0 max_depth]); % colormaps: hsv,colorcube,prism,spring,winter,jet,lines
%     title("Depth Frame = "+frame_ID)
    %     colorbar

    if vid ==0
        loop = false;
    end
end

%     pause(0.5);

%     I_next = receive(sub_image,3);
%     I_next = readImage(I_next);
%     imshow(I_next);
%     I_next = im2gray(I_next);
%     try
%         [T,rotation,scale] = FeatureExtraction(I,tag);
%     catch
%         disp("UNABLE TO GRAB FEATURES");
%     end
%     try
%         rotation = eul2quat([rotation,0,0]);
%     catch
%         disp("UNABLE TO GET ANGLES");
%     end
%
%     translation_msg = rosmessage("geometry_msgs/Vector3");
%     translation_msg.X = T(3,1);
%     translation_msg.Y = T(3,2);
%     translation_msg.Z = 0;
%
%     rotation_msg = rosmessage("geometry_msgs/Quaternion");
% %     rotation_msg = rotm2quat(T);
%
%
%     msg = rosmessage("geometry_msgs/Transform");
%     msg.Translation = translation_msg;
% %     msg.Rotation = rotation_msg;
%     pub1.send(msg);
