
clear all
close all
train_x_file=char('train-images.idx3-ubyte');%�õ�vector��ʽ
test_x_file=char('t10k-images.idx3-ubyte');%�õ�vector��ʽ
train_y_file=char('train-labels.idx1-ubyte');%�õ�vector��ʽ
test_y_file=char('t10k-labels.idx1-ubyte');%�õ�vector��ʽ 
train_x=decodefile(train_x_file,'image');
test_x=decodefile(test_x_file,'image'); 
train_y=decodefile(train_y_file,'label');
test_y=decodefile(test_y_file,'label');
save('mnist_uint8.mat','train_x','train_y','test_x','test_y');
train_x_matrix=reshape(train_x,28,28,60000);%reshape���ͼ���Ƿŵ���
train_x_matrix=permute(train_x_matrix,[2 1 3]);%��ÿ��ͼ��������е�ת�ô���
 
test_x_matrix=reshape(test_x,28,28,10000);%reshape���ͼ���Ƿŵ���
test_x_matrix=permute(test_x_matrix,[2 1 3]);%��ÿ��ͼ��������е�ת�ô���
 
figure;
for m=1:5
        subplot(2,5,m),imshow(train_x_matrix(:,:,m));
        title(num2str(train_y(m)));
end
for m=1:5
        subplot(2,5,m+5),imshow(test_x_matrix(:,:,m));
        title(num2str(test_y(m)));
end



