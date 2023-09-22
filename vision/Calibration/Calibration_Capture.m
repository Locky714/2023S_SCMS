%% Calibration capture
% A script to be used to capture image data for use with the camera
% calibration toolbox provided in Sensors and Control 2023S

cam_rgb = webcam("Intel(R) RealSense(TM) Depth Camera 435i RGB");

% cam_depth = webcam("Intel(R) RealSense(TM) Depth Camera 435i Depth");
cam_rgb.set("Resolution","1920x1080");

num_images = 30;

tiledlayout("flow");

for i =1:num_images
    nexttile;
    % Capture image
    I_rgb = snapshot(cam_rgb);
    % Convert to greyscale
    I_gs = rgb2gray(I_rgb);
    imshow(I_gs);
    title("Image: "+i);
    % File name string
    name = "calib_"+i;
    clc;
    disp("Image: "+i+" / "+num_images);
    %output to calibration images file
    imwrite(I_gs,name+".jpg");
    % Wait for user to reposition
    pause;
end