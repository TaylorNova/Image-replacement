clc;
close all;
clear;
% 视频读取
videoPath = '.\综合作业四\任务二\targetVideo.MP4';%视频文件路径
videos = VideoReader(videoPath);%获取视频对象
frameNumber = videos.NumberOfFrames; %视频帧数
%图片读取
I_cover = imread('.\综合作业四\任务二\cover.jpg');%待嵌入封面图
[height,width,dim] = size(I_cover);
last_frame = read(videos,1);%第一帧
last_point = [60 150;77 897;783 804;671 105];%第一帧中角点
%视频生成
fps = 29;
videoName = 'E:\学习\2019年秋\数字图像处理\综合作业\综合作业4\综合作业四\任务二\result2.mp4';
videoObj = VideoWriter(videoName);
videoObj.FrameRate = fps; %视频帧率
open(videoObj);
for i = 1:frameNumber
    if mod(i,20) == 0
        i
    end
    % 图片读取
    current_frame = read(videos,i);
    [m,n,c] = size(current_frame);
    % 人手分割
    mask = ones(m,n);%分割mask
    I_out = current_frame;
    k = 10000; %超像素数量
    [L,N] = superpixels(I_out,k); %超像素分割
    idx = label2idx(L);
    numRows = size(I_out,1);
    numCols = size(I_out,2);
    for labelVal = 1:N %每个超像素的均值
        redIdx = idx{labelVal};
        greenIdx = idx{labelVal}+numRows*numCols;
        blueIdx = idx{labelVal}+2*numRows*numCols;
        red_value = mean(I_out(redIdx));
        green_value = mean(I_out(greenIdx));
        blue_value = mean(I_out(blueIdx));
        %rgb值的范围来判断是否为手指
        if (red_value >= 60) && (red_value <= 160) && (green_value >= 40) && (green_value <= 132) && (blue_value >= 40) && (blue_value <= 132)
            mask(redIdx) = 0;
        end
    end
    %去除mask中黑色的孤岛
    mask_fill = ~mask;%反色
    CC = bwconncomp(mask_fill);%找连通域
    numPixels = cellfun(@numel,CC.PixelIdxList);
    [~,num] = size(numPixels);
    mask_fill2 = false(size(mask));
    for nu = 1:num
        if numPixels(nu)>5000 %去除连通域小于阈值的部分
            mask_fill2(CC.PixelIdxList{nu}) = 1;
        end
    end
    mask = ~mask_fill2;%反色
    % 角点追踪
    X = point_track(last_frame,last_point,current_frame);
    last_frame = current_frame;
    last_point = X;
    c = X(:,1);
    r = X(:,2);
    BW = roipoly(current_frame,c,r);
    BW = ~BW;
    mask = mask | BW;
    %去除mask中黑色的孤岛
    mask_fill = ~mask;%反色
    CC = bwconncomp(mask_fill);%找连通域
    numPixels = cellfun(@numel,CC.PixelIdxList);
    [~,num] = size(numPixels);
    mask_fill2 = false(size(mask));
    count = 0;
    max_one = 0;
    for nu = 1:num
        if numPixels(nu) > max_one
            max_one = numPixels(nu);
        end
        if numPixels(nu)>1000 %去除连通域小于阈值的部分
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
    mask = ~mask_fill2;%反色
    %替换位置
    x = [X(1,1),X(4,1),X(2,1),X(3,1)];
    y = [X(1,2),X(4,2),X(2,2),X(3,2)];
    %图像替换
    imgBack = perspective_transform(current_frame,I_cover,x,y,height,width,0,mask); 
    frames=im2frame(imgBack); %图片转换为帧
    writeVideo(videoObj,frames); %帧写入视频
end
close(videoObj);
