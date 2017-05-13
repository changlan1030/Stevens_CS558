clear all;

% input the image
%image=imread('kangaroo.pgm');
image=imread('plane.pgm');
%image=imread('red.pgm');

% output the original image
% imwrite(image,'kangaroo.bmp','bmp');
imshow(image);

% parameter
sigma=2;
threshold=50;

% width and height of image
i_height=size(image,1);
i_width=size(image,2);

% Problem 1.1: Gaussian filtering
% Gaussian filter matrix
size=sigma*6+1;
half=(size-1)/2;
[x,y]=meshgrid(-half:half,-half:half);
g_filter=exp(-(x.^2+y.^2)/(2*sigma^2))/(2*pi*sigma^2);
g_filter=g_filter./sum(g_filter(:));

% Gaussian filtering
image1=im2double(image);
image2=filtering(image1,g_filter);

% output the image after Gaussian filtering
% imwrite(image2,'kangaroo_sigma1.bmp','bmp');
figure,imshow(image2);

% Problem 1.2 Gradient computation
% Sobel filter matrix
s_filter_x=[-1,0,1;-2,0,2;-1,0,1];
s_filter_y=[1,2,1;0,0,0;-1,-2,-1];

% Sobel filtering
i_x=filtering(image2,s_filter_x);
i_y=filtering(image2,s_filter_y);

% image gradient
strength=sqrt(i_x.^2 + i_y.^2);
direction=atand(i_y./i_x);
image3=im2uint8(strength);
for i=1:i_height
    for j=1:i_width
        if image3(i,j)<threshold
            image3(i,j)=0;
        end
    end
end

% output the image after gradient computation
% imwrite(image3,'kangaroo_sigma1_threshold95.bmp','bmp');
figure,imshow(image3);

% Problem 1.3 non-maximum suppression
% non-maximum suppression
image4=nms(image3,direction);
for i=1:i_height
    for j=1:i_width
        if image4(i,j)~=0
            image4(i,j)=255;
        end
    end
end

% output the image after non-maximum suppression
% imwrite(image4,'kangaroo.bmp','bmp');
figure,imshow(image4);