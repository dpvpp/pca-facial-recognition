function [K,T] = GetSamples()
S = randperm(40,20);
path = '/Faces/s40/10.pgm';
I = imread(path);
[m,n] = size(I);
K = zeros(100,m,n);
T = zeros(100,m,n);
kcount = 1;
tcount = 1;
for i = 1:20
    images = randperm(10);
    for j = 1:5
        path = strcat('Faces/s',int2str(S(i)),'/',int2str(images(j)),'.pgm');
        I = imread(path);
        K(kcount,:,:) = I(:,:);
        kcount = kcount + 1;
    end
    for j = 6:10
        path = strcat('Faces/s',int2str(S(i)),'/',int2str(images(j)),'.pgm');
        I = imread(path);
        T(tcount,:,:) = I(:,:);
        tcount = tcount + 1;
    end
end
end