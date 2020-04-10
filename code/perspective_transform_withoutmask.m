function imgBack = perspective_transform_withoutmask(imgIn,imgIn2,x,y,outHeight,outWidth,bShow)
% �������ܣ�����ͶӰ�任
% --------input--------
% imgIn : Դͼ��
% imgIn2 :Ƕ��ͼ��
% x,y : ԭͼ���е������ı��ε�4��������꣨���ϣ����ϣ����£����£�
% outHeight,outWidth : ���ͼ��ĸߡ���
% bShow : �Ƿ���ʾ������0����ʾ
% --------output--------
% imgBack : Ƕ���ͼ��
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
%Ϊ������ͶӰ�任����Ҫ��4����ת��Ϊ��������
vector10 = pointLB - pointLT;
vector01 = pointRT - pointLT;
vector11 = pointRB - pointLT;
%��vector11��ʾ��vector10��vector01��������ϣ���ʹ������������
A = [vector10' , vector01'];
B = vector11' ;
S = A\B;
a0 = S(1);
a1 = S(2);

%�������
Imgback = uint8(zeros(outHeight,outWidth,imgInDimension));

imgBack = imgIn;
%����ѭ����������ÿ�����ص㸳ֵ
for heightLoop = min(y):max(y)
    for widthLoop = min(x):max(x)
        flag = 0;
        %�����㷨Ϊ�ο������еĹ�ʽ��ʾ
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
            FenMu = a0*a1+a1*(a1-1)*y0+a0*(a0-1)*y1;            %��ĸ
            x0 = a1*(a1+a0-1)*y0/FenMu;
            x1 = a0*(a1+a0-1)*y1/FenMu;
            %���ݵõ��Ĳ����ҵ���Ӧ��Դͼ���е�����λ�ã�����ֵ
            coordInOri = [x0*(outHeight-1) ; x1*(outWidth-1)];
            heightC = round(coordInOri(1))+1;
            widthC = round(coordInOri(2))+1;
            if (heightC > outHeight || heightC <= 0 || widthC >outWidth || widthC <=0 )
                disp(['m_PerspectiveTransformation������Χ' num2str(heightC) num2str(widthC)]);
                pause();
                return;
            end
            for dimentionLoop = 1:imgInDimension
                %ʹ����������ֵ��ʹ�ø߼���ֵ����Ч�������
                imgBack(heightLoop,widthLoop,dimentionLoop) = imgIn2(heightC,widthC,dimentionLoop);
            end
        end
    end
end

if bShow>0
    figure; imshow(imgBack); title('ͶӰ�任�Ľ��');
end