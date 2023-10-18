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
figure("Name","Stream: RGBD");
tiledlayout(1,2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% https://au.mathworks.com/help/vision/ref/pcfromdepth.html

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    tag = imread("tag.jpg");

while(loop)
    nexttile(1)
    extract_image = receive(sub_image,3);
    I  = readImage(extract_image);
    I = im2bw(I);
    imshow(I);

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





        nexttile(2)
        extract_depth = receive(sub_depth,3);
        I_depth  = readImage(extract_depth);
        imshow(I_depth,colorcube,DisplayRange=[]);
        colorbar;

    if vid ==0
        loop = false;
    end
end


