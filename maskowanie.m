function [C] = maskowanie(film)

%Wczytanie filmu (zapis klatek do BMP i wektor indeksów nazw) B(4,:)
%Przyciêcie klatek do wymaganych wymiarów
[B, ilosc] = wczytaj(film);
%Pierwsze 9 klatek jest zawsze czarne wiêc nie ma czego tam szukaæ
for a=12:1:ilosc

%wykrycie ró¿nic miedzy klatkami
Bin8 = binaryzacja(a,a-2);
%rysowanie map migaczy
obrazek = migacz(B(a,:));

%maskowanie obrazów
obrazek(~Bin8) = 0;

imwrite(obrazek,a,'bmp');

C = [C; a];
end




