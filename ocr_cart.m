function [] = ocr_cart()
clc;
clear All;


images = loadMNISTImages('train-images.idx3-ubyte');
labels = loadMNISTLabels('train-labels.idx1-ubyte');

%command to display what the image actually looks like
%img = recreate_image(images(:,1));

z=20; % no. of training images

%to take a random sample of z images to train the CART
image_trainset=zeros(size(images,1),z);
label_trainset=zeros(z,1);

j=1;
for i=1:size(images,2)
    if mod(i,size(images,2)/z)==0
        image_trainset(:,j)=images(:,j);
        label_trainset(j,1)=labels(j,1);
        j=j+1;
    end
end


size(image_trainset)
size(label_trainset)

W=calc_weight_matrix(image_trainset);


for i=1:size(W,2)
    scatter3(1, i, W(1,i));
    scatter3(2, i, W(2,i));
    hold on
end

create_plot(W)


end

function [W] = calc_weight_matrix(images)

n=size(images,2); %no. of images

W=zeros(n-1,n-1);

m=size(images,1); %size of each image

for i=1:n-1
    for j=1:n-1
        
        if i~=j
            weight=0;
            for k=1:m
                weight = weight + sqrt( (images(k,i)-images(k,j))^2 ) ; 
            end

            W(i,j)=weight;
        end

    end
end


end

function [] = create_plot(W)

n=size(W,1);

for i=1:n
    for j=1:n
        if i~=j
            scatter3(i, j, W(i,j));
            hold on
        end

    end
end


end

function [img] = recreate_image(X)

n=sqrt(size(X,1));

img=zeros(n,n);
k=0;
for i=1:n
    l=1;
    for j=(k+1):n*i
        
        img(i,l)=X(j,1);
        k=k+1;
        l=l+1;
    
    end
    
end

imshow(img)
end




