clear all;
X=imread('Buildings\Clean\Image_1.png');
noise=imread('Buildings\Noisy\Image_1.png'); 
X=rgb2gray(X);
noise = rgb2gray(noise);
subplot(2,2,1);imshow(X);
% colormap(map);
xlabel('(a)ԭʼͼ��');
axis square
%����������ͼ��
% init = 2055615866;
% randn('seed',init);
% x = X + 50*randn(size(X));
x = noise;
subplot(2,2,2);imshow(x);
% colormap(map);
xlabel('(b)������ͼ��');
axis square
%�������ͼ���ȥ�봦��
%��С������coif3��x����2��С���ֽ�
[c,s] = wavedec2(x,2,'coif3');
%��ȡС���ֽ��е�һ��ĵ�Ƶͼ�񣬼�ʵ���˵�ͨ�˲�ȥ��
%���ó߶�����
n = [1,2];
%������ֵ����p
% p = [10.12,23.28];
p = [1,2];
%�����������Ƶϵ��������ֵ����
nc = wthcoef2('h',c,s,n,p,'s');
nc = wthcoef2('v',nc,s,n,p,'s');
nc = wthcoef2('d',nc,s,n,p,'s');
%���µ�С���ֽ�ṹ[c,s]�����ع�
x1 = waverec2(nc,s,'coif3');
subplot(2,2,3);imshow(x1);
% colormap(map);
xlabel('(c)��һ��ȥ��ͼ��');
axis square
%��nc�ٴν����˲�ȥ��
xx = wthcoef2('v',nc,s,n,p,'s');
x2 = waverec2(xx,s,'coif3');
subplot(2,2,4);imshow(x2);
% colormap(map);
xlabel('(d)�ڶ���ȥ��ͼ��');

