function result = picture_transform5(input_image)
str = '.\�ۺ���ҵ��\����һ\ģ��ͼ��\targetImage5.jpg';
I = imread(str);%Դͼ��
I_out = input_image;%Ƕ��ͼ��
%��ʾԴͼ����Ƕ��ͼ��
% figure,imshow(I);
% figure,imshow(I_out);
%Դͼ���е�Ƕ��λ�ã����λ��
x_point = [3519,4021,3528,4026];
y_point = [507,501,1017,1006];
x_point2 = [4234,4736,4235,4733];
y_point2 = [514,503,1018,1006];
x_point3 = [5130,5573,5114,5560];
y_point3 = [456,455,1037,1042];
%Ƕ��ͼ��任�ߴ�
[height,width,dim] = size(I_out);
%�ͻ�Ч��+��ͼ
k = 3000;
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
imgback2 = perspective_transform_withoutmask(I,I_oil,x_point,y_point,height,width,0);
imgback3 = perspective_transform_withoutmask(imgback2,I_oil,x_point2,y_point2,height,width,0);
imgback4 = perspective_transform_withoutmask(imgback3,I_oil,x_point3,y_point3,height,width,0);
result = imgback4;
end