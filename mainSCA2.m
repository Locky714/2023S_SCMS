clear all;
close all;
clc

%% Global Variables
global CLOCK_SPEED;
global SHOW_PLOTS;
SetClockSpeed(0.5);
SetShowPlots(true);

%% Setting up Workspace
axis([-2 2 -2 2 0 2]);
hold on

%% Init ArmController for UR3
baseTr{1} = transl(0, 0, 0) * trotz(0,'deg');
ctrlUR3 = ArmController(UR3(baseTr{1}));

%% Establishing Locations
initTr{1} = ctrlUR3.GetJointPose(ctrlUR3.jointCount());
localRelativeTr = transl([0,0,0.5]); % In VS target coordinates

%% setup ros settings and subscribers
[sub1,sub2] = rosSetup;

%% get image
[rgb,depth] = getImage(sub1,sub2);

%% Camera intrinsics imported
load("imageData.mat");

%% Feature Extraction
poseTags = FeatureExtraction(rgb,intrinsics,150);

%% Simulation Variables for GUI
simulateTrigger = true;
EStopTrigger = true;
RMRCMaxRetry = 5;
repeats = 0;

%% Main Loop
while  simulateTrigger
    targetTr = poseTags.A * localRelativeTr;
    ctrlUR3.EStop(EStopTrigger);
    if repeats < RMRCMaxRetry
        qPath = ctrlUR3.genPath(targetTr,'RMRC','Global');
    else
        qPath = ctrlUR3.genPath(targetTr,'Trap','Global');
    end
    [goalReached,error] = ctrlUR3.moveToNextPoint(targetTr,qPath);
    if ~goalReached
        disp('goal not reached')
        disp(error)
        repeats = repeats + 1;
        SetClockSpeed(0.5);
    else
        disp('goal reached')
        disp(error)
        repeats = 0;
        SetClockSpeed(0.1);
        i = i+1;
    end
end
