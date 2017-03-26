function [] = binaryzacja()

%NIEU¯YWANE (WCZYTANIE FILMU, PORÓWNANIE KLATEK I BINARYZACJA WYNIKU - JAKO
%SKRYPT)


%film='9b.avi';
film='6.avi';
B = wczytaj(film);

%Odjêcie od siebie kolejnych klatek
mapa=porownanie(B(13,:),B(11,:));

%Konwersja do skali szaroœci
I = rgb2gray(mapa);

%Binaryzacja
BW = im2bw(I, 0.1);

%Stworzenie elementu strukturalnego i operacja otwarcia w celu usuniêcia
%zanieczyszczeñ
se = strel('disk',1);
Bin = imopen(BW,se);

%Operacja zamkniêcia w celu zgrupowania i uszczelnienia
se = strel('disk',5);
Bin = imclose(Bin,se);

%Zmiana typu zmiennej z logical na uint8
Bin8 = im2uint8(Bin);

%%
%Maska
%Obrazek(~Bin8) = 0;