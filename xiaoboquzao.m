clear all;
X=imread('Buildings\Clean\Image_1.png');
noise=imread('Buildings\Noisy\Image_1.png'); 
X=rgb2gray(X);
noise = rgb2gray(noise);
subplot(2,2,1);imshow(X);
% colormap(map);
xlabel('(a)原始图像');
axis square
%产生含噪声图像
% init = 2055615866;
% randn('seed',init);
% x = X + 50*randn(size(X));
x = noise;
subplot(2,2,2);imshow(x);
% colormap(map);
xlabel('(b)含噪声图像');
axis square
%下面进行图像的去噪处理
%用小波函数coif3对x进行2层小波分解
[c,s] = wavedec2(x,2,'coif3');
%提取小波分解中第一层的低频图像，即实现了低通滤波去噪
%设置尺度向量
n = [1,2];
%设置阈值向量p
% p = [10.12,23.28];
p = [1,2];
%对三个方向高频系数进行阈值处理
nc = wthcoef2('h',c,s,n,p,'s');
nc = wthcoef2('v',nc,s,n,p,'s');
nc = wthcoef2('d',nc,s,n,p,'s');
%对新的小波分解结构[c,s]进行重构
x1 = waverec2(nc,s,'coif3');
subplot(2,2,3);imshow(x1);
% colormap(map);
xlabel('(c)第一次去噪图像');
axis square
%对nc再次进行滤波去噪
xx = wthcoef2('v',nc,s,n,p,'s');
x2 = waverec2(xx,s,'coif3');
subplot(2,2,4);imshow(x2);
% colormap(map);
xlabel('(d)第二次去噪图像');

