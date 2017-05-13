function image_fil=filtering(image_ori,filter)
% width and height of original image
width_i=size(image_ori,2);
height_i=size(image_ori,1);

% width and height of filter
width_f=size(filter,2);
height_f=size(filter,1);
half_wf=(width_f-1)/2;
half_hf=(height_f-1)/2;

% extend
image_temp1=zeros(height_i+half_hf*2,width_i+half_wf*2);
for i=1:height_i
    for j=1:width_i
        image_temp1(i+half_hf,j+half_wf)=image_ori(i,j);
    end
end

% replicate boundary
for i=1:height_i+half_hf*2
    for j=1:width_i+half_wf*2
        if j<=half_wf&&i>=half_hf+1&&i<=height_i+half_hf
            image_temp1(i,j)=image_temp1(i,half_wf+1);
        elseif j>=width_i+half_wf+1&&i>=half_hf+1&&i<=height_i+half_hf
            image_temp1(i,j)=image_temp1(i,width_i+half_wf);
        elseif i<=half_hf&&j>=half_wf+1&&j<=width_i+half_wf
            image_temp1(i,j)=image_temp1(half_hf+1,j);
        elseif i>=height_i+half_hf+1&&j>=half_wf+1&&j<=width_i+half_wf
            image_temp1(i,j)=image_temp1(height_i+half_hf,j);
        elseif j<=half_wf&&i<=half_hf
            image_temp1(i,j)=image_temp1(half_hf+1,half_wf+1);
        elseif j<=half_wf&&i>=height_i+half_hf+1
            image_temp1(i,j)=image_temp1(height_i+half_hf,half_wf+1);
        elseif i<=half_hf&&j>=width_i+half_wf+1
            image_temp1(i,j)=image_temp1(half_hf+1,width_i+half_wf);
        elseif j>=width_i+half_wf+1&&i>=height_i+half_hf+1
            image_temp1(i,j)=image_temp1(height_i+half_hf,width_i+half_wf);
        end
    end
end

% filtering
image_temp2=image_temp1;
for i=1+half_hf:height_i+half_hf
    for j=1+half_wf:width_i+half_wf
        image_temp2(i,j)=sum(sum(filter.*image_temp1(i-half_hf:i+half_hf,j-half_wf:j+half_wf)));
    end
end

% cut
image_fil=zeros(height_i,width_i);
for i=1:height_i
    for j=1:width_i
        image_fil(i,j)=image_temp2(i+half_hf,j+half_wf);
    end
end

end