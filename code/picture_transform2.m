function result = picture_transform2(input_image)
str = '.\�ۺ���ҵ��\����һ\ģ��ͼ��\targetImage2.jpg';
I = imread(str);%Դͼ��
I_out = input_image;%Ƕ��ͼ��
%��ʾԴͼ����Ƕ��ͼ��
% figure,imshow(I);
% figure,imshow(I_out);
%Դͼ���е�Ƕ��λ��
x_point = [46,543,19,592];
y_point = [46,50,372,410];
%Ƕ��ͼ��任�ߴ�
[height,width,dim] = size(I_out);
%�ָ�mask
mask = imread('.\�ۺ���ҵ��\����һ\ģ��ͼ��\mask2.png');
mask = im2double(mask);
%ǽ�ڷ��
[he,wi,ci] = size(I_out);
I_wall = imread('.\�ۺ���ҵ��\����һ\ģ��ͼ��\wall.jpg');%ǽ��ԭͼ
I_wall = rgb2gray(I_wall);
I_wall = im2double(I_wall);%ǽ�ڻҶ�ͼ
J = imresize(I_wall, [he,wi],'nearest');%ͼ���ֵ�Ŵ�
I_out_hsv = rgb2hsv(I_out);
for i = 1:he
    for j = 1:wi
        I_out_hsv(i,j,3) = I_out_hsv(i,j,3) * J(i,j); %���ȱ����仯
    end
end
I_out = hsv2rgb(I_out_hsv) * 255;
%ͼ��任��Ƕ��ͼƬ
imgback2 = perspective_transform(I,I_out,x_point,y_point,height,width,0,mask);
result = imgback2;
end