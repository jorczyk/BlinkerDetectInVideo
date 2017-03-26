function [M]=crop(obraz) %wybor jaki obrazek

%PRZYCINANIE OBRAZU DO WYMAGANYCH WYMIARÓW

x_min = 0;
y_min = 430;
szer = 1900;
wys = 450;
przytnij_v = [x_min y_min szer wys];
 I = imread(obraz);
 M = imcrop(I, przytnij_v);
 %figure, imshow(M)