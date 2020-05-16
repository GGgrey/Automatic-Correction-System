train_x_file=char('train-images.idx3-ubyte');
test_x_file=char('t10k-images.idx3-ubyte');
train_y_file=char('train-labels.idx1-ubyte');
test_y_file=char('t10k-labels.idx1-ubyte');
train_x=decodefile(train_x_file,'image');
test_x=decodefile(test_x_file,'image');
train_y=decodefile(train_y_file,'label');
test_y=decodefile(test_y_file,'label');
save('mnist_uint8.mat','train_x','train_y','test_x','test_y');
for train_num=1:47040000
    if(train_x(train_num,1)>128);
        train_x(train_num,1)=255;
    else
        train_x(train_num,1)=0;
    end
end
for test_num=1:7840000
    if(test_x(test_num,1)>128)
        test_x(test_num,1)=255;
    else
        test_x(test_num,1)=0;
    end
end
train_x_matrix=reshape(train_x,1,784,60000);   
train_x_matrix=permute(train_x_matrix,[2 1 3]);
test_x_matrix=reshape(test_x,1,784,10000);
test_x_matrix=permute(test_x_matrix,[2 1 3]);
load mnist_uint8.mat
train_x_matrix=double(train_x_matrix)/255;
test_x_matrix=double(test_x_matrix)/255;
train_x_matrix=reshape(train_x_matrix,28,28,60000);
train_x_matrix=permute(train_x_matrix,[2,1,3]);
for i=1:60000
    train_x_1=restrict(train_x_matrix(:,:,i));
    [train_x_m,train_x_n]=size(train_x_1);
    if(train_x_m/train_x_n>2&&train_x_m/train_x_n<=3)
        train_x_2=imresize(train_x_1,[20,14]);
        train_x_3=zeros(20,3);
        train_x_4=zeros(20,3);
        train_x_5=[train_x_3,train_x_2,train_x_4];
        train_x_6=zeros(4,4);
        train_x_7=zeros(20,4);
        train_x_8=zeros(4,20);
        train_x_9=[train_x_6 train_x_8 train_x_6;train_x_7 train_x_5 train_x_7;train_x_6 train_x_8 train_x_6];
    elseif(train_x_m/train_x_n>3)
        train_x_2=imresize(train_x_1,[20,8]);
        train_x_3=zeros(20,6);
        train_x_4=zeros(20,6);
        train_x_5=[train_x_3,train_x_2,train_x_4];
        train_x_6=zeros(4,4);
        train_x_7=zeros(20,4);
        train_x_8=zeros(4,20);
        train_x_9=[train_x_6 train_x_8 train_x_6;train_x_7 train_x_5 train_x_7;train_x_6 train_x_8 train_x_6];
    elseif(train_x_n/train_x_m>2&&train_x_n/train_x_m<=3)
        train_x_2=imresize(train_x_1,[14,20]);
        train_x_3=zeros(3,20);
        train_x_4=zeros(3,20);
        train_x_5=[train_x_3;train_x_2;train_x_4];
        train_x_6=zeros(4,4);
        train_x_7=zeros(20,4);
        train_x_8=zeros(4,20);
        train_x_9=[train_x_6 train_x_8 train_x_6;train_x_7 train_x_5 train_x_7;train_x_6 train_x_8 train_x_6];
    elseif(train_x_n/train_x_m>3)
        train_x_2=imresize(train_x_1,[8,20]);
        train_x_3=zeros(6,20);
        train_x_4=zeros(6,20);
        train_x_5=[train_x_3;train_x_2;train_x_4];
        train_x_6=zeros(4,4);
        train_x_7=zeros(20,4);
        train_x_8=zeros(4,20);
        train_x_9=[train_x_6 train_x_8 train_x_6;train_x_7 train_x_5 train_x_7;train_x_6 train_x_8 train_x_6];
    else
        train_x_5=imresize(train_x_1,[20,20]);
        train_x_6=zeros(4,4);
        train_x_7=zeros(20,4);
        train_x_8=zeros(4,20);
        train_x_9=[train_x_6 train_x_8 train_x_6;train_x_7 train_x_5 train_x_7;train_x_6 train_x_8 train_x_6];
    end
    train_x_matrix(:,:,i)=train_x_9;
end
test_x_matrix=reshape(test_x_matrix,28,28,10000);
test_x_matrix=permute(test_x_matrix,[2,1,3]);
for i=1:10000
    test_x_1=restrict(test_x_matrix(:,:,i));
    [test_x_m,test_x_n]=size(test_x_1);
    if(test_x_m/test_x_n>2&&test_x_m/test_x_n<=3)
        test_x_2=imresize(test_x_1,[20,14]);
        test_x_3=zeros(20,3);
        test_x_4=zeros(20,3);
        test_x_5=[test_x_3,test_x_2,test_x_4];
        test_x_6=zeros(4,4);
        test_x_7=zeros(20,4);
        test_x_8=zeros(4,20);
        test_x_9=[test_x_6 test_x_8 test_x_6;test_x_7 test_x_5 test_x_7;test_x_6 test_x_8 test_x_6];
    elseif(test_x_m/test_x_n>3)
        test_x_2=imresize(test_x_1,[20,8]);
        test_x_3=zeros(20,6);
        test_x_4=zeros(20,6);
        test_x_5=[test_x_3,test_x_2,test_x_4];
        test_x_6=zeros(4,4);
        test_x_7=zeros(20,4);
        test_x_8=zeros(4,20);
        test_x_9=[test_x_6 test_x_8 test_x_6;test_x_7 test_x_5 test_x_7;test_x_6 test_x_8 test_x_6];
    elseif(test_x_n/test_x_m>2&&test_x_n/test_x_m<=3)
        test_x_2=imresize(test_x_1,[14,20]);
        test_x_3=zeros(3,20);
        test_x_4=zeros(3,20);
        test_x_5=[test_x_3;test_x_2;test_x_4];
        test_x_6=zeros(4,4);
        test_x_7=zeros(20,4);
        test_x_8=zeros(4,20);
        test_x_9=[test_x_6 test_x_8 test_x_6;test_x_7 test_x_5 test_x_7;test_x_6 test_x_8 test_x_6];
    elseif(test_x_n/test_x_m>3)
        test_x_2=imresize(test_x_1,[8,20]);
        test_x_3=zeros(6,20);
        test_x_4=zeros(6,20);
        test_x_5=[test_x_3;test_x_2;test_x_4];
        test_x_6=zeros(4,4);
        test_x_7=zeros(20,4);
        test_x_8=zeros(4,20);
        test_x_9=[test_x_6 test_x_8 test_x_6;test_x_7 test_x_5 test_x_7;test_x_6 test_x_8 test_x_6];
    else
        test_x_5=imresize(test_x_1,[20,20]);
        test_x_6=zeros(4,4);
        test_x_7=zeros(20,4);
        test_x_8=zeros(4,20);
        test_x_9=[test_x_6 test_x_8 test_x_6;test_x_7 test_x_5 test_x_7;test_x_6 test_x_8 test_x_6];
    end
    test_x_matrix(:,:,i)=test_x_9;
end
train_x_matrix=permute(train_x_matrix,[2,1,3]);
train_x_matrix=reshape(train_x_matrix,784,1,60000);
test_x_matrix=permute(test_x_matrix,[2,1,3]);
test_x_matrix=reshape(test_x_matrix,784,1,10000);
train_y=double(train_y);
test_y=double(test_y);
train_x_matrix=permute(train_x_matrix,[2,1,3]);
train_x_matrix=reshape(train_x_matrix,28,28,60000);
test_x_matrix=permute(test_x_matrix,[2,1,3]);
test_x_matrix=reshape(test_x_matrix,28,28,10000);
train_x_matrix1=zeros(28,20,60000);
test_x_matrix1=zeros(28,20,10000);
for i=1:60000
    train_x_matrix1(:,:,i)=pca(train_x_matrix(:,:,i));
end
for i=1:10000
    test_x_matrix1(:,:,i)=pca(test_x_matrix(:,:,i));
end
train_x_matrix1=permute(train_x_matrix1,[2,1,3]);
train_x_matrix1=reshape(train_x_matrix1,560,1,60000);
test_x_matrix1=permute(test_x_matrix1,[2,1,3]);
test_x_matrix1=reshape(test_x_matrix1,560,1,10000);
sam_sum=60000;
input=560;
output=10;
hid=30;
w1=randn([input,hid]);
w2=randn([hid,output]);
bias1=zeros(hid,1);
bias2=zeros(output,1);
rate1=0.25;                                      
rate2=0.25;
temp1=zeros(hid,1);    %%%20x1
net=temp1;
temp2=zeros(output,1); %%%10x1
z=temp2;
for num=1:10
    for i=1:sam_sum%60000
        label=zeros(10,1);
        label(train_y(i)+1,1)=1;
        temp1 = (train_x_matrix1(:,:,i)'*w1)' + bias1;%30x1
        net = 1./(1+exp(-temp1));%30x1
        temp2 =(net'*w2)'+ bias2;%10x1
        z = 1./(1+exp(-temp2));%10x1
        error = label - z;%10x1
        deltaZ = error.*z.*(1-z);%10x1 梯度跟新公式
        deltaNet = net.*(1-net).*(w2*deltaZ);%30x1
        for j = 1:output%10
            w2(:,j) = w2(:,j) + rate2*deltaZ(j).*net;
        end
        for j = 1:hid%20
            w1(:,j) = w1(:,j) + rate1*deltaNet(j).*train_x_matrix1(:,:,i);
        end
        bias2 = bias2 + rate2*deltaZ;
        bias1 = bias1 + rate1*deltaNet;
    end
end
test_sum=10000;
count=0;
for i=1:test_sum
    temp1=(test_x_matrix1(:,:,i)'*w1)'+bias1;
    net=1./(1+exp(-temp1));
    temp2=(net'*w2)'+bias2;
    z=1./(1+exp(-temp2));
    [maxn,inx]=max(z);
    inx=inx-1;
    if inx==test_y(i);
        count=count+1;
    end
end
correctrate=count/test_sum;
disp(correctrate); 