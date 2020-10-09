local menu = require("menu")
local globals = require("globals")

function translateAll(lang)
    lang = lang or "pl"

    if lang == "pl" then
        --menu
        TEXT_BTN_CONTINUE = "Kontynuuj"
        TEXT_BTN_NEWGAME = "Nowa gra"
        TEXT_BTN_OPTS = "Opcje"
        TEXT_BTN_ABOUT = "O grze"
        TEXT_BTN_EXIT = "Wyjdź z gry"

        --globals
        STR_VERSION = "wersja"
        STR_DEBUGMODE = " (tryb debugowania)"
    elseif lang == "en" then
        --menu
        TEXT_BTN_CONTINUE = "Continue"
        TEXT_BTN_NEWGAME = "New Game"
        TEXT_BTN_OPTS = "Options"
        TEXT_BTN_ABOUT = "About"
        TEXT_BTN_EXIT = "Exit"

        --globals
        STR_VERSION = "version"
        STR_DEBUGMODE = " (debug mode)"
    end

    globalsTranslate()
    menuTranslate()
end