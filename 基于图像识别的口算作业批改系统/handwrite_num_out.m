%%%%%%%用于输出识别的手写体%%%%%%%%     %%%95.5%%%%
function y=handwrite_num_out(I)
load baocun.mat
I=I';
I=reshape(I,1,784);
I=permute(I,[2,1]);
I=double(I)/255;
temp1=(I'*baocun_w1)'+baocun_bias1;
net=1./(1+exp(-temp1));
temp2=(net'*baocun_w2)'+baocun_bias2;
z=1./(1+exp(-temp2));
[maxn,inx]=max(z);
inx=inx-1;
y=inx;
end
