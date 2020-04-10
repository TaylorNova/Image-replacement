function result = picture_transform2(input_image)
str = '.\综合作业四\任务一\模板图像\targetImage2.jpg';
I = imread(str);%源图像
I_out = input_image;%嵌入图像
%显示源图像与嵌入图像
% figure,imshow(I);
% figure,imshow(I_out);
%源图像中的嵌入位置
x_point = [46,543,19,592];
y_point = [46,50,372,410];
%嵌入图像变换尺寸
[height,width,dim] = size(I_out);
%分割mask
mask = imread('.\综合作业四\任务一\模板图像\mask2.png');
mask = im2double(mask);
%墙壁风格
[he,wi,ci] = size(I_out);
I_wall = imread('.\综合作业四\任务一\模板图像\wall.jpg');%墙壁原图
I_wall = rgb2gray(I_wall);
I_wall = im2double(I_wall);%墙壁灰度图
J = imresize(I_wall, [he,wi],'nearest');%图像插值放大
I_out_hsv = rgb2hsv(I_out);
for i = 1:he
    for j = 1:wi
        I_out_hsv(i,j,3) = I_out_hsv(i,j,3) * J(i,j); %亮度比例变化
    end
end
I_out = hsv2rgb(I_out_hsv) * 255;
%图像变换并嵌入图片
imgback2 = perspective_transform(I,I_out,x_point,y_point,height,width,0,mask);
result = imgback2;
end