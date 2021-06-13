close all, clear all, clc

%Part2
%Part2-1
img0 = imread('cat.png');
img1 = imread('monarch.png');
img2 = imread('tulips.png');
img3 = imread('watch.png');
img4 = imread('cat.png');

figure(1);
subplot(2,2,1);
imshow(img0);
title('Original Image');

imgR = img0(:,:,1);
imgG = img0(:,:,2);
imgB = img0(:,:,3);
subplot(2,2,2);
imshow(imgR);
title('Red');
subplot(2,2,3);
imshow(imgG);
title('Green');
subplot(2,2,4);
imshow(imgB);
title('Blue');

figure(2);
subplot(1,3,1);
hist1 = histogram( imgR , 'normalization' , 'pdf');
title('Red');
subplot(1,3,2);
hist2 = histogram( imgG , 'normalization' , 'pdf');
title('Green');
subplot(1,3,3);
hist3 = histogram( imgB , 'normalization' , 'pdf');
title('Blue');

XR = hist1.BinEdges;
XR = (1:length(XR)-1);
XG = hist2.BinEdges; 
XG = (1:length(XG)-1);
XB = hist3.BinEdges; 
XB = (1:length(XB)-1);

YR = hist1.Values;
YG = hist2.Values;
YB = hist3.Values;

figure(3);
subplot(1,3,1)
pR = polyfit(XR,YR,4);
plot(polyval(pR,XR));
title('Red');
subplot(1,3,2)
pG = polyfit(XG,YG,4);
plot(polyval(pG,XG));
title('Green');
subplot(1,3,3)
pB = polyfit(XB,YB,4);
plot(polyval(pB,XB));
title('Blue');


%Part2-3-Quantization

Quan_R_8 = Quan_2(imgR,8);
Quan_G_8 = Quan_2(imgG,8);
Quan_B_8 = Quan_2(imgB,8);
QuanImg8 = uint8(cat(3, Quan_R_8, Quan_G_8, Quan_B_8));
figure(4);
subplot(2,3,3);
imshow(QuanImg8);
title('Quantization Level : 8');

Quan_R_4 = Quan_2(imgR,4);
Quan_G_4 = Quan_2(imgG,4);
Quan_B_4 = Quan_2(imgB,4);
QuanImg4 = cat(3, Quan_R_4, Quan_G_4, Quan_B_4);
%figure(5);
subplot(2,3,2);
imshow(QuanImg4);
title('Quantization Level : 4');

Quan_R_32 = Quan_2(imgR,32);
Quan_G_32 = Quan_2(imgG,32);
Quan_B_32 = Quan_2(imgB,32);
QuanImg32 = cat(3, Quan_R_32, Quan_G_32, Quan_B_32);
%figure(6);
subplot(2,3,5);
imshow(QuanImg32);
title('Quantization Level : 32');

Quan_R_16 = Quan_2(imgR,16);
Quan_G_16 = Quan_2(imgG,16);
Quan_B_16 = Quan_2(imgB,16);
QuanImg16 = cat(3, Quan_R_16, Quan_G_16, Quan_B_16);
%figure(7);
subplot(2,3,4);
imshow(QuanImg16);
title('Quantization Level : 16');

Quan_R_64 = Quan_2(imgR,64);
Quan_G_64 = Quan_2(imgG,64);
Quan_B_64 = Quan_2(imgB,64);
QuanImg64 = cat(3, Quan_R_64, Quan_G_64, Quan_B_64);
%figure(8);
subplot(2,3,6);
imshow(QuanImg64);
title('Quantization Level : 64');

Quan_R_2 = Quan_2(imgR,2);
Quan_G_2 = Quan_2(imgG,2);
Quan_B_2 = Quan_2(imgB,2);
QuanImg2 = uint8(cat(3, Quan_R_2, Quan_G_4, Quan_B_8));
figure(9);
imshow(QuanImg2);
title('Quantization Level : 2 Red, 4 Green, 8 Blue');

figure(4);
subplot(2,3,1);
imshow(img0);
title('Original Image')



MSE = [];
MSE_r = [];
MSE_G = [];
MSE_b = [];
MSE = [MSE; mean( (double(img0)-double(QuanImg4)).^2,'All') ];
MSE = [MSE; mean( (double(img0)-double(QuanImg8)).^2,'All') ];
MSE = [MSE; mean( (double(img0)-double(QuanImg16)).^2,'All') ];
MSE = [MSE; mean( (double(img0)-double(QuanImg32)).^2,'All') ];
MSE = [MSE; mean( (double(img0)-double(QuanImg64)).^2,'All') ];

MSE_r = [MSE_r; mean( (double(imgR)-double(Quan_R_4)).^2,'All') ];
MSE_r = [MSE_r; mean( (double(imgR)-double(Quan_R_8)).^2,'All') ];
MSE_r = [MSE_r; mean( (double(imgR)-double(Quan_R_16)).^2,'All') ];
MSE_r = [MSE_r; mean( (double(imgR)-double(Quan_R_32)).^2,'All') ];
MSE_r = [MSE_r; mean( (double(imgR)-double(Quan_R_64)).^2,'All') ];

MSE_b = [MSE_b; mean( (double(imgB)-double(Quan_B_4)).^2,'All') ];
MSE_b = [MSE_b; mean( (double(imgB)-double(Quan_B_8)).^2,'All') ];
MSE_b = [MSE_b; mean( (double(imgB)-double(Quan_B_16)).^2,'All') ];
MSE_b = [MSE_b; mean( (double(imgB)-double(Quan_B_32)).^2,'All') ];
MSE_b = [MSE_b; mean( (double(imgB)-double(Quan_B_64)).^2,'All') ];

MSE_G = [MSE_G; mean( (double(imgG)-double(Quan_G_4)).^2,'All') ];
MSE_G = [MSE_G; mean( (double(imgG)-double(Quan_G_8)).^2,'All') ];
MSE_G = [MSE_G; mean( (double(imgG)-double(Quan_G_16)).^2,'All') ];
MSE_G = [MSE_G; mean( (double(imgG)-double(Quan_G_32)).^2,'All') ];
MSE_G = [MSE_G; mean( (double(imgG)-double(Quan_G_64)).^2,'All') ];

MSE = [MSE MSE_r MSE_G MSE_b];

EX2 = [ mean( (double(img0)).^2, 'All' ) mean( (double(imgR)).^2, 'All' ) mean( (double(imgG)).^2, 'All' )  mean( (double(imgB)).^2, 'All' )] ;
SQNR = [EX2(1)/MSE(1) ; EX2(1)/MSE(2) ; EX2(1)/MSE(3) ; EX2(1)/MSE(4) ; EX2(1)/MSE(5)];
SQNRR = [EX2(2)/MSE_r(1) ; EX2(2)/MSE_r(2) ; EX2(2)/MSE_r(3) ; EX2(2)/MSE_r(4) ; EX2(2)/MSE_r(5)];
SQNRG = [EX2(3)/MSE_G(1) ; EX2(3)/MSE_G(2) ; EX2(3)/MSE_G(3) ; EX2(3)/MSE_G(4) ; EX2(3)/MSE_G(5)];
SQNRB = [EX2(4)/MSE_b(1) ; EX2(4)/MSE_b(2) ; EX2(4)/MSE_b(3) ; EX2(4)/MSE_b(4) ; EX2(4)/MSE_b(5)];
SQNR = [SQNR  SQNRR SQNRG SQNRB];

