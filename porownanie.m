function [Z]=porownanie(obraz1,obraz2)

%ODJÊCIE OD SIEBIE 2 KLATEK W CELU ZNALEZIENIA ZMIAN W OBRAZIE

obraz1=crop(obraz1);
obraz2=crop(obraz2);
obraz1 = uint8(obraz1);
obraz2 = uint8(obraz2);
Z = imsubtract(obraz1,obraz2);

%figure, imshow(Z)