function result = picture_transform3(input_image)
str = '.\�ۺ���ҵ��\����һ\ģ��ͼ��\targetImage3.jpg';
I = imread(str);%Դͼ��
I_out = input_image;%Ƕ��ͼ��
%��ʾԴͼ����Ƕ��ͼ��
% figure,imshow(I);
% figure,imshow(I_out);
%Դͼ���е�Ƕ��λ��
x_point = [355,568,397,599];
y_point = [119,95,647,541];
%Ƕ��ͼ��任�ߴ�
[height,width,dim] = size(I_out);
%�ָ�mask
mask = imread('.\�ۺ���ҵ��\����һ\ģ��ͼ��\mask3.png');
mask = im2double(mask);
%����Ч��
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
I_su = repmat(I_su,[1,1,3]);%��ͨ��
%ͼ��任��Ƕ��ͼƬ
imgback2 = perspective_transform(I,I_su,x_point,y_point,height,width,0,mask);
result = imgback2;
end