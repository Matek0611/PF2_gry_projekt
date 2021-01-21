local globals = require("globals")
local options = require("options")
local herosdesc = require("libs/heros/herosdesc")

--Sieśka
HERO_SIESKA = {
    NAME = "Sieśka",
    DESC = "Najzwyklejsza postać z krwi i kości."
}

--Myniek
HERO_MYNIEK = {
    NAME = "Myniek",
    DESC = "Uwielbia słodkie zagadki."
}

--Antywola
HERO_ANTYWOLA = {
    NAME = "Antywola",
    DESC = "Jemu nic się nie chce."
}

--Pusia del Bejduls
HERO_PUSIA = {
    NAME = "Pusia del Bejduls",
    DESC = "Kot jak to kot ma 9 żyć."
}

TEXT_BTN_CONTINUE = "Kontynuuj"
TEXT_BTN_NEWGAME = "Nowa ucieczka"
TEXT_BTN_STATS = "Statystyki"
TEXT_BTN_OPTS = "Opcje"
TEXT_BTN_ABOUT = "O grze"
TEXT_BTN_EXIT = "Wyjdź z gry"

TEXT_NEWGAME_TITLE = "Rozpocznij nową ucieczkę"
TEXT_NEWGAME_HEADER = "Z którym bohaterem zaczniesz dziś nową ucieczkę?"

RIDDLES_COUNT = 11

RIDDLES = {}
for i = 1, RIDDLES_COUNT do 
    RIDDLES[i] = {}
    RIDDLES[i].content = ""
end

onTranslateRiddles = (function ()
    if GLOBAL_OPTIONS.OPTS_LANG == "en" then 
        RIDDLES[1].content = "What number will be next in this sequence?\n0, %d, %d, %d, %d, %d, ?"
        RIDDLES[2].content = "What number will be next in this sequence?\n%d, %d, %d, %d, %d, %d, ?"
        RIDDLES[3].content = "In the last %d matches, Adam scored %d, Wojtek scored %d, and Maciek half the number of goals scored by Adam and Wojtek together. How many goals have they scored in total?"
        RIDDLES[4].content = "%d people pick up their coats after the party. But it's a mess there. If %d people have their own coat, what is the probability that person number %d has someone else's coat?"
        RIDDLES[5].content = "If log(x, ⁡%d) = log(x, ⁡%d) + log(x, ⁡%d), x = e is true."
        RIDDLES[6].content = "Arrange the numbers in ascending order.\n%d, %d, %d, %d, %d, %d"
        RIDDLES[7].content = "If %s has less money than %s and %s has more money than %s, then %s has less money than %s. True or False?"
        RIDDLES[8].content = "Which number does not match the rest?\n%d, %d, %d, %d, %d, %d, %d"
        RIDDLES[9].content = "Calculate (%d - (- %d)) / 3 / (- %d + 2 * %d)."
        RIDDLES[10].content = "Do both equations give the same result?\nx - log%d1 = 1\n%d^0 = x + 0!"
        RIDDLES[11].content = "'Well, the great-uncle of my second husband's brother-in-law (...), extremely handsome' bought %d eggs in the shop. He broke half a dozen eggs on his way home. There are still %d more eggs waiting for him in the fridge. How many total eggs does he have?"
    else
        RIDDLES[1].content = "Jaka liczba będzie następna w tym ciągu?\n0, %d, %d, %d, %d, %d, ?"
        RIDDLES[2].content = "Jaka liczba będzie następna w tym ciągu?\n%d, %d, %d, %d, %d, %d, ?"
        RIDDLES[3].content = "W ostatnich %d meczach Adam strzelił %d bramek, Wojtek strzelił %d, a Maciek połowę liczby bramek uzyskanych przez Adama i Wojtka razem. Ile goli zdobyli łącznie?"
        RIDDLES[4].content = "%d osób odbiera swoje płaszcze po przyjęciu. Panuje tam jednak bałagan. Jeżeli %d osób ma swój płaszcz, to jakie jest prawdopodobieństwo, że osoba numer %d ma cudzy płaszcz?"
        RIDDLES[5].content = "Jeżeli log(x, ⁡%d) = log(x, ⁡%d) + log(x, ⁡%d), to x = e jest prawdziwe."
        RIDDLES[6].content = "Uporządkuj liczby od najmniejszej do największej.\n%d, %d, %d, %d, %d, %d"
        RIDDLES[7].content = "Jeśli %s ma mniej pieniędzy niż %s, a %s ma więcej pieniędzy niż %s, to %s ma mniej pieniędzy niż %s. Prawda czy fałsz?"
        RIDDLES[8].content = "Która liczba nie pasuje do pozostałych?\n%d, %d, %d, %d, %d, %d, %d"
        RIDDLES[9].content = "Oblicz (%d - (- %d)) / 3 / (- %d + 2 * %d)."
        RIDDLES[10].content = "Czy oba równania dają taki sam wynik?\nx - log(%d, 1) = 1\n%d^0 = x + 0!"
        RIDDLES[11].content = ",,Otóż stryjeczny wuj szwagra mego drugiego męża (...), niesłychanie przystojny'' kupił w sklepie %d jajek. Wracając do domu rozbił pół tuzina jajek. W lodówce czeka na niego jeszcze %d jajek. Ile łącznie ma wszystkich jajek?"
    end
end)

function translateAll(lang)
    lang = lang or "pl"

    if lang == "en" then
        --game
        -- GAME_PRINT_NAME = "The Kogel Mogel Escaper"
        -- GAME_PRINT_NAME_SP = "The Kogel Mogel,Escaper"

        --menu
        TEXT_BTN_CONTINUE = "Continue"
        TEXT_BTN_NEWGAME = "New Escape"
        TEXT_BTN_STATS = "Stats"
        TEXT_BTN_OPTS = "Options"
        TEXT_BTN_ABOUT = "About"
        TEXT_BTN_EXIT = "Exit"

        TEXT_PAUSED = "Paused"
        TEXT_PAUSED_CONTINUE = "Continue"
        TEXT_PAUSED_LOSE = "Lose"

        TEXT_END_BTN = "Back To Main Menu"
        TEXT_END = "It's The End, My Dear!"

        --about
        TEXT_ABOUT_AUTHOR = "Author"
        TEXT_ABOUT_MUSIC = "Music"
        TEXT_ABOUT_HELP = "Acknowledgments"

        --stats
        STATS_TIME = "Best Time"

        --globals
        STR_VERSION = "version"
        STR_DEBUGMODE = " (debug mode)"
        LOADSCR_TEXT1 = "Loading"
        LoadingHints = {
            "The choice of your character will affect the beginning of the game.",
            "You don't have to enter all the rooms, it's important to reach the end room.",
            "In the options menu there are some useful functions. I know you know but you know.",
            "You can't turn back time so pay attention not to die.",
            "In the Pirenees! You can't cheat? - Yep",
            "OK",
            "Lead your character with due respect!",
            "Ehhh this loading again like in the sims...",
            "I hope you don't find any bugs - if yes, sorry :/",
            "Come on, load up ;_;",
            "Onion has layers, ogres have layers, this game has layers, too.",
            "Let's not stay in the Old Pixel Age!!!",
            "Attention! I repeat - don't wanna repeat myself!",
            "thankss...thankss...thankss...thankss...thankss...thankss...thankss...thankss...thankss...thankss...thankss..."
        }

        --options
        OPTS_BTN_BACK = "Back"

        OPTS_PAGE_GAME = "GAMEPLAY"
        OPTS_PAGE_CONTROLS = "CONTROLS"
        OPTS_PAGE_VIDEO = "VIDEO"
        OPTS_PAGE_AUDIO = "AUDIO"

        OPTS_PAGE_GAME_BTN_FPS = "Show Frames Per Second"

        OPTS_PAGE_CONTR_LB_MOVEUP = "Move Up"
        OPTS_PAGE_CONTR_LB_MOVEDOWN = "Move Down"
        OPTS_PAGE_CONTR_LB_MOVELEFT = "Move Left"
        OPTS_PAGE_CONTR_LB_MOVERIGHT = "Move Right"

        OPTS_PAGE_VID_LB_LANG = "Language"

        OPTS_PAGE_AUD_LB_VOL = "Global Volume"

        --heros
        --Sieśka
        HERO_SIESKA = {
            NAME = "Sieśka",
            DESC = "The most ordinary creature of flesh and blood."
        }

        --Myniek
        HERO_MYNIEK = {
            NAME = "Myniek",
            DESC = "He likes sweet mysteries."
        }
        --Antywola
        HERO_ANTYWOLA = {
            NAME = "Antywola",
            DESC = "He doesn't want to do anything."
        }
        --Pusia del Bejduls
        HERO_PUSIA = {
            NAME = "Pusia del Bejduls",
            DESC = "This cat as the normal cats has 9 lives."
        }

        --new game
        TEXT_NEWGAME_TITLE = "Start a New Escape"
        TEXT_NEWGAME_HEADER = "Who are you going to start a new escape with today?"
        TEXT_LEVEL_NAME = "Level"

        --inne
        ODP_YES = "Yes"
        ODP_NO = "No"
        ODP_TRUE = "True"
        ODP_FALSE = "False"
    else --if lang == "pl" then
        --game
        -- GAME_PRINT_NAME = "Koglomoglowy Uciekinier"
        -- GAME_PRINT_NAME_SP = "Koglomoglowy,Uciekinier"

        --menu
        TEXT_BTN_CONTINUE = "Kontynuuj"
        TEXT_BTN_NEWGAME = "Nowa ucieczka"
        TEXT_BTN_STATS = "Statystyki"
        TEXT_BTN_OPTS = "Opcje"
        TEXT_BTN_ABOUT = "O grze"
        TEXT_BTN_EXIT = "Wyjdź z gry"

        TEXT_PAUSED = "Pauza"
        TEXT_PAUSED_CONTINUE = "Kontunnuj"
        TEXT_PAUSED_LOSE = "Przegraj"

        TEXT_END_BTN = "Jadymy do menu głównego"
        TEXT_END = "To ju kuniec kochanieńki!"

        --about
        TEXT_ABOUT_AUTHOR = "Autor"
        TEXT_ABOUT_MUSIC = "Muzyka"
        TEXT_ABOUT_HELP = "Podziękowania"

        --stats
        STATS_TIME = "Najlepszy czas"

        --globals
        STR_VERSION = "wersja"
        STR_DEBUGMODE = " (tryb debugowania)"
        LOADSCR_TEXT1 = "Ładowanie"
        LoadingHints = {
            "Wybór twojej postaci będzie miał duży wpływ na początek rozgrywki.",
            "Nie musisz wejść do wszystkich pokoi, ważne, by dotrzeć do pokoju końcowego.",
            "W menu opcje znajduje się kilka przydatnych funkcji. Wiem, że wiesz, ale wiesz.",
            "Czasu nie cofniesz, więc uważaj, by nie zginąć.",
            "W Pireneje! Nie da się czitować? - Nom",
            "OK",
            "Prowadź swoją postać z należytym szacunkiem!",
            "Ehhh znów to ładowanie jak w simsach...",
            "Mam nadzieję, że nie znajdziesz żadnych błędów - jeśli jednak tak, to sorki :/",
            "No dalej, ładuj się ;_;",
            "Cebula ma warstwy, ogry mają warstwy, ta gra też ma wartwy.",
            "Nie pozostajmy w epoce piksela łupanego!!!",
            "Uwaga! Powtarzam - nie chcę się powtarzać!",
            "dziekuje...dziekuje...dziekuje...dziekuje...dziekuje...dziekuje...dziekuje...dziekuje...dziekuje...dziekuje...dziekuje..."
        }

        --options
        OPTS_BTN_BACK = "Powrót"

        OPTS_PAGE_GAME = "ROZGRYWKA"
        OPTS_PAGE_CONTROLS = "STEROWANIE"
        OPTS_PAGE_VIDEO = "OBRAZ"
        OPTS_PAGE_AUDIO = "DŹWIĘK"

        OPTS_PAGE_GAME_BTN_FPS = "Pokazuj ilość klatek na sekundę"

        OPTS_PAGE_CONTR_LB_MOVEUP = "Idź w górę"
        OPTS_PAGE_CONTR_LB_MOVEDOWN = "Idź w dół"
        OPTS_PAGE_CONTR_LB_MOVELEFT = "Idź w lewo"
        OPTS_PAGE_CONTR_LB_MOVERIGHT = "Idź w prawo"

        OPTS_PAGE_VID_LB_LANG = "Język"

        OPTS_PAGE_AUD_LB_VOL = "Ogólna głośność"

        --heros
        --Sieśka
        HERO_SIESKA = {
            NAME = "Sieśka",
            DESC = "Najzwyklejsza postać z krwi i kości."
        }
        --Myniek
        HERO_MYNIEK = {
            NAME = "Myniek",
            DESC = "Uwielbia słodkie zagadki."
        }
        --Antywola
        HERO_ANTYWOLA = {
            NAME = "Antywola",
            DESC = "Jemu nic się nie chce."
        }
        --Pusia del Bejduls
        HERO_PUSIA = {
            NAME = "Pusia del Bejduls",
            DESC = "Kot jak to kot ma 9 żyć."
        }

        --new game
        TEXT_NEWGAME_TITLE = "Rozpocznij nową ucieczkę"
        TEXT_NEWGAME_HEADER = "Z którym bohaterem zaczniesz dziś nową ucieczkę?"
        TEXT_LEVEL_NAME = "Poziom"

        --inne
        ODP_YES = "Tak"
        ODP_NO = "Nie"
        ODP_TRUE = "Prawda"
        ODP_FALSE = "Fałsz"
    end

    onTranslateRiddles()

    menuTranslate()

    love.window.setTitle(GAME_PRINT_NAME)
end