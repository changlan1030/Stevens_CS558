clear all;

% Problem 2: Pixel Classification
% load the image
image1=imread(['sky/sky_train.jpg']);          % original image
image2=imread(['sky/sky_train_mask.jpg']);     % mask
image1=double(image1);
image2=double(image2);

% separate sky from non-sky
sky=[];
non_sky=[];
idx1=1;     % sky index
idx2=1;     % non_sky index
for i=1:size(image1,1)
    for j=1:size(image1,2)
        % RGB=(255,255,255) color=white
        if image2(i,j,1)==255&&image2(i,j,2)==255&&image2(i,j,3)==255
            sky(idx1,:)=image1(i,j,:);
            idx1=idx1+1;
        else
            non_sky(idx2,:)=image1(i,j,:);
            idx2=idx2+1;
        end
    end
end

% get ten visual words for each class using k-means
k=10;
[~,sky_word]=kmeans(sky,k,'EmptyAction','singleton');
[~,non_sky_word]=kmeans(non_sky,k,'EmptyAction','singleton');
word=[ones(k,1) sky_word;zeros(k,1) non_sky_word];

% testing
for n=1:4
    % load the image
    test1=imread(['sky/sky_test' num2str(n) '.jpg']);
    s1=size(test1,1);
    s2=size(test1,2);
    s3=size(test1,3);
    
    % reshape the matrix
    test2=double(reshape(test1,s1*s2,s3,1));
    
    % find the closest word
    idx3=knnsearch(word(:,2:end),test2,'k',1,'Distance','euclidean');
    test3=word(idx3,1);
    
    % getting x and y
    [x,y]=ind2sub([s1 s2],1:s1*s2);
    
    for i=1:s1*s2
        % paint the pixel blue if it is sky
        if test3(i)==1
            test1(x(i),y(i),1)=0;
            test1(x(i),y(i),2)=0;
            test1(x(i),y(i),3)=255;
        end
    end
    
    % output
    figure,imshow(test1);
    imwrite(test1, ['output' num2str(n) '.jpg']);
end