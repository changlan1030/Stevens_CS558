function image=nms(image_ori,direction)
% width and height of original image
width_i=size(image_ori,2);
height_i=size(image_ori,1);

image=zeros(height_i,width_i);
for i=2:height_i-1
    for j=2:width_i-1
        if image_ori(i,j)~=0
            % horizontal, vertical and the two diagonals?
            % 90 degree
            if direction(i,j)<=-67.5||direction(i,j)>=67.5
                temp1=image_ori(i-1,j);
                temp2=image_ori(i+1,j);
            % -45 degree
        	elseif direction(i,j)>-67.5&&direction(i,j)<-22.5
                temp1=image_ori(i-1,j-1);
                temp2=image_ori(i+1,j+1);
            % 0 degree
            elseif direction(i,j)>=-22.5&&direction(i,j)<=22.5
                temp1=image_ori(i,j-1);
                temp2=image_ori(i,j+1);
            % 45 degree
            elseif direction(i,j)>22.5&&direction(i,j)<67.5
                temp1=image_ori(i-1,j+1);
                temp2=image_ori(i+1,j-1);
            end
            
            if image_ori(i,j)>=temp1&&image_ori(i,j)>=temp2
                image(i,j)=image_ori(i,j);
            end
        end
    end
end

end