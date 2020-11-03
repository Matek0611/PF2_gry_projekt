local Class = require("libs/basics/middleclass")
local Button = require("libs/basics/Button")
local Scene = require("libs/basics/Scene")
local Scenes = require("libs/basics/Scenes")
local globals = require("globals")
local savedata = require("libs/savedata")

-- zmienne globalne z opcjami

GLOBAL_OPTIONS = {
    DEBUG_MODE = true,
    
    OPTS_FPS_ON = false,
    OPTS_LANG = "pl",
    OPTS_
}

-- klasa zarządzania opcjami

local OptionsManagement = Class("OptionsManagement")

function OptionsManagement:initialize()
    self.filename = "opcje.kmu"
end

function OptionsManagement:save()
    --savedata.save(GLOBAL_OPTIONS, self.filename)
end

function OptionsManagement:load()
    if love.filesystem.getInfo(self.filename) then
        GLOBAL_OPTIONS = savedata.load(self.filename)
    end
end

ManageOpts = OptionsManagement:new()

-- menu opcji

OPTS_BTN_BACK = "Powrót"

btnOptsBack = Button:new(0, 0, 150, 50, OPTS_BTN_BACK)
btnOptsBack.colors = BTN_BLACK_THEME

OPTS_PAGE_GAME = "ROZGRYWKA"
OPTS_PAGE_CONTROLS = "STEROWANIE"
OPTS_PAGE_VIDEO = "GRAFIKA"
OPTS_PAGE_AUDIO = "DŹWIĘK"

PAGE_BTN_WIDTH = 150
PAGE_BTN_HEIGHT = 40
PAGE_BTN_SPACING = 10
PAGE_BTN_FULLWIDTH = 4 * PAGE_BTN_WIDTH + 3 * PAGE_BTN_SPACING

OPTS_ROW_H = 25

btnPageGame = Button:new(0, 0, PAGE_BTN_WIDTH, PAGE_BTN_HEIGHT, OPTS_PAGE_GAME)
btnPageGame.colors = BTN_BLACK_THEME_ACCENT
btnPageGame.fontname = "text"
btnPageGame.candown = true
btnPageControls = Button:new(0, 0, PAGE_BTN_WIDTH, PAGE_BTN_HEIGHT, OPTS_PAGE_CONTROLS)
btnPageControls.colors = BTN_BLACK_THEME_ACCENT
btnPageControls.fontname = "text"
btnPageControls.candown = true
btnPageVideo = Button:new(0, 0, PAGE_BTN_WIDTH, PAGE_BTN_HEIGHT, OPTS_PAGE_VIDEO)
btnPageVideo.colors = BTN_BLACK_THEME_ACCENT
btnPageVideo.fontname = "text"
btnPageVideo.candown = true
btnPageAudio = Button:new(0, 0, PAGE_BTN_WIDTH, PAGE_BTN_HEIGHT, OPTS_PAGE_AUDIO)
btnPageAudio.colors = BTN_BLACK_THEME_ACCENT
btnPageAudio.fontname = "text"
btnPageAudio.candown = true

OptionsActive = 1

OPTS_PAGE_GAME_BTN_FPS = "Pokazuj ilość klatek na sekundę"
local sc1btnFPS = Button:new(0, 0, 100, OPTS_ROW_H, OPTS_PAGE_GAME_BTN_FPS)
sc1btnFPS.fontname = "text"
sc1btnFPS.colors = BTN_BLACK_THEME_ACCENT
sc1btnFPS.textpos = "left"
sc1btnFPS.checkbox = true
sc1btnFPS.checked = GLOBAL_OPTIONS.OPTS_FPS_ON
sc1btnFPS.onClick = (function (sender) 
    GLOBAL_OPTIONS.OPTS_FPS_ON = sender.checked
end)

local function optionsPagesDraw()
    if OptionsActive == 1 then
        sc1btnFPS:draw()
    end
end

local function optionsPagesUpdate(dt)
    if OptionsActive == 1 then
        sc1btnFPS:update()
    end
end

local function optionsPagesIupdate()
    if OptionsActive == 1 then
        sc1btnFPS.width = love.graphics.getWidth() - 60
        sc1btnFPS:setPosition(love.graphics.getWidth() / 2, 50 + PAGE_BTN_HEIGHT + PAGE_BTN_SPACING)
    end
end

local function optionsDraw()  
    love.graphics.setColor(gray(10, 0.9))
    love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
    
    btnOptsBack:draw()
    btnPageGame:draw()
    btnPageControls:draw()
    btnPageVideo:draw()
    btnPageAudio:draw()

    optionsPagesDraw()
end

local function optionsUpdate(dt)    
    btnOptsBack:update(dt)    
    btnPageGame:update(dt)    
    btnPageControls:update(dt)    
    btnPageVideo:update(dt)   
    btnPageAudio:update(dt)

    optionsPagesUpdate(dt)
end

local function optionsIupdate()
    btnOptsBack:setPosition(love.graphics.getWidth() - 75 - 30, love.graphics.getHeight() - 50 - 10)
    btnPageGame:setPosition((love.graphics.getWidth() - PAGE_BTN_FULLWIDTH + PAGE_BTN_WIDTH) / 2, 50)
    btnPageControls:setPosition((love.graphics.getWidth() - PAGE_BTN_FULLWIDTH + PAGE_BTN_WIDTH * 3 + PAGE_BTN_SPACING) / 2, 50)
    btnPageVideo:setPosition((love.graphics.getWidth() - PAGE_BTN_FULLWIDTH + PAGE_BTN_WIDTH * 5 + PAGE_BTN_SPACING * 2) / 2, 50)
    btnPageAudio:setPosition((love.graphics.getWidth() - PAGE_BTN_FULLWIDTH + PAGE_BTN_WIDTH * 7 + PAGE_BTN_SPACING * 3) / 2, 50)

    optionsPagesIupdate()
end

local function optionsChangePage(id)
    btns = {btnPageGame, btnPageControls, btnPageVideo, btnPageAudio}
    for i, s in ipairs(btns) do
        s.down = i == id
    end
    OptionsActive = id
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

OptionsScene = Scene:new("opts", optionsDraw, optionsUpdate, optionsIupdate)
OptionsScene.onShow = (function(sender) 
    btnPageGame.onClick(sender)
end)