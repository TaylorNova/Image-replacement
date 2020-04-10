function result = picture_transform6(input_image)
str = '.\�ۺ���ҵ��\����һ\ģ��ͼ��\targetImage6.jpg';
I = imread(str);%Դͼ��
I_out = input_image;%Ƕ��ͼ��
%��ʾԴͼ����Ƕ��ͼ��
% figure,imshow(I);
% figure,imshow(I_out);
%Դͼ���е�Ƕ��λ��
x_point = [1213,2716,1198,2727];
y_point = [3053,3048,4002,4002];
%Ƕ��ͼ��任�ߴ�
[height,width,dim] = size(I_out);
%�Զ�Ч��-�����ȴ���ʱ�γ�Ч��

%ͼ��任��Ƕ��ͼƬ
imgback2 = perspective_transform_withoutmask(I,I_out,x_point,y_point,height,width,0);
%���ȴ���
imgback2 = im2double(imgback2);%���ͱ任
I = im2double(I);
imgback2_hsv = rgb2hsv(imgback2);%hsvͼ��
I_hsv = rgb2hsv(I);
[m,n,c] = size(I);%ͼ��ߴ�
for i = 1:m
    for j = 1:n
        imgback2_hsv(i,j,3) = I_hsv(i,j,3); %���ȱ任
    end
end
imgback2 = hsv2rgb(imgback2_hsv);
result = imgback2;
end