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
pause(1);

%% Extract image
% if still, vid =0
loop = true;
vid =1;
figure("Name","Stream: RGBD");
tiledlayout(1,2);
while(loop)
    nexttile(1)
    extract_image = receive(sub_image,3);
    I  = readImage(extract_image);
    imshow(I);
    
    nexttile(2)
    extract_depth = receive(sub_depth,3);
    I_depth  = readImage(extract_depth);
    imshow(I_depth,jet,DisplayRange=[]);
    colorbar;

    if vid ==0
        loop = false;
    end
end


