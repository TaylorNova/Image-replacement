clc;
close all;
clear;
% ��Ƶ��ȡ
videoPath = '.\�ۺ���ҵ��\�����\targetVideo.MP4';%��Ƶ�ļ�·��
videos = VideoReader(videoPath);%��ȡ��Ƶ����
frameNumber = videos.NumberOfFrames; %��Ƶ֡��
%ͼƬ��ȡ
I_cover = imread('.\�ۺ���ҵ��\�����\cover.jpg');%��Ƕ�����ͼ
[height,width,dim] = size(I_cover);
last_frame = read(videos,1);%��һ֡
last_point = [60 150;77 897;783 804;671 105];%��һ֡�нǵ�
%��Ƶ����
fps = 29;
videoName = 'E:\ѧϰ\2019����\����ͼ����\�ۺ���ҵ\�ۺ���ҵ4\�ۺ���ҵ��\�����\result2.mp4';
videoObj = VideoWriter(videoName);
videoObj.FrameRate = fps; %��Ƶ֡��
open(videoObj);
for i = 1:frameNumber
    if mod(i,20) == 0
        i
    end
    % ͼƬ��ȡ
    current_frame = read(videos,i);
    [m,n,c] = size(current_frame);
    % ���ַָ�
    mask = ones(m,n);%�ָ�mask
    I_out = current_frame;
    k = 10000; %����������
    [L,N] = superpixels(I_out,k); %�����طָ�
    idx = label2idx(L);
    numRows = size(I_out,1);
    numCols = size(I_out,2);
    for labelVal = 1:N %ÿ�������صľ�ֵ
        redIdx = idx{labelVal};
        greenIdx = idx{labelVal}+numRows*numCols;
        blueIdx = idx{labelVal}+2*numRows*numCols;
        red_value = mean(I_out(redIdx));
        green_value = mean(I_out(greenIdx));
        blue_value = mean(I_out(blueIdx));
        %rgbֵ�ķ�Χ���ж��Ƿ�Ϊ��ָ
        if (red_value >= 60) && (red_value <= 160) && (green_value >= 40) && (green_value <= 132) && (blue_value >= 40) && (blue_value <= 132)
            mask(redIdx) = 0;
        end
    end
    %ȥ��mask�к�ɫ�Ĺµ�
    mask_fill = ~mask;%��ɫ
    CC = bwconncomp(mask_fill);%����ͨ��
    numPixels = cellfun(@numel,CC.PixelIdxList);
    [~,num] = size(numPixels);
    mask_fill2 = false(size(mask));
    for nu = 1:num
        if numPixels(nu)>5000 %ȥ����ͨ��С����ֵ�Ĳ���
            mask_fill2(CC.PixelIdxList{nu}) = 1;
        end
    end
    mask = ~mask_fill2;%��ɫ
    % �ǵ�׷��
    X = point_track(last_frame,last_point,current_frame);
    last_frame = current_frame;
    last_point = X;
    c = X(:,1);
    r = X(:,2);
    BW = roipoly(current_frame,c,r);
    BW = ~BW;
    mask = mask | BW;
    %ȥ��mask�к�ɫ�Ĺµ�
    mask_fill = ~mask;%��ɫ
    CC = bwconncomp(mask_fill);%����ͨ��
    numPixels = cellfun(@numel,CC.PixelIdxList);
    [~,num] = size(numPixels);
    mask_fill2 = false(size(mask));
    count = 0;
    max_one = 0;
    for nu = 1:num
        if numPixels(nu) > max_one
            max_one = numPixels(nu);
        end
        if numPixels(nu)>1000 %ȥ����ͨ��С����ֵ�Ĳ���
            mask_fill2(CC.PixelIdxList{nu}) = 1;
            count = count + 1; 
        end
    end
    if count == 0
        for nu = 1:num
            if numPixels(nu) == max_one
                break;
            end
        end
        mask_fill2(CC.PixelIdxList{nu}) = 1;
    end
    mask = ~mask_fill2;%��ɫ
    %�滻λ��
    x = [X(1,1),X(4,1),X(2,1),X(3,1)];
    y = [X(1,2),X(4,2),X(2,2),X(3,2)];
    %ͼ���滻
    imgBack = perspective_transform(current_frame,I_cover,x,y,height,width,0,mask); 
    frames=im2frame(imgBack); %ͼƬת��Ϊ֡
    writeVideo(videoObj,frames); %֡д����Ƶ
end
close(videoObj);
