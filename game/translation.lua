local menu = require("menu")
local globals = require("globals")
local options = require("options")

function translateAll(lang)
    lang = lang or "pl"

    if lang == "en" then
        --game
        GAME_PRINT_NAME = "The Kogel Mogel Escaper"
        GAME_PRINT_NAME_SP = "The Kogel Mogel,Escaper"

        --menu
        TEXT_BTN_CONTINUE = "Continue"
        TEXT_BTN_NEWGAME = "New Game"
        TEXT_BTN_OPTS = "Options"
        TEXT_BTN_ABOUT = "About"
        TEXT_BTN_EXIT = "Exit"

        --globals
        STR_VERSION = "version"
        STR_DEBUGMODE = " (debug mode)"
        LOADSCR_TEXT1 = "Loading"
        LoadingHints = {
            "Robiąc coś, masz to e",
            "To drugie e",
            "e To jest bardzo długi tekst. To jest bardzo długi tekst. To jest bardzo długi tekst. To jest bardzo długi tekst. "
        }

        --options
        OPTS_BTN_BACK = "Back"

        OPTS_PAGE_GAME = "GAMEPLAY"
        OPTS_PAGE_CONTROLS = "CONTROLS"
        OPTS_PAGE_VIDEO = "VIDEO"
        OPTS_PAGE_AUDIO = "AUDIO"
    else --if lang == "pl" then
        --game
        GAME_PRINT_NAME = "Koglomoglowy Uciekinier"
        GAME_PRINT_NAME_SP = "Koglomoglowy,Uciekinier"

        --menu
        TEXT_BTN_CONTINUE = "Kontynuuj"
        TEXT_BTN_NEWGAME = "Nowa gra"
        TEXT_BTN_OPTS = "Opcje"
        TEXT_BTN_ABOUT = "O grze"
        TEXT_BTN_EXIT = "Wyjdź z gry"

        --globals
        STR_VERSION = "wersja"
        STR_DEBUGMODE = " (tryb debugowania)"
        LOADSCR_TEXT1 = "Ładowanie"
        LoadingHints = {
            "Robiąc coś, masz to",
            "To drugie",
            "To jest bardzo długi tekst. To jest bardzo długi tekst. To jest bardzo długi tekst. To jest bardzo długi tekst. "
        }

        --options
        OPTS_BTN_BACK = "Powrót"

        OPTS_PAGE_GAME = "ROZGRYWKA"
        OPTS_PAGE_CONTROLS = "STEROWANIE"
        OPTS_PAGE_VIDEO = "OBRAZ"
        OPTS_PAGE_AUDIO = "DŹWIĘK"
    end

    menuTranslate()

    love.window.setTitle(GAME_PRINT_NAME)
end