str_out = '.\综合作业四\任务一\源图像\sourceImage.jpg';
input_image1 = imread(str_out);%嵌入图像
result1 = picture_transform1(input_image1);
figure,imshow(result1);
result2 = picture_transform2(input_image1);
figure,imshow(result2);
result3 = picture_transform3(input_image1);
figure,imshow(result3);

str_out2 = '.\综合作业四\任务一\源图像\sourceImage2.jpg';
input_image2 = imread(str_out2);%嵌入图像
result4 = picture_transform4(input_image2);
figure,imshow(result4);
result5 = picture_transform5(input_image2);
figure,imshow(result5);
result6 = picture_transform6(input_image2);
figure,imshow(result6);