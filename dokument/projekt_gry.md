# &nbsp;<img src="https://github.com/Matek0611/PF2_gry_projekt/blob/main/game/assets/img/ikona1.png" width="24" height="24" title="Logo gry"> Koglomoglowy Uciekinier

__Autor__: Marcin Stefanowicz

## Spis treści

1. [Informacje wstępne](#1-informacje-wstępne)

    1.1. [Krótko o grze](#11-krótko-o-grze)

    1.2. [Silnik, język skryptowy, edytor](#12-silnik-język-skryptowy-edytor)

    1.3. [Inspiracja](#13-inspiracja)

2. [Elementy gry](#2-elementy-gry)

    2.1. [Interfejs użytkownika](#21-interfejs-użytkownika)
    
    2.2. [Grafika](#22-grafika)
    
    2.3. [Muzyka](#23-muzyka)
    
    2.4. [Postacie](#24-postacie)
    
    2.5. [Przedmioty do zdobycia](#25-przedmioty-do-zdobycia)
    
    2.6. [Poziomy](#26-poziomy)
    
    2.7. [Świat](#27-świat)
    
3. **[Lista pomysłów i rzeczy wykonanych](#3-lista-pomysłów-i-rzeczy-wykonanych)**

----

### 1. Informacje wstępne

#### 1.1. Krótko o grze

_Koglomoglowy Uciekinier_ to gra, w której wcielamy się w jednego z kilku bohaterów 
i przemierzamy różne pokoje skrywające a to zagadki, a to walki z niespodziewanymi,
przedziwnymi stworzeniami. Celem jest ucieczka z tego labiryntu niespodzianek. <br>
Nietypowa nazwa na grę przyszła mi do głowy podczas rozmowy o tym projekcie z moją przyjaciółką, 
gdzie w pewnym momencie przypomniała mi się jedna z moich ulubionych polskich serii filmów 
_Kogel-mogel_ (a dokładniej - _Miszmasz, czyli kogel-mogel 3_). Nie ukrywam, że w grze pojawią 
się smaczki i nawiązania do _Kogla-mogla_, a może się i zdarzyć, że będzie nimi przesiąknięta.

#### 1.2. Silnik, język skryptowy, edytor

__Silnik__: LÖVE (Love2d) 11.3

__Język skryptowy__: Lua

__Edytor__: Visual Studio Code

#### 1.3. Inspiracja

Pomysł na tą grę zrodził się mi podczas grania w grę _The Binding of Isaac: Rebirth_.
W niej przedzieramy się jednym z wybranych bohaterów przez ogrom pokoi po poszczególnych 
poziomach, pokonując przy tym bossów i mniejszych przeciwników. Uznałem, że zrobię coś
w podobnej formie, ale tak po mojemu i bez wątków religijnych oraz specjalnej fabuły.

### 2. Elementy gry

#### 2.1. Interfejs użytkownika

Interfejs użytkownika wykorzystuje mechanizm scen, by można było ponownie wykorzystać 
niektóre elementy, przyciski itp. Pewne rzeczy z tego mechanizmu zaimplementuję sam,
a reszta będzie korzystać z gotowych rozwiązań.

#### 2.2. Grafika

Grafikę rastrową zamierzam wykonać w programie GIMP, natomiast myślę, że większość
jednak będzie ,,rysowana kodem". Postaram się również zastosować shadery (świetlne,
rozmycia itd.).

#### 2.3. Muzyka

Wykorzystam jakąś gotową muzykę i efekty dźwiękowe. Informacje o nich pojawią się 
w rodziale trzecim.

#### 2.4. Postacie

Lista bohaterów:

|Imię             |Życie       |Krótki opis                       |
|:----------------|:----------:|:---------------------------------|
|Sieśka           | 3 k        |Najzwyklejsza postać z krwi i kości.|
|Myniek           | 2 k, 1 b   |Uwielbia słodkie zagadki.|
|Antywola         | 8 tm       |Jemu nic się nie chce.|
|Pusia del Bejduls| 1 tc x9    |Kot jak to kot ma 9 żyć.|

Rodzaje życia bohatera:

|Typ serduszka     |Skrót   |Kolor            | Jednorazowe uderzenie przeciwnika |Cechy szczególne                                              |
|:----------------:|:------:|:---------------:|----------------------------------:|:-------------------------------------------------------------|
|krwiste           | k      |czerwony         | - 0,5 pż                          |Jeśli straci się jedno całe to zostaje pusty kontener (tylko i wyłącznie tyczy się to tego typu serduszka).|
|bezowe            | b      |biały            | - 0,5 pż                          |Po zużyciu w całym pokoju przeciwnicy zostaną spowolnieni.|
|tymczasowe        | tm     |zielony          | - 1 pż                            |Brak|
|smolaste          | s      |czarny           | - 0,5 pż                          |Po zużyciu w całym pokoju przeciwnicy otrzymają obrażenia równe 2x obrażenia bohatera.|
|tęczowe           | tc     |różnokolorowy    | - 1 pż                            |Po zużyciu w całym pokoju przeciwnicy zostaną zabici albo zagadka zostanie rozwiązana.|

_\*__pż__ - punkty życia (1 pż = 1 serduszko)_

Statystyki dla każdego bohatera:

- _życie_ (min. 1 serduszko),

- _poruszanie się_ (0.1 - 20 kratek/s)

- _strzały_ (1 - 50 pocisków/s)

- _obrażenia_ (0.01 - 200)

- _szczęście_ (0 - 100%)

- _monety_ (0 - 1000)

- _latanie_ (tak/nie)

- _komnata pociechy_ (0 - 100%)

W rozgrywce pojawiać się będą również przeciwnicy oraz pokoje zagadek.

#### 2.5. Przedmioty do zdobycia

Lista ta pewnie się powiększy, ale na pewno pojawi się te 10 przedmiotów do zdobycia:

|Nazwa                 |Podpis                  | Co robi?             |
|----------------------|------------------------|----------------------|
|Żyćko                 |Krwistego serduszka nigdy dość!|+ 1 k|
|Eurasy i dolary       |Tu jest jakby luksusowo...|+ 25 monet|
|Pięciolistna koniczyna|A kto powiedział, że musi być cztero?|+ 5% szczęścia|
|Święte oleje          |No przecież dla przyjemności nikt nie pije, tylko jak mus!|+ 25% szybkości poruszania się|
|Do nieba              |Do nieba, nieba, do piekła ... Łuhuuu pójdę tam, gdzie się da!|+ latanie|
|Puk, puk!             |Krecik puka w taborecik!|strzały + 15, obrażenia - 50%|
|WŻTR                  |Wszak Żyjem Tylko Raz!|zamienia wszystkie obecne serca na tymczasowe + jedno tęczowe|
|Pif, paf, puuuuuf!    |Miś im w ucho!|+ (49%\*obecne + 1) obrażeń, + 5% strzały|
|Złoty król            |Królu złoty, czyś ty się nie zapędził?|- 20% wszystkie statystyki|
|Liczymy-zobaczymy     |Warto dodać 0? Nie warto. Zatem - koło fortuny!|+ losowe % do każdej statystyki|

#### 2.6. Poziomy

Będzie 10 poziomów, gdzie po każdym będzie wielki pokój zagadek.

#### 2.7. Świat

Świat przedstawiony będzie labiryntem pokoi zawierających zagadki, wrogów, a także inne niespodzianki.

### 3. Lista pomysłów i rzeczy wykonanych

- [x] ekran ładowania
- [x] menu główne
- [x] menu opcji
- [x] interfejs bohatera
- [x] shadery
- [x] generowanie losowego świata
- [x] zagadki
- [ ] przeciwnicy (nie ma)
- [x] pokoje
- [ ] przedmioty (nie ma)
