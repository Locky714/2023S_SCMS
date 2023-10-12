clc
close all
clear
%% Initialise core and subscribers
try
    rosinit("pi");
catch
    disp("ROSCORE unable to start, may already be running, attempting to continue.")
end

% display available topics
% rostopic list;

sub1 = rossubscriber("/usb_cam/image_raw");

%% Extract image
% if still, vid =0
loop = true;
vid =0;
while(loop)
    extract = sub1.receive;
    I  = readImage(extract);
    imshow(I);
    if vid ==0
        loop = false;
    end
end


