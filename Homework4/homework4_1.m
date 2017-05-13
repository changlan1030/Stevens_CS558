clear all;

% Problem 1: Image Classification
% parameter
class={'coast','forest','insidecity'};
bin=8;

% initialize
train_histogram=zeros(12,bin*3);
test_histogram=zeros(12,bin*3);
train_label=zeros(12,1);
test_label=zeros(12,1);

idx1=1;
v=0;
for i=1:4
    for j=1:3
        % training histogram
        train=imread(['ImClass/' class{j} '_train' num2str(i) '.jpg']);
        h11=histogram(train(:,:,1),bin);
        h12=histogram(train(:,:,2),bin);
        h13=histogram(train(:,:,3),bin);
        train_histogram(idx1,:)=[h11 h12 h13];
        train_label(idx1)=j;
        
        % testing histogram
        test=imread(['ImClass/' class{j} '_test' num2str(i) '.jpg']);
        h21=histogram(test(:,:,1),bin);
        h22=histogram(test(:,:,2),bin);
        h23=histogram(test(:,:,3),bin);
        test_histogram(idx1,:)=[h21 h22 h23];
        test_label(idx1)=j;
        
        % verification
        v1=sum(h11)+sum(h12)+sum(h13)-size(train,1)*size(train,2)*3;
        v2=sum(h21)+sum(h22)+sum(h23)-size(test,1)*size(test,2)*3;
        if v1~=0||v2~=0
            v=1;
        end
        
        idx1=idx1+1;
    end
end

idx2=knnsearch(train_histogram,test_histogram,'k',1,'Distance','euclidean');

count=0;
test_num=size(test_histogram,1);
for i=1:test_num
    % display the result
    idx3=num2str(i);
    class_name1=num2str(test_label(i));
    class_name2=num2str(test_label(idx2(i)));
    disp(['Test image ' idx3 ' of class ' class_name1 ' has been assigned to class ' class_name2 '.']);
    
    % count the correct
    if test_label(i)==train_label(idx2(i))
        count=count+1;
    end
end

% display the accuracy
disp(['The accuracy of the classifier is ' num2str(count/test_num) '.']);

% display the verification
if v==0
    disp('All pixels are counted exactly 3 times.');
else
    disp('All pixels are not counted exactly 3 times.');
end