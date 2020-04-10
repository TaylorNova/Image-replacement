function result = point_track(last_frame,last_point,current_frame)
%ͼƬ��ȡ
I1 = rgb2gray(last_frame);
I2 = rgb2gray(current_frame);
%��һ֡ͼ���нǵ�
x = last_point;
% SURF features
p1 = detectSURFFeatures(I1);
p2 = detectSURFFeatures(I2);
[f1, p1] = extractFeatures(I1, p1);
[f2, p2] = extractFeatures(I2, p2);
% show the matches 
pair = matchFeatures(f1, f2);
loc1_m = p1(pair(:,1),:);
loc2_m = p2(pair(:,2),:);
% RANSAC match
[T,inlierloc2_m,inlierloc1_m] = estimateGeometricTransform(loc2_m,loc1_m,'projective');
%ƥ���ӳ��
x_ex = [x(:,1),x(:,2),[1;1;1;1]];%��չ����
trans_matrix = double(inv(T.T));%�任����
X = x_ex * trans_matrix;
result = [X(:,1)./X(:,3),X(:,2)./X(:,3)]; 
end