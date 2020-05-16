
clear all
close all
train_x_file=char('train-images.idx3-ubyte');%得到vector形式
test_x_file=char('t10k-images.idx3-ubyte');%得到vector形式
train_y_file=char('train-labels.idx1-ubyte');%得到vector形式
test_y_file=char('t10k-labels.idx1-ubyte');%得到vector形式 
train_x=decodefile(train_x_file,'image');
test_x=decodefile(test_x_file,'image'); 
train_y=decodefile(train_y_file,'label');
test_y=decodefile(test_y_file,'label');
save('mnist_uint8.mat','train_x','train_y','test_x','test_y');
train_x_matrix=reshape(train_x,28,28,60000);%reshape后的图像是放倒的
train_x_matrix=permute(train_x_matrix,[2 1 3]);%对每张图像进行行列的转置处理
 
test_x_matrix=reshape(test_x,28,28,10000);%reshape后的图像是放倒的
test_x_matrix=permute(test_x_matrix,[2 1 3]);%对每张图像进行行列的转置处理
 
figure;
for m=1:5
        subplot(2,5,m),imshow(train_x_matrix(:,:,m));
        title(num2str(train_y(m)));
end
for m=1:5
        subplot(2,5,m+5),imshow(test_x_matrix(:,:,m));
        title(num2str(test_y(m)));
end



