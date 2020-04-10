function result = picture_transform3(input_image)
str = '.\综合作业四\任务一\模板图像\targetImage3.jpg';
I = imread(str);%源图像
I_out = input_image;%嵌入图像
%显示源图像与嵌入图像
% figure,imshow(I);
% figure,imshow(I_out);
%源图像中的嵌入位置
x_point = [355,568,397,599];
y_point = [119,95,647,541];
%嵌入图像变换尺寸
[height,width,dim] = size(I_out);
%分割mask
mask = imread('.\综合作业四\任务一\模板图像\mask3.png');
mask = im2double(mask);
%素描效果
[VG,A,PPG] = colorgrad(I_out);
ppg = im2uint8(PPG);  
ppgf = 255 - ppg;  
[M,N] = size(ppgf);T=200;  
ppgf1 = zeros(M,N);  
for ii = 1:M  
    for jj = 1:N  
        if ppgf(ii,jj)<T  
            ppgf1(ii,jj)=0;  
        else  
            ppgf1(ii,jj)=235/(255-T)*(ppgf(ii,jj)-T);  
        end  
    end  
end  
I_su = uint8(ppgf1);
I_su = repmat(I_su,[1,1,3]);%三通道
%图像变换并嵌入图片
imgback2 = perspective_transform(I,I_su,x_point,y_point,height,width,0,mask);
result = imgback2;
end