function [B,ilosc,map,I,BW,Bin8,map_turn,klatka1,A,mapa,X] = robocza (film)
%WSZYSTKIE OPERACJE ALE WYKONYWANE NA POJEDYNCZEJ KLATCE

qwe=15;

[B, ilosc] = wczytaj(film);
klatka1 = B(qwe,:);
klatka2 = B(qwe-2,:);
mapa=porownanie(klatka1,klatka2);
I = rgb2gray(mapa);
BW = im2bw(I, 0.1);
se = strel('disk',1);
Bin = imopen(BW,se);
Bin8 = im2uint8(Bin);
[map_turn,map] = migacz(klatka1);
%J = map_turn;
%J(~Bin8) = 0;
map_turn(~Bin8) = 0;

A = crop(klatka1); 
X = rgb2gray(A);
X(~Bin8) = 0;

%%
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

turn_r_upper=5; %od czego to zalezy?

cc = bwconncomp(map); %bwconncomp znajduje grupê 8 po³¹czonych elementów w obrazie binarnym
%Pobranie parametrów obiektów
stats = regionprops(cc, {'Centroid', 'Area', 'EquivDiameter'});
%Liczba kierunkowskazów
n=0;
%Sprawdzenie wszystkich kombinacji
for i=1:cc.NumObjects
    %Inicjalizacja tymczasowej mapy migacza
    map_turn_temp=zeros(size(map_turn));
    %migacz, zale¿nej promienia œwiat³a wsp. turn_r_upper
    x=floor(stats(i).Centroid(1) - turn_r_upper * stats(i).EquivDiameter/2) : floor(stats(i).Centroid(1) + turn_r_upper * stats(i).EquivDiameter/2);
    y=floor(stats(i).Centroid(2) - turn_r_upper * stats(i).EquivDiameter/2) : floor(stats(i).Centroid(2) + turn_r_upper * stats(i).EquivDiameter/2);
    
    %Ograniczenie obszaru do rozmiaru obrazu
    x( x>size(map_turn,2 ))=[];
    y( y>size(map_turn,1 ))=[];
    x( x<1 )=[];
    y( y<1 )=[];
    
    %Utworzenie mapy obiektów migacza w wyznaczonym obszarze
    map_turn_temp(y,x)=map_turn(y,x)*1;
    %Wyszukanie obiektu migacza
    turn_light=bwconncomp( map_turn_temp );
    %Jeœli znaleziono obiekt zapisanie go do macierzy kierunkowskazów
    
    if turn_light.NumObjects~=0
    n=n+1;
    temp_stats = regionprops(turn_light, 'Centroid');
    lights_turn(n,1)=temp_stats(1).Centroid(1);
    lights_turn(n,2)=temp_stats(1).Centroid(2);
    end
end

%Wyœwietlenie zdjêcia oryginalnego
figure(3), imshow(A)
%Narysowanie oznaczeñ œwiate³ na obrazie
%'T' dla kierunkowskazu
for i=1:n
text(lights_turn(i,1), lights_turn(i,2), 'T', 'Color', 'g','FontWeight', 'bold');
end