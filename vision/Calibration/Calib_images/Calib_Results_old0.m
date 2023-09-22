% Intrinsic and Extrinsic Camera Parameters
%
% This script file can be directly executed under Matlab to recover the camera intrinsic and extrinsic parameters.
% IMPORTANT: This file contains neither the structure of the calibration objects nor the image coordinates of the calibration points.
%            All those complementary variables are saved in the complete matlab data file Calib_Results.mat.
% For more information regarding the calibration model visit http://www.vision.caltech.edu/bouguetj/calib_doc/


%-- Focal length:
fc = [ 1375.255730757642141 ; 1375.644318476405942 ];

%-- Principal point:
cc = [ 972.823069404811577 ; 548.578526087560704 ];

%-- Skew coefficient:
alpha_c = 0.000000000000000;

%-- Distortion coefficients:
kc = [ 0.065166961806759 ; -0.053603241823472 ; -0.000220366269141 ; -0.000054782923108 ; 0.000000000000000 ];

%-- Focal length uncertainty:
fc_error = [ 13.942269756921796 ; 14.499558151222764 ];

%-- Principal point uncertainty:
cc_error = [ 8.281966575720881 ; 5.000282330072911 ];

%-- Skew coefficient uncertainty:
alpha_c_error = 0.000000000000000;

%-- Distortion coefficients uncertainty:
kc_error = [ 0.012163016300485 ; 0.074683625478282 ; 0.001396075303258 ; 0.001687859819147 ; 0.000000000000000 ];

%-- Image size:
nx = 1920;
ny = 1080;


%-- Various other variables (may be ignored if you do not use the Matlab Calibration Toolbox):
%-- Those variables are used to control which intrinsic parameters should be optimized

n_ima = 30;						% Number of calibration images
est_fc = [ 1 ; 1 ];					% Estimation indicator of the two focal variables
est_aspect_ratio = 1;				% Estimation indicator of the aspect ratio fc(2)/fc(1)
center_optim = 1;					% Estimation indicator of the principal point
est_alpha = 0;						% Estimation indicator of the skew coefficient
est_dist = [ 1 ; 1 ; 1 ; 1 ; 0 ];	% Estimation indicator of the distortion coefficients


%-- Extrinsic parameters:
%-- The rotation (omc_kk) and the translation (Tc_kk) vectors for every calibration image and their uncertainties

%-- Image #1:
omc_1 = [ 2.167753e+00 ; 2.115096e+00 ; 1.689313e-01 ];
Tc_1  = [ -6.469029e+01 ; -3.412713e+01 ; 4.635441e+02 ];
omc_error_1 = [ 4.738173e-03 ; 3.993380e-03 ; 9.348195e-03 ];
Tc_error_1  = [ 2.823619e+00 ; 1.691707e+00 ; 4.950077e+00 ];

%-- Image #2:
omc_2 = [ 2.382458e+00 ; 1.840388e+00 ; 2.117268e-01 ];
Tc_2  = [ -7.420759e+01 ; -3.409158e+01 ; 4.398805e+02 ];
omc_error_2 = [ 4.768516e-03 ; 3.320852e-03 ; 8.829298e-03 ];
Tc_error_2  = [ 2.691255e+00 ; 1.602660e+00 ; 4.710989e+00 ];

%-- Image #3:
omc_3 = [ -2.247566e+00 ; -2.006561e+00 ; -3.875276e-01 ];
Tc_3  = [ -6.527453e+01 ; -2.255902e+01 ; 4.226457e+02 ];
omc_error_3 = [ 3.431066e-03 ; 4.136290e-03 ; 8.929493e-03 ];
Tc_error_3  = [ 2.564303e+00 ; 1.541234e+00 ; 4.303240e+00 ];

%-- Image #4:
omc_4 = [ 2.538858e+00 ; 1.626795e+00 ; 3.465501e-01 ];
Tc_4  = [ -7.250810e+01 ; -4.148347e+01 ; 4.537361e+02 ];
omc_error_4 = [ 5.005924e-03 ; 2.869775e-03 ; 8.774885e-03 ];
Tc_error_4  = [ 2.780452e+00 ; 1.650988e+00 ; 4.905246e+00 ];

%-- Image #5:
omc_5 = [ -2.192586e+00 ; -1.914227e+00 ; -4.548639e-01 ];
Tc_5  = [ -8.977356e+01 ; -1.657763e+00 ; 3.771250e+02 ];
omc_error_5 = [ 3.215495e-03 ; 3.899361e-03 ; 8.245403e-03 ];
Tc_error_5  = [ 2.280506e+00 ; 1.377918e+00 ; 3.830969e+00 ];

%-- Image #6:
omc_6 = [ -2.580177e+00 ; -1.642369e+00 ; -3.849601e-01 ];
Tc_6  = [ -1.023764e+02 ; -3.760369e+01 ; 3.910455e+02 ];
omc_error_6 = [ 4.166692e-03 ; 3.277172e-03 ; 8.846191e-03 ];
Tc_error_6  = [ 2.409421e+00 ; 1.438827e+00 ; 4.105985e+00 ];

%-- Image #7:
omc_7 = [ 2.120352e+00 ; 1.931299e+00 ; 6.077860e-01 ];
Tc_7  = [ -1.089032e+02 ; -3.386531e+01 ; 4.834495e+02 ];
omc_error_7 = [ 4.845497e-03 ; 3.467381e-03 ; 8.332896e-03 ];
Tc_error_7  = [ 2.989005e+00 ; 1.776597e+00 ; 5.311680e+00 ];

%-- Image #8:
omc_8 = [ 2.456802e+00 ; 1.597137e+00 ; 7.911228e-01 ];
Tc_8  = [ -7.358196e+01 ; -6.518084e+01 ; 4.828099e+02 ];
omc_error_8 = [ 5.459457e-03 ; 2.677423e-03 ; 8.180748e-03 ];
Tc_error_8  = [ 2.958955e+00 ; 1.771632e+00 ; 5.366790e+00 ];

%-- Image #9:
omc_9 = [ -2.276609e+00 ; -1.853860e+00 ; -8.041573e-01 ];
Tc_9  = [ -5.258923e+01 ; -2.672621e+01 ; 4.319830e+02 ];
omc_error_9 = [ 3.120399e-03 ; 4.188250e-03 ; 8.949843e-03 ];
Tc_error_9  = [ 2.612933e+00 ; 1.572892e+00 ; 4.602043e+00 ];

%-- Image #10:
omc_10 = [ 2.531395e+00 ; 1.455048e+00 ; 8.428684e-01 ];
Tc_10  = [ -8.349384e+01 ; -5.026391e+01 ; 4.389577e+02 ];
omc_error_10 = [ 5.450990e-03 ; 2.332813e-03 ; 7.937584e-03 ];
Tc_error_10  = [ 2.703319e+00 ; 1.615235e+00 ; 4.930620e+00 ];

%-- Image #11:
omc_11 = [ -2.329720e+00 ; -1.810784e+00 ; -9.933168e-01 ];
Tc_11  = [ -3.810508e+01 ; -2.779885e+01 ; 4.026217e+02 ];
omc_error_11 = [ 2.968221e-03 ; 4.297163e-03 ; 9.025834e-03 ];
Tc_error_11  = [ 2.429411e+00 ; 1.465397e+00 ; 4.449171e+00 ];

%-- Image #12:
omc_12 = [ 2.321905e+00 ; 1.916423e+00 ; 9.425637e-02 ];
Tc_12  = [ -4.558531e+01 ; -3.750076e+01 ; 4.060097e+02 ];
omc_error_12 = [ 4.560283e-03 ; 3.309557e-03 ; 8.405571e-03 ];
Tc_error_12  = [ 2.458138e+00 ; 1.469924e+00 ; 4.307951e+00 ];

%-- Image #13:
omc_13 = [ -2.281006e+00 ; -2.127005e+00 ; -2.185763e-01 ];
Tc_13  = [ -5.639624e+01 ; -8.652770e+00 ; 4.984681e+02 ];
omc_error_13 = [ 4.104734e-03 ; 4.937683e-03 ; 1.016376e-02 ];
Tc_error_13  = [ 3.022528e+00 ; 1.816380e+00 ; 5.195276e+00 ];

%-- Image #14:
omc_14 = [ -2.251347e+00 ; -2.120524e+00 ; -1.838636e-01 ];
Tc_14  = [ -6.423100e+01 ; -1.211082e+01 ; 3.740387e+02 ];
omc_error_14 = [ 3.244291e-03 ; 4.144605e-03 ; 8.648279e-03 ];
Tc_error_14  = [ 2.270322e+00 ; 1.365008e+00 ; 3.847340e+00 ];

%-- Image #15:
omc_15 = [ 2.241853e+00 ; 2.098754e+00 ; 2.359160e-01 ];
Tc_15  = [ -6.749319e+01 ; -4.784450e+00 ; 4.370428e+02 ];
omc_error_15 = [ 4.671547e-03 ; 3.264131e-03 ; 8.971182e-03 ];
Tc_error_15  = [ 2.661918e+00 ; 1.596339e+00 ; 4.633617e+00 ];

%-- Image #16:
omc_16 = [ 2.267200e+00 ; 2.081105e+00 ; 2.343519e-01 ];
Tc_16  = [ -7.551427e+01 ; -1.344243e+01 ; 4.255803e+02 ];
omc_error_16 = [ 4.590598e-03 ; 3.268480e-03 ; 8.912564e-03 ];
Tc_error_16  = [ 2.597674e+00 ; 1.556376e+00 ; 4.514472e+00 ];

%-- Image #17:
omc_17 = [ -2.312725e+00 ; -1.994101e+00 ; -4.581722e-01 ];
Tc_17  = [ -8.592003e+01 ; -4.311940e+01 ; 4.503171e+02 ];
omc_error_17 = [ 3.778598e-03 ; 4.090725e-03 ; 9.443890e-03 ];
Tc_error_17  = [ 2.747776e+00 ; 1.652326e+00 ; 4.707961e+00 ];

%-- Image #18:
omc_18 = [ -2.164792e+00 ; -2.200631e+00 ; -5.129665e-01 ];
Tc_18  = [ -3.937952e+01 ; -6.198089e+01 ; 4.517847e+02 ];
omc_error_18 = [ 3.219681e-03 ; 4.470363e-03 ; 9.300623e-03 ];
Tc_error_18  = [ 2.740082e+00 ; 1.648806e+00 ; 4.728718e+00 ];

%-- Image #19:
omc_19 = [ 1.771760e+00 ; 2.497254e+00 ; 2.146444e-01 ];
Tc_19  = [ -6.094939e+01 ; -7.070503e+01 ; 4.930572e+02 ];
omc_error_19 = [ 4.350494e-03 ; 5.458201e-03 ; 1.026073e-02 ];
Tc_error_19  = [ 3.004785e+00 ; 1.809737e+00 ; 5.243507e+00 ];

%-- Image #20:
omc_20 = [ 1.244803e+00 ; 2.606965e+00 ; 1.574287e-01 ];
Tc_20  = [ -5.622201e+01 ; -8.279886e+01 ; 4.700858e+02 ];
omc_error_20 = [ 3.064186e-03 ; 5.877272e-03 ; 8.302330e-03 ];
Tc_error_20  = [ 2.869922e+00 ; 1.722617e+00 ; 4.974308e+00 ];

%-- Image #21:
omc_21 = [ -1.826501e+00 ; -2.478151e+00 ; -5.747995e-01 ];
Tc_21  = [ -6.669936e+01 ; -1.122945e+02 ; 4.273557e+02 ];
omc_error_21 = [ 3.144371e-03 ; 4.649332e-03 ; 9.337558e-03 ];
Tc_error_21  = [ 2.616487e+00 ; 1.596588e+00 ; 4.542085e+00 ];

%-- Image #22:
omc_22 = [ 2.152880e+00 ; 2.166318e+00 ; 5.435737e-01 ];
Tc_22  = [ -8.427477e+01 ; -9.586640e+01 ; 4.136517e+02 ];
omc_error_22 = [ 4.392091e-03 ; 3.591682e-03 ; 8.884041e-03 ];
Tc_error_22  = [ 2.551353e+00 ; 1.532679e+00 ; 4.425220e+00 ];

%-- Image #23:
omc_23 = [ -6.414652e-02 ; 2.842165e+00 ; -1.768997e-02 ];
Tc_23  = [ 1.714933e+01 ; -1.473939e+02 ; 4.908670e+02 ];
omc_error_23 = [ 1.290627e-03 ; 6.505784e-03 ; 8.013439e-03 ];
Tc_error_23  = [ 2.978828e+00 ; 1.774593e+00 ; 5.166454e+00 ];

%-- Image #24:
omc_24 = [ 2.148727e+00 ; 2.107123e+00 ; 1.154707e-01 ];
Tc_24  = [ -1.030188e+02 ; -7.775366e+01 ; 4.125837e+02 ];
omc_error_24 = [ 4.167175e-03 ; 4.357573e-03 ; 8.577661e-03 ];
Tc_error_24  = [ 2.547281e+00 ; 1.518230e+00 ; 4.443571e+00 ];

%-- Image #25:
omc_25 = [ 2.167603e+00 ; 2.032518e+00 ; 9.885792e-02 ];
Tc_25  = [ -1.264646e+02 ; -8.472450e+01 ; 4.450029e+02 ];
omc_error_25 = [ 4.450922e-03 ; 4.889782e-03 ; 9.067458e-03 ];
Tc_error_25  = [ 2.758659e+00 ; 1.643437e+00 ; 4.791266e+00 ];

%-- Image #26:
omc_26 = [ 2.186388e+00 ; 1.943992e+00 ; 4.326139e-01 ];
Tc_26  = [ -9.655021e+01 ; -5.091643e+01 ; 4.569516e+02 ];
omc_error_26 = [ 4.577565e-03 ; 3.603074e-03 ; 8.553442e-03 ];
Tc_error_26  = [ 2.821426e+00 ; 1.676474e+00 ; 4.941116e+00 ];

%-- Image #27:
omc_27 = [ 2.186388e+00 ; 1.943992e+00 ; 4.326139e-01 ];
Tc_27  = [ -9.655021e+01 ; -5.091643e+01 ; 4.569516e+02 ];
omc_error_27 = [ 4.577565e-03 ; 3.603074e-03 ; 8.553442e-03 ];
Tc_error_27  = [ 2.821426e+00 ; 1.676474e+00 ; 4.941116e+00 ];

%-- Image #28:
omc_28 = [ 2.180173e+00 ; 2.034929e+00 ; 2.943696e-01 ];
Tc_28  = [ -1.107909e+02 ; -4.134827e+01 ; 4.597481e+02 ];
omc_error_28 = [ 4.658305e-03 ; 4.090705e-03 ; 9.525513e-03 ];
Tc_error_28  = [ 2.845622e+00 ; 1.694354e+00 ; 4.942441e+00 ];

%-- Image #29:
omc_29 = [ 2.186807e+00 ; 2.030948e+00 ; 2.686586e-01 ];
Tc_29  = [ -9.817650e+01 ; -4.727857e+01 ; 4.481255e+02 ];
omc_error_29 = [ 4.536870e-03 ; 3.956322e-03 ; 9.110629e-03 ];
Tc_error_29  = [ 2.765745e+00 ; 1.646266e+00 ; 4.809888e+00 ];

%-- Image #30:
omc_30 = [ 2.186388e+00 ; 1.943992e+00 ; 4.326139e-01 ];
Tc_30  = [ -9.655021e+01 ; -5.091643e+01 ; 4.569516e+02 ];
omc_error_30 = [ 4.577565e-03 ; 3.603074e-03 ; 8.553442e-03 ];
Tc_error_30  = [ 2.821426e+00 ; 1.676474e+00 ; 4.941116e+00 ];
