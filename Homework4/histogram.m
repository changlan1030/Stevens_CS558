function result=histogram(image,bin)
s=double(image(:));

for i=1:bin
    if i==1
        result(i)=size(find(s<256/bin*i),1);
    else
        result(i)=size(find(s<256/bin*i),1)-sum(result(1:i-1));
    end
end

end