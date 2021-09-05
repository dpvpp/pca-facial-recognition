function I = EigenNeighbor(K,T)
[k,m,n] = size(K);
s = m*n;
A = zeros(s,k);
%Computes Matrix A
for i = 1:k
    A(:,i) = K(i,:);
end

%Computes mean
u = zeros(s,1);
for i = 1:s
    sum = 0;
    for j = 1:k
        sum = sum + A(i,j); 
    end
    u(i) = uint8(sum/k);
end

%Centralizes training set
for i = 1:k
    A(:,i) = abs(A(:,i)-u);
end

%Coveriance matrix and eigenvectors
C = A*transpose(A);
[E,D] = eigs(C,k);

%Computes the cumulative sum of eigenvalues
sum = zeros(k,1);
sum(1) = D(1,1);
for i = 2:k
    sum(i) = sum(i-1) + D(i,i);
end
%How many Eigenvectors to use
%Changing mm uses either more or less eigenvectors
mm = 40;
E = E(:,1:mm);

%Projects the training set to the eigenvectors
R = zeros(k,mm);
for i = 1:k
   for j = 1:mm
       R(i,j) = transpose(A(:,i))*E(:,j); 
   end
end

%Computes the data matrix for the testing set
B = zeros(s,k);
for i = 1:k
    B(:,i) = T(i,:);
end
%Centralizes training set
for i = 1:k
    B(:,i) = abs(B(:,i)-u);
end

%Projects training sets to the eigenvectors
V = zeros(k,mm);
for i = 1:k
   for j = 1:mm
       V(i,j) = transpose(B(:,i))*E(:,j); 
   end
end

%chooses a random image from the testing set to test
t = randi(100);
%Finds the location of the image in the training set with the smallest 
%Euclidean distance between R and V
mindist = realmax;
kk = 1;
for i = 1:k
   esum = 0;
   for j = 1:mm
       esum = esum + (R(i,j) - V(t,j))^2; 
   end
   edist = sqrt(esum);
   if mindist > edist
       mindist = edist;
       kk = i;
   end
end

%Shows results
I(:,:) = T(t,:,:);
figure
imshow(uint8(I))
title('Input image')
I(:,:) = K(kk,:,:);
figure
imshow(uint8(I))
title('Closest match')
end