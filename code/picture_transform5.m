function result = picture_transform5(input_image)
str = '.\综合作业四\任务一\模板图像\targetImage5.jpg';
I = imread(str);%源图像
I_out = input_image;%嵌入图像
%显示源图像与嵌入图像
% figure,imshow(I);
% figure,imshow(I_out);
%源图像中的嵌入位置，多个位置
x_point = [3519,4021,3528,4026];
y_point = [507,501,1017,1006];
x_point2 = [4234,4736,4235,4733];
y_point2 = [514,503,1018,1006];
x_point3 = [5130,5573,5114,5560];
y_point3 = [456,455,1037,1042];
%嵌入图像变换尺寸
[height,width,dim] = size(I_out);
%油画效果+多图
k = 3000;
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
imgback2 = perspective_transform_withoutmask(I,I_oil,x_point,y_point,height,width,0);
imgback3 = perspective_transform_withoutmask(imgback2,I_oil,x_point2,y_point2,height,width,0);
imgback4 = perspective_transform_withoutmask(imgback3,I_oil,x_point3,y_point3,height,width,0);
result = imgback4;
end