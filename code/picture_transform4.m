function result = picture_transform4(input_image)
str = '.\综合作业四\任务一\模板图像\targetImage4.jpg';
I = imread(str);%源图像
I_out = input_image;%嵌入图像
%显示源图像与嵌入图像
% figure,imshow(I);
% figure,imshow(I_out);
%源图像中的嵌入位置
x_point = [1,3000,1,3000];
y_point = [310,310,1987,1987];
%嵌入图像变换尺寸
[height,width,dim] = size(I_out);
%分割mask
mask = imread('.\综合作业四\任务一\模板图像\mask4.png');
mask = im2double(mask);
%自动效果-在亮度处理时形成效果

%图像变换并嵌入图片
imgback2 = perspective_transform(I,I_out,x_point,y_point,height,width,0,mask);
%亮度处理
imgback2 = im2double(imgback2);%类型变换
I = im2double(I);
imgback2_hsv = rgb2hsv(imgback2);%hsv图像
I_hsv = rgb2hsv(I);
[m,n,c] = size(I);%图像尺寸
for i = 1:m
    for j = 1:n
        imgback2_hsv(i,j,3) = I_hsv(i,j,3); %亮度变换
    end
end
imgback2 = hsv2rgb(imgback2_hsv);
result = imgback2;
end