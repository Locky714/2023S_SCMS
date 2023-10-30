function [rgb,depth] = getImage(sub_image,sub_depth,output)

if nargin <=2
    output =0;
end

% min_depth = 25; %Min depth in 0-1
max_depth = 4000; %Max depth in 0-65535

% depth_scale = 0.1015; %conversion to cm, =0.001015 for meters.

extract_image = receive(sub_image,3);
extract_depth = receive(sub_depth,3);

I  = readImage(extract_image);
I_depth  = readImage(extract_depth);
% scaled_depth_matrix_image = depth_scale.*I_depth;

if output ==1
    figure("Name","Stream: RGBD");
    tiledlayout(1,2);
    nexttile(1)
    imshow(I);
    nexttile(2)
    imshow(I_depth,"Colormap",jet,"DisplayRange",[0 max_depth]); % colormaps: hsv,colorcube,prism,spring,winter,jet,lines
end

rgb = I;
depth = I_depth;
end