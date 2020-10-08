local mainmenu_buttons = {}

TEXT_BTN_CONTINUE = "Kontynuuj"
TEXT_BTN_NEWGAME = "Nowa gra"
TEXT_BTN_OPTS = "Opcje"
TEXT_BTN_ABOUT = "O grze"
TEXT_BTN_EXIT = "Wyjdź z gry"

function buttonAdd(name, x, y, text, id)
    table.insert(mainmenu_buttons, {name=name, x=x, y=y, text=text, id=id})
end

function buttonsInit()
    buttonAdd("btnPlay", 0, 0, TEXT_BTN_CONTINUE, "play")
    buttonAdd("btnNewGame", 0, 0, TEXT_BTN_NEWGAME, "new game")
    buttonAdd("btnOpts", 0, 0, TEXT_BTN_OPTS, "options")
    buttonAdd("btnAbout", 0, 0, TEXT_BTN_ABOUT, "about")
    buttonAdd("btnExit", 0, 0, TEXT_BTN_EXIT, "exit")
end

function buttonClick(x, y)

end

function buttonsUpdate()

end

function menuInit()
    buttonsInit()

end

function menuDraw()

end

function menuUpdate(dt)

end