local menu = require("menu")
local globals = require("globals")

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
    end

    menuTranslate()

    love.window.setTitle(GAME_PRINT_NAME)
end