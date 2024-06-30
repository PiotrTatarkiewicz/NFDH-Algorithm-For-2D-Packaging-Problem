clear all
tic;
% Algorytm Next-Fit decreasing dla problemu pakowania 2D 

% Długosc palety to odleglosc na osi poziomej (y), szerokosc zas na osi
% poziomej (x)
 
paleta = zeros(1200,800);           %rozmiar palety w "kratkach"
paleta2 = zeros(1200,800);          %kolejne pietra palet
paleta3 = zeros(1200,800);
paleta4 = zeros(1200,800);
paleta5 = zeros(1200,800);

start = 1;                              %Wybor skad zaczynamy ukladac kostki, 1 oznacza lewy gorny rog (punkt: 1,1)

%Dostarczona macierz rozmiarów kostek
kostki = [250, 120; 220, 170; 230, 400; 180, 100; 70, 90; 80, 30; 100, 70; 200, 500; 50, 400; 260, 700; 130,70; 180,800; 180,200; 30,30; 60,20; 130,100; 70,70; 90,90;80,90;90,80;];        %wymiary kolejnych kostek (szeroskosc i dlugosc; x y)

n = size(kostki);        % n - liczba kostek
n=n(1);                  % liczba kostek 

% Sortowanie
posortowane_kostki = sortrows(kostki, -1) %sortowanie kostek po dlugosci

wym_palety = size(paleta);
dlugosc_palety = wym_palety(1);
szerokosc_palety = wym_palety(2);
liczba_koszy = 4;
iter_przeniesienia = 0;
iter_przeniesienia_poprz=0;
licznik_szerokosci_palet=dlugosc_palety;
suma_szerokosci_koszy=[];
k_stare = 0;
p=2;
m=1;
l=1;
o=2;

for i = 1:n

if i==1     % i == 1 (pierwszta iteracja) oznacza pierwsza, najwieksza postawiona kostke

paleta(start:posortowane_kostki(n+1), start:posortowane_kostki(1)) = i;
suma_szerokosci_koszy(1) = posortowane_kostki(i);
wspolrzedne_x(i) = (posortowane_kostki(i))/2 +1;
wspolrzedne_y(i) = (posortowane_kostki(n+i))/2 +1;

else 

if iter_przeniesienia == 0
a = start+sum(posortowane_kostki(n+1:n+i-1)) + posortowane_kostki(n+i);
waz = a;
else
b = start+ licznik_szerokosci_palet + sum(posortowane_kostki(n+iter_przeniesienia+1:n+i-1)) + posortowane_kostki(n+i);  
waz = b;
end
waz;

for k=1:liczba_koszy
    
    if waz > dlugosc_palety * k && waz <= dlugosc_palety * (k+1) 
    Komunikat = sprintf('Kostka o numerze %d nie mieści się na palecie w %d koszu, nastepuje przeniesienie do kosza %d',i,k,k+1);
    disp(Komunikat)

        if k~=k_stare %Flaga zmiany kosza
        o=o-1;
        p=p-1;
        end

        if p==1         %Gdy flaga, przesun iteracje
        iter_przeniesienia = i-1;
        p=p+1;
        end

        if o==1
        if k>1
        iter_przeniesienia_poprz = iter_przeniesienia;
        licznik_szerokosci_palet = licznik_szerokosci_palet + dlugosc_palety; %Licznik powinien co kolejny kosz zwiekszac się o dlugosc(!!!) palety
        end
        o=o+1;
        suma_szerokosci_koszy(k+1) = posortowane_kostki(i);
        end 

    if k==1
    paleta(start+ sum(posortowane_kostki(n+iter_przeniesienia+1:n+i-1)) : start+sum(posortowane_kostki(n+iter_przeniesienia+1:n+i))-1 ,... 
        posortowane_kostki(1)+1 : posortowane_kostki(1)+posortowane_kostki(i)) = i;

    wspolrzedne_x(i) = start + posortowane_kostki(1) + (posortowane_kostki(i))/2
    wspolrzedne_y(i) = start + (posortowane_kostki(n+i))/2 + sum(posortowane_kostki(n+iter_przeniesienia+1:n+i-1))

    else
    paleta(start+ sum(posortowane_kostki(n+iter_przeniesienia+1:n+i-1)) : start+sum(posortowane_kostki(n+iter_przeniesienia+1:n+i))-1 ,... 
    start + sum(suma_szerokosci_koszy)-suma_szerokosci_koszy(end) : start + sum(suma_szerokosci_koszy)-suma_szerokosci_koszy(end)+posortowane_kostki(i)-1) = i;   
    
    wspolrzedne_x(i) = start + sum(suma_szerokosci_koszy)-suma_szerokosci_koszy(end) + (posortowane_kostki(i))/2
    wspolrzedne_y(i) = start + (posortowane_kostki(n+i))/2 + sum(posortowane_kostki(n+iter_przeniesienia+1:n+i-1))
    
    end

    k_stare=k;
    break
    end
end 
    if waz <= dlugosc_palety
    paleta(start+sum(posortowane_kostki(n+1:n+i-1)):start+sum(posortowane_kostki(n+1:n+i))-1, start: posortowane_kostki(i)) = i;

    wspolrzedne_x(i) = start + (posortowane_kostki(i))/2
    wspolrzedne_y(i) = start + (posortowane_kostki(n+i))/2 + sum(posortowane_kostki(n+1:n+i-1))
    end
    
end
end

wspolrzedne_x
wspolrzedne_y

x = wspolrzedne_x(:)
y = wspolrzedne_y(:)


% Stop the timer
elapsedTime = toc;

% Display the elapsed time
disp(['Elapsed time: ' num2str(elapsedTime) ' seconds']);
figure;
image(paleta,'CDataMapping','scaled')
colorbar
colormap('turbo')
hold on

scatter(x, y, 10, 'white', 'filled');
