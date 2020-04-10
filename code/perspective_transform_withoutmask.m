function imgBack = perspective_transform_withoutmask(imgIn,imgIn2,x,y,outHeight,outWidth,bShow)
% 函数功能：中心投影变换
% --------input--------
% imgIn : 源图像
% imgIn2 :嵌入图像
% x,y : 原图像中的任意四边形的4个点的坐标（左上，右上，左下，右下）
% outHeight,outWidth : 输出图像的高、宽
% bShow : 是否显示，大于0则显示
% --------output--------
% imgBack : 嵌入后图像
[imgInHeight,imgInWidth,imgInDimension] = size(imgIn);
x = double(int32(x));
y = double(int32(y));
pointLT = [y(1),x(1)];
pointRT = [y(2),x(2)];
pointLB = [y(3),x(3)];
pointRB = [y(4),x(4)];
y(3) = pointRB(1);
x(3) = pointRB(2);
y(4) = pointLB(1);
x(4) = pointLB(2);
%为了中心投影变换，需要将4个点转化为三个向量
vector10 = pointLB - pointLT;
vector01 = pointRT - pointLT;
vector11 = pointRB - pointLT;
%把vector11表示成vector10和vector01的线性组合，以使三个向量共面
A = [vector10' , vector01'];
B = vector11' ;
S = A\B;
a0 = S(1);
a1 = S(2);

%输出矩形
Imgback = uint8(zeros(outHeight,outWidth,imgInDimension));

imgBack = imgIn;
%利用循环操作来对每个像素点赋值
for heightLoop = min(y):max(y)
    for widthLoop = min(x):max(x)
        flag = 0;
        %以下算法为参考文献中的公式表示
        for i = 1:3
            x1 = heightLoop-y(i);
            y1 = widthLoop-x(i);
            x2 = y(i+1)-y(i);
            y2 = x(i+1)-x(i);
            if x1*y2-y1*x2<0
                flag = 1;
            end
        end
        x1 = heightLoop-y(4);
        y1 = widthLoop-x(4);
        x2 = y(1)-y(4);
        y2 = x(1)-x(4);
        if x1*y2-y1*x2<0
            flag = 1;
        end
        if flag == 0
            xx = heightLoop-y(1);
            yy = widthLoop-x(1);
            yyy = A\[xx;yy];
            y0 = yyy(1);
            y1 = yyy(2);
            FenMu = a0*a1+a1*(a1-1)*y0+a0*(a0-1)*y1;            %分母
            x0 = a1*(a1+a0-1)*y0/FenMu;
            x1 = a0*(a1+a0-1)*y1/FenMu;
            %根据得到的参数找到对应的源图像中的坐标位置，并赋值
            coordInOri = [x0*(outHeight-1) ; x1*(outWidth-1)];
            heightC = round(coordInOri(1))+1;
            widthC = round(coordInOri(2))+1;
            if (heightC > outHeight || heightC <= 0 || widthC >outWidth || widthC <=0 )
                disp(['m_PerspectiveTransformation超出范围' num2str(heightC) num2str(widthC)]);
                pause();
                return;
            end
            for dimentionLoop = 1:imgInDimension
                %使用最近邻域插值，使用高级插值方法效果会更好
                imgBack(heightLoop,widthLoop,dimentionLoop) = imgIn2(heightC,widthC,dimentionLoop);
            end
        end
    end
end

if bShow>0
    figure; imshow(imgBack); title('投影变换的结果');
end