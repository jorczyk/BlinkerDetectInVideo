function [map_turn,map]=migacz(obraz) %wybor jaki obrazek

%RYSOWANIE MAP MIGACZA I ŒWIATE£ TYLNICH NA PODSTAWIE TURN_LIGHTS.M

h_upper=round(0.01*255); %130;
h_lower=round(0.93*255); %110;
s_upper=round(1.00*255);
s_lower=round(0.27*255);
v_upper=round(1.00*255);
v_lower=round(0.31*255);

%Górne i dolne granice w przestrzeni HSV kierunkowskazów
turn_h_lower=round(0.05*255); %140; %160
turn_h_upper=round(0.24*255); %190
turn_s_lower=(0.55*255); %140
turn_s_upper=(1.00*255); %255
turn_v_lower=round(0.55*255); %140
turn_v_upper=round(1.00*255); %255

A = crop(obraz); 
%Konwersja obrazu na HSV
B= uint16(rgb2hsv(A)*255);
%Przesuniêcie odcienia o po³owê
%B(:,:,1)= mod( B(:,:,1) +128, 256); %po zakomentowaniu daje duzo wiecej
%wynikow (tez blednych) [dlaczego przesuwamy odcienie?]
B=uint8(B);

%Inicjalizacja map obiektów
map=zeros(size(B,1), size(B,2), 1);
map_turn=map;

%Utworzenie map na podstawie granic podanych w parametrach
%Mapa œwiate³ tylnich
map( (((h_lower<B(:,:,1)) | (B(:,:,1)<=h_upper)) & s_lower<B(:,:,2) & B(:,:,2)<=s_upper & v_lower<B(:,:,3) & B(:,:,3)<=v_upper) )=1;
map( (110<B(:,:,1)& B(:,:,1)<=130 & s_lower<B(:,:,2) & B(:,:,2)<=s_upper & v_lower<B(:,:,3) & B(:,:,3)<=v_upper) )=1;

%Mapa migacza
map_turn( (turn_h_lower<B(:,:,1)& B(:,:,1)<=turn_h_upper & turn_s_lower<B(:,:,2) & B(:,:,2)<=turn_s_upper & turn_v_lower<B(:,:,3) & B(:,:,3)<=turn_v_upper) )=1;

%Uworzenie elementu strukturalnego
se = strel('disk',10);
%Morfologiczna operacja zemkniêcia
map = imclose(map,se); %utworzenie map binarnych
map_turn = imclose(map_turn,se);

%Usuniêcie z mapy migacza obiektów nale¿¹cych do œwiate³ tylnich (je¿eli istnieja czesci wspolne)
map_turn(map==1)=0;

