local globals = require("globals")
local options = require("options")

TEXT_BTN_CONTINUE = "Kontynuuj"
TEXT_BTN_NEWGAME = "Nowa ucieczka"
TEXT_BTN_STATS = "Statystyki"
TEXT_BTN_OPTS = "Opcje"
TEXT_BTN_ABOUT = "O grze"
TEXT_BTN_EXIT = "Wyjdź z gry"

TEXT_NEWGAME_TITLE = "Rozpocznij nową ucieczkę"
TEXT_NEWGAME_HEADER = "Z którym bohaterem zaczniesz dziś nową ucieczkę?"

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

        --about
        TEXT_ABOUT_AUTHOR = "Author"
        TEXT_ABOUT_MUSIC = "Music"
        TEXT_ABOUT_HELP = "Acknowledgments"

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

        --about
        TEXT_ABOUT_AUTHOR = "Autor"
        TEXT_ABOUT_MUSIC = "Muzyka"
        TEXT_ABOUT_HELP = "Podziękowania"

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
    end

    menuTranslate()

    love.window.setTitle(GAME_PRINT_NAME)
end