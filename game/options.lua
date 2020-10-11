local Button = require("libs/basics/Button")
local Scene = require("libs/basics/Scene")
local globals = require("globals")

DEBUG_MODE = true
OPTS_FPS_ON = false

OPTS_BTN_BACK = "Powrót"

btnOptsBack = Button:new(0, 0, 150, 50, OPTS_BTN_BACK)
btnOptsBack.colors = BTN_BLACK_THEME
btnOptsBack.fontname = "text"

OPTS_PAGE_GAME = "ROZGRYWKA"
OPTS_PAGE_CONTROLS = "STEROWANIE"
OPTS_PAGE_VIDEO = "GRAFIKA"
OPTS_PAGE_AUDIO = "DŹWIĘK"

PAGE_BTN_WIDTH = 150
PAGE_BTN_HEIGHT = 40
PAGE_BTN_SPACING = 10
PAGE_BTN_FULLWIDTH = 4 * PAGE_BTN_WIDTH + 3 * PAGE_BTN_SPACING

btnPageGame = Button:new(0, 0, PAGE_BTN_WIDTH, PAGE_BTN_HEIGHT, OPTS_PAGE_GAME)
btnPageGame.colors = BTN_BLACK_THEME_ACCENT
btnPageGame.fontname = "text"
btnPageControls = Button:new(0, 0, PAGE_BTN_WIDTH, PAGE_BTN_HEIGHT, OPTS_PAGE_CONTROLS)
btnPageControls.colors = BTN_BLACK_THEME_ACCENT
btnPageControls.fontname = "text"
btnPageVideo = Button:new(0, 0, PAGE_BTN_WIDTH, PAGE_BTN_HEIGHT, OPTS_PAGE_VIDEO)
btnPageVideo.colors = BTN_BLACK_THEME_ACCENT
btnPageVideo.fontname = "text"
btnPageAudio = Button:new(0, 0, PAGE_BTN_WIDTH, PAGE_BTN_HEIGHT, OPTS_PAGE_AUDIO)
btnPageAudio.colors = BTN_BLACK_THEME_ACCENT
btnPageAudio.fontname = "text"

local function optionsDraw()  
    love.graphics.setColor(gray(10, 0.9))
    love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
    
    

    btnOptsBack:draw()
    btnPageGame:draw()
    btnPageControls:draw()
    btnPageVideo:draw()
    btnPageAudio:draw()
end

local function optionsUpdate(dt)
    btnOptsBack:setPosition(love.graphics.getWidth() - 75 - 30, love.graphics.getHeight() - 50 - 10)
    btnOptsBack:update(dt)

    btnPageGame:setPosition((love.graphics.getWidth() - PAGE_BTN_FULLWIDTH + PAGE_BTN_WIDTH) / 2, 50)
    btnPageGame:update(dt)
    btnPageControls:setPosition((love.graphics.getWidth() - PAGE_BTN_FULLWIDTH + PAGE_BTN_WIDTH * 3 + PAGE_BTN_SPACING) / 2, 50)
    btnPageControls:update(dt)
    btnPageVideo:setPosition((love.graphics.getWidth() - PAGE_BTN_FULLWIDTH + PAGE_BTN_WIDTH * 5 + PAGE_BTN_SPACING * 2) / 2, 50)
    btnPageVideo:update(dt)
    btnPageAudio:setPosition((love.graphics.getWidth() - PAGE_BTN_FULLWIDTH + PAGE_BTN_WIDTH * 7 + PAGE_BTN_SPACING * 3) / 2, 50)
    btnPageAudio:update(dt)
end

local function optionsChangePage(id)
    btns = {btnPageGame, btnPageControls, btnPageVideo, btnPageAudio}
    for i, s in ipairs(btns) do
        s.down = i == id
    end
end

btnPageGame.onClick = (function(sender) 
    optionsChangePage(1)
end)
btnPageControls.onClick = (function(sender) 
    optionsChangePage(2)
end)
btnPageVideo.onClick = (function(sender) 
    optionsChangePage(3)
end)
btnPageAudio.onClick = (function(sender) 
    optionsChangePage(4)
end)

OptionsScene = Scene:new("opts", optionsDraw, optionsUpdate)

OptionsScene.onShow = (function()
    optionsChangePage(1)
end)