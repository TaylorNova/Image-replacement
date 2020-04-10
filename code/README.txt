说明：
colorgrad.m是计算彩色图像梯度的函数
perspective_transform.m和perspective_transform_withoutmask.m是进行图像替换的函数，前者需要用到mask，后者则不需要
picture_transform1.m——picture_transform6.m为对应六幅模板图像的图像替换函数
picture_trans.m为进行图像替换的主函数

point_track.m为进行角点追踪的函数
main2.m为进行视频中图像替换的主函数

canny文件夹中为计算图像梯度的所需函数，使用时需要将其中的函数全拿出来跟上述函数置于同一文件夹下