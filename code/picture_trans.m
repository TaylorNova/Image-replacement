str_out = '.\�ۺ���ҵ��\����һ\Դͼ��\sourceImage.jpg';
input_image1 = imread(str_out);%Ƕ��ͼ��
result1 = picture_transform1(input_image1);
figure,imshow(result1);
result2 = picture_transform2(input_image1);
figure,imshow(result2);
result3 = picture_transform3(input_image1);
figure,imshow(result3);

str_out2 = '.\�ۺ���ҵ��\����һ\Դͼ��\sourceImage2.jpg';
input_image2 = imread(str_out2);%Ƕ��ͼ��
result4 = picture_transform4(input_image2);
figure,imshow(result4);
result5 = picture_transform5(input_image2);
figure,imshow(result5);
result6 = picture_transform6(input_image2);
figure,imshow(result6);