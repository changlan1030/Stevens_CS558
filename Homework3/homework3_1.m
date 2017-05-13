clear all;

% Problem 1: k-means Segmentation
% input the image
image1=imread('white-tower.png');
h1=size(image1,1);
w1=size(image1,2);
image1=double(image1);

% parameter
k=10;

% randomly initialize the cluster centers
center=rand(k,2);
center(:,1)=round(center(:,1).*h1)+1;
center(:,2)=round(center(:,2).*w1)+1;

% k-means segmentation
image2=kmeans(image1,center,k);

% show the result
image2=uint8(image2);
figure,imshow(image2);
imwrite(image2,'kmeans.bmp','bmp');