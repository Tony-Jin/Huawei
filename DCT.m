clear;
close all;
clc;
 
X=imread('Buildings\Clean\Image_3.png'); 
noise=imread('Buildings\Noisy\Image_3.png'); 
r=(noise(:,:,1));
g=(noise(:,:,2));
b=(noise(:,:,3));

T = 0.5;
% Y1 = blkproc(r(:,:,3),[4 31],'dct2');
% Y2 = blkproc(g(:,:,3),[4 31],'dct2');
% Y3 = blkproc(b(:,:,3),[4 31],'dct2');
Y1 = dct2(r);
Y2 = dct2(g);
Y3 = dct2(b);
[C1,S1] = wavedec2(r(:,:,1),6,'haar');
[C2,S2] = wavedec2(g(:,:,1),6,'haar');
[C3,S3] = wavedec2(b(:,:,1),6,'haar');

y1 = reshape(Y1,11808768,1);
y2 = reshape(Y2,11808768,1);
y3 = reshape(Y3,11808768,1);
c1 = C1';
c2 = C2';
c3 = C3';

% c_t = uint8(c);
ct1 = c1;
ct1(find(abs(c1)<T)) = 0;
ct2 = c2;
ct2(find(abs(c2)<T)) = 0;
ct3 = c3;
ct3(find(abs(c3)<T)) = 0;
% y_t = uint8(y);
yt1 = y1;
yt1(find(abs(y1)<T)) = 0;
yt2 = y2;
yt2(find(abs(y2)<T)) = 0;
yt3 = y3;
yt3(find(abs(y3)<T)) = 0;

% [x_dct,i_dct] = sort(abs(y),'descend');
% [x_wt,i_wt] = sort(abs(c),'descend');
% 
% len = length(x_dct);
% 
% %      N = 60;
% 
%     y1 = y;
%     c1 = c;
%     for i = 1:len
%         y1(i_dct(i)) = 0;
%         c1(i_wt(i)) = 0;
%     end

    Ct1 = ct1';
    Yt1 = reshape(yt1,3968,2976);
    Ct2 = ct2';
    Yt2 = reshape(yt2,3968,2976);
    Ct3 = ct3';
    Yt3 = reshape(yt3,3968,2976);

%     r1=blkproc(Yt1,[8 8],'idct2');
    r1 = idct(Yt1);
    r2 = waverec2(Ct1,S1,'haar');
%     g1=blkproc(Yt2,[8 8],'idct2');
    g1 = idct2(Yt2);
    g2 = waverec2(Ct2,S2,'haar');
%     b1=blkproc(Yt3,[8 8],'idct2');
    b1 = idct2(Yt3);
    b2 = waverec2(Ct3,S3,'haar');
    
    xr = uint8(r2);
    xg = uint8(g2);
    xb = uint8(b2);
    x = zeros(3968,2976,3);
    x(:,:,1) = xr;
    x(:,:,2) = xg;
    x(:,:,3) = xb;
    output = uint8(x);

    sn1 = psnr(output,X);   
    sn2 = psnr(noise,X);
    
% subplot(121),imshow(X1,[]),title('DCT');
% subplot(122),imshow(X2,[]),title('WT');
