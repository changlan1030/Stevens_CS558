clear all;

% Problem 2: SLIC
% input the image
image3=imread('wt_slic.png');
h2=size(image3,1);
w2=size(image3,2);
image3=double(image3);

% parameter
s=50;

% slic
image4=slic(image3,s);

% show the result
image4=uint8(image4(:,:,1:3));
figure,imshow(image4);
imwrite(image4,'slic1.bmp','bmp');

% color the pixel that touch two different clusters black
image5=image4;
for i=2:h2-1
    for j=2:w2-1
        flag=0;
        for t=1:3
            if image4(i,j,t)~=image4(i-1,j-1,t)
                flag=1;
            end
            if image4(i,j,t)~=image4(i-1,j,t)
            	flag=1;
            end
            if image4(i,j,t)~=image4(i-1,j+1,t)
                flag=1;
            end
            if image4(i,j,t)~=image4(i,j-1,t)
                flag=1;
            end
            if image4(i,j,t)~=image4(i,j+1,t)
                flag=1;
            end
            if image4(i,j,t)~=image4(i+1,j-1,t)
                flag=1;
            end
            if image4(i,j,t)~=image4(i+1,j,t)
                flag=1;
            end
            if image4(i,j,t)~=image4(i+1,j+1,t)
                flag=1;
            end
        end
        if flag==1
            image5(i,j,:)=[0 0 0];
        end
    end
end

% show the result
figure,imshow(image5);
imwrite(image5,'slic2.bmp','bmp');