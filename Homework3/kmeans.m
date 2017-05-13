function image2=kmeans(image1,center,k)
% get the height and width of the image
h=size(image1,1);
w=size(image1,2);
m=size(image1,3);

% get the center's RGB
c1=zeros(k,m);
c2=zeros(k,m);
for i=1:k
    c1(i,1:m)=image1(center(i,1),center(i,2),:);
end

% initialize the distance
dis=inf(h,w,k);

flag=0;
while ~flag
    % calculate the distance between each point and each cluster's center
    for i=1:k
        for d=1:m
            temp(:,:,d)=repmat(c1(i,d),h,w);
        end
        
        dis(:,:,i)=sqrt(sum(power(image1-temp,2),3));
    end
    
    % find out which cluster's center these points are closest to
    [~,d] = min(dis,[],3);
    
    % find the centroid of these points in each cluster
    for i=1:k
        idx=d==i;
        rgb=reshape(image1(repmat(idx,1,1,m)),sum(idx(:)),m);
        c2(i,:)=round(mean(rgb));
    end
    
    % if no change, stop
    if abs(norm(c1-c2))<0.1
        flag=1;
    end
    
    c1=c2;
end  

% draw a new image
image2=zeros(h,w,m);
for i=1:h
    for j=1:w
        image2(i,j,:)=c1(d(i,j),:);
    end
end

end