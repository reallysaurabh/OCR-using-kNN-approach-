function [] = ML_mnist()
clc;
clear All;

% Change the filenames if you have saved the files under different names
% On some platforms, the files might be saved as 
% train-images.idx3-ubyte / train-labels.idx1-ubyte

images = loadMNISTImages('train-images.idx3-ubyte');
labels = loadMNISTLabels('train-labels.idx1-ubyte');

k=20; %k value (no. of neighbours to be considered)

test=loadMNISTImages('t10k-images.idx3-ubyte');
testLabels=loadMNISTLabels('t10k-labels.idx1-ubyte');
%or if you have too much fire in your ass 
%test=images(:,:); %if you want to use array

count=0;
for i=1:size(test,2)
    label = kNN (images, labels, test(:,i) , k);
    if (label==testLabels(i,1))
        display('yes');
        count=count+1
    else
        display('no');
    end
end

display('Accuracy is: ');
count/size(test,2)*100
display('%');

end

function [label] = kNN(images, labels, X, k)

m=size(images,2); %no. of images

%array to store RMS values
Decider=zeros(m,1);

for i=1:m
    Decider(i,1)=calc_diff(images(:,i), X);
end

label=0;

indices=return_n_min(Decider,k);

Labels=zeros(k,1);

%Labels array store the value in labels array to get info about the class of image. 
for i=1: size(indices,2)
    Labels(i)=labels(indices(i),1);
end

%the answer, the class to which that test image belong.
label=mode(Labels);


end

% function to return indices of neighbours with min. RMS diff to calculate
% class of test set
function [V] = return_n_min(Arr, n)
for z=1:n
    [M,I]=min(Arr);
    V(z)=I;
    Arr(I)=Inf;
end
end


%calculates RMS difference between two vectors and return an integer value
function [weight] = calc_diff(X1, X2)
n=size(X1,1);
weight=0;
for i=1:n
    weight = weight + sqrt( (X2(i,1)-X1(i,1))^2 ) ; 
end
end
