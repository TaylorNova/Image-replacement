function result = picture_transform1(input_image)
str = '.\�ۺ���ҵ��\����һ\ģ��ͼ��\targetImage1.jpg';
I = imread(str);%Դͼ��
I_out = input_image;%Ƕ��ͼ��
%��ʾԴͼ����Ƕ��ͼ��
% figure,imshow(I);
% figure,imshow(I_out);
%Դͼ���е�Ƕ��λ��
x_point = [184,669,184,669];
y_point = [179,179,796,796];
%Ƕ��ͼ��任�ߴ�
[height,width,dim] = size(I_out);
%�ָ�mask
mask = imread('.\�ۺ���ҵ��\����һ\ģ��ͼ��\mask1.png');
mask = im2double(mask);
%�ͻ�Ч��
k = 10000;
[L,N] = superpixels(I_out,k); %�����طָ�
I_oil = zeros(size(I_out),'like',I_out);
idx = label2idx(L);
numRows = size(I_out,1);
numCols = size(I_out,2);
for labelVal = 1:N %�ɿ�ȡ��ֵ��ʾ
    redIdx = idx{labelVal};
    greenIdx = idx{labelVal}+numRows*numCols;
    blueIdx = idx{labelVal}+2*numRows*numCols;
    I_oil(redIdx) = mean(I_out(redIdx));
    I_oil(greenIdx) = mean(I_out(greenIdx));
    I_oil(blueIdx) = mean(I_out(blueIdx));
end
%ͼ��任��Ƕ��ͼƬ
imgback2 = perspective_transform(I,I_oil,x_point,y_point,height,width,0,mask);
result = imgback2;
end