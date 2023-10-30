clc
close all
clear

%% setup ros settings and subscribers
[sub1,sub2] = rosSetup;

%% get image
[rgb,depth] = getImage(sub1,sub2);

%% Camera intrinsics imported
load("LW_D415.mat");

%% Feature Extraction

poseTags = FeatureExtraction(rgb,intrinsics,150);