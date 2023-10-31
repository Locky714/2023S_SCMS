clear all;
close all;
clc

%% Global Variables
global CLOCK_SPEED;
global SHOW_PLOTS;
SetClockSpeed(0.5);

%% Setting up Workspace
axis([-1 1 -1 1 0 1]);
hold on
image_output = 0;

%% Init ArmController for UR3
baseTr{1} = transl(0, 0, 0) * trotz(0,'deg');
ctrlUR3 = ArmController(UR3(baseTr{1}));

%% Establishing Locations
initTr{1} = ctrlUR3.GetJointPose(ctrlUR3.jointCount());
localRelativeTr = transl([0,0,0.5]); % In VS target coordinates

%% setup ros settings and subscribers
[sub1,sub2] = rosSetup;

%% get image
% [rgb,depth] = getImage(sub1,sub2);

%% Camera intrinsics imported
load("vision\LW_D415.mat");
% intrinsics = cameraParams.Intrinsics;

%% Feature Extraction
% poseTags = FeatureExtraction(rgb,intrinsics,150);
% 
% if size(poseTags) == 0
%     disp("NO TAG DETECTED: PAUSING");
%     pause;
% end

%% Simulation Variables for GUI
simulateTrigger = true;
EStopTrigger = false;
RMRCMaxRetry = 5;
repeats = 0;

%% Main Loop
while  simulateTrigger
[rgb,depth] = getImage(sub1,sub2);
disp("NEW IMAGE");
poseTags = FeatureExtraction(rgb,intrinsics,150);
 
if size(poseTags) == 0
    disp("NO TAG DETECTED: PAUSING");
    pause;
    [rgb,depth] = getImage(sub1,sub2);
    disp("NEW IMAGE");
    poseTags = FeatureExtraction(rgb,intrinsics,150);
    if size(poseTags) == 0
        disp("No Tag x2");
        pause;
    end
end


    targetTr = poseTags.A * localRelativeTr;
    % Converting units to metres
    targetTr(:,4 ) = [
        targetTr(1,4)/1000;
        targetTr(2,4)/1000;
        targetTr(3,4)/1000;
1
        ];
    ctrlUR3.EStop(EStopTrigger);
    if repeats < RMRCMaxRetry
        qPath = ctrlUR3.genPath(targetTr,'RMRC','Global');
    else
        qPath = ctrlUR3.genPath(targetTr,'Trap','Global');
    end
    [goalReached,error] = ctrlUR3.moveToNextPoint(targetTr,qPath);
    if ~goalReached
        disp('goal not reached')
        disp(error);
        repeats = repeats + 1;
        SetClockSpeed(0.5);
    else
        disp('goal reached')
        disp(error);
        repeats = 0;
        SetClockSpeed(0.1);
        i = i+1;
    end
end
