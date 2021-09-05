function T = MatrixValue(I)

figure
imshow(I)
I = rgb2gray(I);

G = imgaussfilt(I,1.5);

[m,n] = size(G);

T = zeros(m,n,2,2);
J = zeros(m,n);

for x = 1:m
    for y = 1:n
        N = zeros(5,5);
        for k = 1:5
            for l = 1:5
                i = x-3+k;
                j = y-3+l;
                if i < 1
                    i = x;
                elseif i > m
                    i = x;
                end
                
                if j < 1
                    j = y;
                elseif j > n
                    j = y;
                end
                N(k,l) = G(i,j);
            end
        end   
        Isum = zeros(2,2);
        for k = 1:5
            for l = 1:5
                k1 = k-1;
                k2 = k+1;
                l1 = l-1;
                l2 = l+1;
                
                 if k1 < 1
                    k1 = k;
                elseif k2 > 5
                    k2 = k;
                end
                
                if l1 < 1
                    l1 = l;
                elseif l2 > 5
                    l2 = l;
                end
                
                Ik = abs((N(k,l)-N(k1,l) - N(k,l)+N(k2,l))./2);
                Il = abs((N(k,l)-N(k,l1) - N(k,l)+N(k,l2))./2);
                
                J(x,y) = J(x,y) + Ik + Il;
                I = [Ik;Il];
                Isum = Isum + I*transpose(I);
            end
        end
        T(x,y,:,:) = Isum(:,:);
    end
end
figure
imagesc(J)

end

