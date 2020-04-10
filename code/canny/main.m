% Zhanwei Xu
% 2019.11.26
close all
I = imread('coins.png');
Edge_I = canny(double(I),2,[0.005,0.12],'ShowProc',true);