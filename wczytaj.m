function [B,ilosc] = wczytaj(film) %wybor jaki obrazek

%WCZYTANIE FILMU I UTWORZENIE BMP DLA KA¯DEJ Z KLATEK

B=[]; %wektor nazw klatek
mov = aviread(film);
%mov = videoreader(film);
rozm=size(mov);
%Check = zeros(rozm);
ilosc=rozm(2);
for a=1:1:ilosc
obrazek=mov(1,a).cdata;
if a<10
nazwa=['klatka000', num2str(a), '.bmp'];
else
if (a>=10 && a<100)
nazwa=['klatka00', num2str(a), '.bmp'];
else
if (a>=100 && a<1000)
nazwa=['klatka0', num2str(a), '.bmp'];
else
nazwa=['klatka', num2str(a), '.bmp'];
end
end
end
imwrite(obrazek,nazwa,'bmp');
%obrazek2=crop(obrazek1);
B = [B; nazwa];
end
end

%B(4,:) - odwolanie do klatki nr 4 (do stringa klatka0004.bmp)