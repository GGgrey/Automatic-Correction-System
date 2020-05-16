function qingxiejiao=qingxiejiao_get(I)
I1=rgb2gray(I);
I2=wiener2(I1,[5,5]);
I3=edge(I2,'canny');
%figure,imshow(I3);
theta=1:180;
[R,xp]=radon(I3,theta);
[r,c] = find(R>=max(max(R)));
J=c;
qingxiejiao=90-c;
end
    