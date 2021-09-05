function X = EigenRecon(K)
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
%gets the variances and plots them
tsum = sum(k);
sum = sum./tsum;
figure
plot((1:k)',sum);
%How many Eigenvectors to use
%Changing mm uses either more or less eigenvectors
mm = 20;
E = E(:,1:mm);

%Projects the training set to the eigenvectors
R = zeros(k,mm);
for i = 1:k
   for j = 1:mm
       R(i,j) = transpose(A(:,i))*E(:,j); 
   end
end

kk = 50;
%Reconstructs the random training image
X = u;
for j = 1:mm
    X = X + R(kk,j)*E(:,j);
end

%Displays original image
I1(:,:) = K(kk,:,:);
figure
imshow(uint8(I1))
title('Original Image')
%Creates an image matrix from vector
I2 = zeros(m,n);
count = 1;
for x = 1:n
    for y = 1:m
        I2(y,x) = X(count);
        count = count + 1;
    end
end
%Displays image
figure
imshow(uint8(I2))
title('Reconstructed Image')
%Displays difference between reconstruction and original image
I = I2-I1;
figure
imshow(int8(I))
title('Difference Image')

end