function [sub_image,sub_depth]= rosSetup

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

sub_image = rossubscriber('/camera/color/image_raw');
sub_depth = rossubscriber("/camera/depth/image_rect_raw");

pause(0.5);

% display available topics
% rostopic list;
end