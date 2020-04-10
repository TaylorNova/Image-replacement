function result = picture_transform1(input_image)
str = '.\综合作业四\任务一\模板图像\targetImage1.jpg';
I = imread(str);%源图像
I_out = input_image;%嵌入图像
%显示源图像与嵌入图像
% figure,imshow(I);
% figure,imshow(I_out);
%源图像中的嵌入位置
x_point = [184,669,184,669];
y_point = [179,179,796,796];
%嵌入图像变换尺寸
[height,width,dim] = size(I_out);
%分割mask
mask = imread('.\综合作业四\任务一\模板图像\mask1.png');
mask = im2double(mask);
%油画效果
k = 10000;
[L,N] = superpixels(I_out,k); %超像素分割
I_oil = zeros(size(I_out),'like',I_out);
idx = label2idx(L);
numRows = size(I_out,1);
numCols = size(I_out,2);
for labelVal = 1:N %成块取均值显示
    redIdx = idx{labelVal};
    greenIdx = idx{labelVal}+numRows*numCols;
    blueIdx = idx{labelVal}+2*numRows*numCols;
    I_oil(redIdx) = mean(I_out(redIdx));
    I_oil(greenIdx) = mean(I_out(greenIdx));
    I_oil(blueIdx) = mean(I_out(blueIdx));
end
%图像变换并嵌入图片
imgback2 = perspective_transform(I,I_oil,x_point,y_point,height,width,0,mask);
result = imgback2;
end