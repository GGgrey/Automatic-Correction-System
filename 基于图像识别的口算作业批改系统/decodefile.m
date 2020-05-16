%%%%%读取MNIST数据集%%%%% 
function output=decodefile(filename,type)
fio=fopen(filename,'r');
a = fread(fio,'uint8');
if strcmp(type,'image')
output=a(17:end);%提取像素数据
else if strcmp(type,'label')
        output=a(9:end);      
    end
end
% TRAINING SET LABEL FILE (train-labels-idx1-ubyte):
% 
% [offset] [type]          [value]          [description] 
% 0000     32 bit integer  0x00000801(2049) magic number (MSB first) 
% 0004     32 bit integer  60000            number of items 
% 0008     unsigned byte   ??               label 
% 0009     unsigned byte   ??               label 
% ........ 
% xxxx     unsigned byte   ??               label
% The labels values are 0 to 9.
 
% TRAINING SET IMAGE FILE (train-images-idx3-ubyte):
% 
% [offset] [type]          [value]          [description] 
% 0000     32 bit integer  0x00000803(2051) magic number 
% 0004     32 bit integer  60000            number of images 
% 0008     32 bit integer  28               number of rows 
% 0012     32 bit integer  28               number of columns 
% 0016     unsigned byte   ??               pixel 
% 0017     unsigned byte   ??               pixel 
% ........ 
% xxxx     unsigned byte   ??               pixel
 
% TEST SET LABEL FILE (t10k-labels-idx1-ubyte):
% 
% [offset] [type]          [value]          [description] 
% 0000     32 bit integer  0x00000801(2049) magic number (MSB first) 
% 0004     32 bit integer  10000            number of items 
% 0008     unsigned byte   ??               label 
% 0009     unsigned byte   ??               label 
% ........ 
% xxxx     unsigned byte   ??               label
% The labels values are 0 to 9.
% 
% TEST SET IMAGE FILE (t10k-images-idx3-ubyte):
% 
% [offset] [type]          [value]          [description] 
% 0000     32 bit integer  0x00000803(2051) magic number 
% 0004     32 bit integer  10000            number of images 
% 0008     32 bit integer  28               number of rows 
% 0012     32 bit integer  28               number of columns 
% 0016     unsigned byte   ??               pixel 
% 0017     unsigned byte   ??               pixel 
% ........ 
% xxxx     unsigned byte   ??               pixel
