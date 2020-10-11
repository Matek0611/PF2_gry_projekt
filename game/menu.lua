local Button = require("libs/basics/Button")
local globals = require("globals")
local Scenes = require("libs/basics/Scenes")
local Scene = require("libs/basics/Scene")
local options = require("options")

btnPlay, btnNewGame, btnOpts, btnAbout, btnExit = nil, nil, nil, nil, nil 
MenuScenes = Scenes:new()
MenuScenes.drawAll = true

TEXT_BTN_CONTINUE = "Kontynuuj"
TEXT_BTN_NEWGAME = "Nowa gra"
TEXT_BTN_OPTS = "Opcje"
TEXT_BTN_ABOUT = "O grze"
TEXT_BTN_EXIT = "Wyjdź z gry"

MENU_BG_COLOR = gray(30, 1)

local BTN_WIDTH, BTN_HEIGHT, BTN_TOPEX = 200, 50, 200

local function btnExitClick(sender)
    love.event.quit(0)
end

local function btnOptsClick(sender)
    MenuScenes:setActive(3)
end

local function btnOptsBackMenuClick(sender)
    MenuScenes:setActive(2)
end

local function buttonsInit()
    btnPlay = Button:new(love.graphics.getWidth() / 2, BTN_TOPEX+100, BTN_WIDTH, BTN_HEIGHT)
    btnPlay.enabled = false
    btnNewGame = Button:new(love.graphics.getWidth() / 2, BTN_TOPEX+160, BTN_WIDTH, BTN_HEIGHT)
    btnOpts = Button:new(love.graphics.getWidth() / 2, BTN_TOPEX+220, BTN_WIDTH, BTN_HEIGHT)
    btnAbout = Button:new(love.graphics.getWidth() / 2, BTN_TOPEX+280, BTN_WIDTH, BTN_HEIGHT)
    btnExit = Button:new(love.graphics.getWidth() / 2, BTN_TOPEX+340, BTN_WIDTH, BTN_HEIGHT)
    btnExit.onClick = btnExitClick
    btnOpts.onClick = btnOptsClick
end

local function buttonsUpdate(dt)
    btnPlay:update(dt)
    btnNewGame:update(dt)
    btnOpts:update(dt)
    btnAbout:update(dt)
    btnExit:update(dt)
end

local function buttonsiUpdate()
    local left = love.graphics.getWidth() / 2
    btnPlay.position.x = left
    btnNewGame.position.x = left
    btnOpts.position.x = left
    btnAbout.position.x = left
    btnExit.position.x = left

    if btnOptsBack.onClick ~= btnOptsBackMenuClick then 
        btnOptsBack.onClick = btnOptsBackMenuClick
    end
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

local function menuHomeDraw()
    drawLargeLogo(love.graphics.getWidth() / 2, 120)

    buttonsDraw()
end

local function menuHomeUpdate(dt)
    buttonsUpdate(dt)
end

local function menuHomeiUpdate(dt)
    buttonsiUpdate(dt)
end

function menuInit()
    local sc = Scene:new("home", menuHomeDraw, menuHomeUpdate, menuHomeiUpdate)
    sc.canDrawAll = true
    MenuScenes:addScene(sc)
    MenuScenes:addScene(OptionsScene)
    MenuScenes:setActive(2)
    buttonsInit()
end

function menuDraw()
    bgDraw()
    
    MenuScenes:draw()

    drawVersion()
end

function menuUpdate(dt)
    MenuScenes:update(dt)
end

function menuTranslate()
    btnPlay.text = TEXT_BTN_CONTINUE
    btnNewGame.text = TEXT_BTN_NEWGAME
    btnOpts.text = TEXT_BTN_OPTS
    btnAbout.text = TEXT_BTN_ABOUT
    btnExit.text = TEXT_BTN_EXIT
end