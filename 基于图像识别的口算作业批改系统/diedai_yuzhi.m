%%%%%最佳阈值法%%%%%
function y=diedai_yuzhi(I)
I1=rgb2gray(I);
I_min=min(I1(:));
I_max=max(I1(:));
th=(I_min+I_max)/2;
ok=true;
while ok
    g1=I1>=th;
    g2=I1<=th;
    u1=mean(I(g1));
    u2=mean(I(g2));
    thnew=(u1+u2)/2;
    ok=abs(th-thnew)>=1;
    th=thnew;
end
th=abs(floor(th));
J=im2bw(I1,th/255);
% figure(1);
% imshow(I);title('原始图像');
% figure(2);
% imshow(J);
y=J;
end

   