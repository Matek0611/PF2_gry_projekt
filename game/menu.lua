local Button = require("libs/basics/Button")
local globals = require("globals")

btnPlay, btnNewGame, btnOpts, btnAbout, btnExit = nil, nil, nil, nil, nil 

TEXT_BTN_CONTINUE = "Kontynuuj"
TEXT_BTN_NEWGAME = "Nowa gra"
TEXT_BTN_OPTS = "Opcje"
TEXT_BTN_ABOUT = "O grze"
TEXT_BTN_EXIT = "Wyjdź z gry"

MENU_BG_COLOR = color(30, 1)

local BTN_WIDTH, BTN_HEIGHT, BTN_TOPEX = 200, 50, 150

local function btnExitClick(sender)
    love.event.quit(0)
end

local function buttonsInit()
    btnPlay = Button:new(love.graphics.getWidth() / 2, BTN_TOPEX+100, BTN_WIDTH, BTN_HEIGHT)
    btnPlay.enabled = false
    btnNewGame = Button:new(love.graphics.getWidth() / 2, BTN_TOPEX+160, BTN_WIDTH, BTN_HEIGHT)
    btnOpts = Button:new(love.graphics.getWidth() / 2, BTN_TOPEX+220, BTN_WIDTH, BTN_HEIGHT)
    btnAbout = Button:new(love.graphics.getWidth() / 2, BTN_TOPEX+280, BTN_WIDTH, BTN_HEIGHT)
    btnExit = Button:new(love.graphics.getWidth() / 2, BTN_TOPEX+340, BTN_WIDTH, BTN_HEIGHT)
    btnExit.onClick = btnExitClick
end

local function buttonsUpdate(dt)
    local left = love.graphics.getWidth() / 2
    btnPlay.position.x = left
    btnNewGame.position.x = left
    btnOpts.position.x = left
    btnAbout.position.x = left
    btnExit.position.x = left

    btnPlay:update(dt)
    btnNewGame:update(dt)
    btnOpts:update(dt)
    btnAbout:update(dt)
    btnExit:update(dt)
end

local function buttonsDraw()
    btnPlay:draw()
    btnNewGame:draw()
    btnOpts:draw()
    btnAbout:draw()
    btnExit:draw()
end

local function bgDraw()
    love.graphics.setBackgroundColor(MENU_BG_COLOR)
end

function menuInit()
    buttonsInit()

end

function menuDraw()
    bgDraw()

    setFont("math", 15)
    love.graphics.setColor(color(255, 1))
    love.graphics.printf("(" .. STR_VERSION .. ": " .. GAME_VERSION .. ")", 0, love.graphics.getHeight() - love.graphics.getFont():getHeight() - 10, love.graphics.getWidth() - 10, "right")

    buttonsDraw()
end

function menuUpdate(dt)
    buttonsUpdate(dt)

end

function menuTranslate()
    btnPlay.text = TEXT_BTN_CONTINUE
    btnNewGame.text = TEXT_BTN_NEWGAME
    btnOpts.text = TEXT_BTN_OPTS
    btnAbout.text = TEXT_BTN_ABOUT
    btnExit.text = TEXT_BTN_EXIT
end