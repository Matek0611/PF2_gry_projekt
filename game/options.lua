local Class = require("libs/basics/middleclass")
local Button = require("libs/basics/Button")
local Scene = require("libs/basics/Scene")
local Scenes = require("libs/basics/Scenes")
local globals = require("globals")
local savedata = require("libs/savedata")
local music = require("music")

-- zmienne globalne z opcjami

GLOBAL_OPTIONS = {
    DEBUG_MODE = true,
    
    OPTS_FPS_ON = false,
    OPTS_LANG = "pl",
    
    HERO_UP = "w",
    HERO_DOWN = "s",
    HERO_LEFT = "a",
    HERO_RIGHT = "d",

    BEST_TIME = 0
}

loadDataFromOpts = nil

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
    if loadDataFromOpts ~= nil then loadDataFromOpts() end
end

ManageOpts = OptionsManagement:new()

__START_LANG = "pl"

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

OPTS_ROW_H = 50

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

-- Rozgrywka

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

-- Sterowanie

OPTS_PAGE_CONTR_LB_MOVEUP = "Idź w górę"
local sc2btnMoveUpLabel = Button:new(0, 0, 300, OPTS_ROW_H, OPTS_PAGE_CONTR_LB_MOVEUP)
sc2btnMoveUpLabel.colors = BTN_TRANSPARENT_THEME
sc2btnMoveUpLabel.fontname = "text"
sc2btnMoveUpLabel.textpos = "left"
sc2btnMoveUpLabel.static = true
OPTS_PAGE_CONTR_LB_MOVEDOWN = "Idź w dół"
local sc2btnMoveDownLabel = Button:new(0, 0, 300, OPTS_ROW_H, OPTS_PAGE_CONTR_LB_MOVEDOWN)
sc2btnMoveDownLabel.colors = BTN_TRANSPARENT_THEME
sc2btnMoveDownLabel.fontname = "text"
sc2btnMoveDownLabel.textpos = "left"
sc2btnMoveDownLabel.static = true
OPTS_PAGE_CONTR_LB_MOVELEFT = "Idź w lewo"
local sc2btnMoveLeftLabel = Button:new(0, 0, 300, OPTS_ROW_H, OPTS_PAGE_CONTR_LB_MOVELEFT)
sc2btnMoveLeftLabel.colors = BTN_TRANSPARENT_THEME
sc2btnMoveLeftLabel.fontname = "text"
sc2btnMoveLeftLabel.textpos = "left"
sc2btnMoveLeftLabel.static = true
OPTS_PAGE_CONTR_LB_MOVERIGHT = "Idź w prawo"
local sc2btnMoveRightLabel = Button:new(0, 0, 300, OPTS_ROW_H, OPTS_PAGE_CONTR_LB_MOVERIGHT)
sc2btnMoveRightLabel.colors = BTN_TRANSPARENT_THEME
sc2btnMoveRightLabel.fontname = "text"
sc2btnMoveRightLabel.textpos = "left"
sc2btnMoveRightLabel.static = true

local sc2btnMoveUpBtn = Button:new(-200, -200, 200, OPTS_ROW_H, "W")
sc2btnMoveUpBtn.colors = BTN_WHITE_THEME
sc2btnMoveUpBtn.fontname = "text"
sc2btnMoveUpBtn.onClick = (function (sender) 
    if sender.text == "W" then
        sender.text = "/\\"
        GLOBAL_OPTIONS.HERO_UP = "up"
    else
        sender.text = "W"
        GLOBAL_OPTIONS.HERO_UP = "w"
    end
end)
local sc2btnMoveDownBtn = Button:new(-200, -200, 200, OPTS_ROW_H, "S")
sc2btnMoveDownBtn.colors = BTN_WHITE_THEME
sc2btnMoveDownBtn.fontname = "text"
sc2btnMoveDownBtn.onClick = (function (sender) 
    if sender.text == "S" then
        sender.text = "\\/"
        GLOBAL_OPTIONS.HERO_DOWN = "down"
    else
        sender.text = "S"
        GLOBAL_OPTIONS.HERO_DOWN = "s"
    end
end)
local sc2btnMoveLeftBtn = Button:new(-200, -200, 200, OPTS_ROW_H, "A")
sc2btnMoveLeftBtn.colors = BTN_WHITE_THEME
sc2btnMoveLeftBtn.fontname = "text"
sc2btnMoveLeftBtn.onClick = (function (sender) 
    if sender.text == "A" then
        sender.text = "<"
        GLOBAL_OPTIONS.HERO_LEFT = "left"
    else
        sender.text = "A"
        GLOBAL_OPTIONS.HERO_LEFT = "a"
    end
end)
local sc2btnMoveRightBtn = Button:new(-200, -200, 200, OPTS_ROW_H, "D")
sc2btnMoveRightBtn.colors = BTN_WHITE_THEME
sc2btnMoveRightBtn.fontname = "text"
sc2btnMoveRightBtn.onClick = (function (sender) 
    if sender.text == "D" then
        sender.text = ">"
        GLOBAL_OPTIONS.HERO_RIGHT = "right"
    else
        sender.text = "D"
        GLOBAL_OPTIONS.HERO_RIGHT = "d"
    end
end)

-- Grafika

OPTS_PAGE_VID_LB_LANG = "Język"
local sc3btnLangLabel = Button:new(0, 0, 300, OPTS_ROW_H, OPTS_PAGE_VID_LB_LANG)
sc3btnLangLabel.colors = BTN_TRANSPARENT_THEME
sc3btnLangLabel.fontname = "text"
sc3btnLangLabel.textpos = "left"
sc3btnLangLabel.static = true

local sc3btnLangBtn = Button:new(-200, -200, 200, OPTS_ROW_H, "Polski")
sc3btnLangBtn.colors = BTN_WHITE_THEME
sc3btnLangBtn.fontname = "text"
sc3btnLangBtn.onClick = (function (sender) 
    if sender.text == "Polski" then
        sender.text = "English"
        GLOBAL_OPTIONS.OPTS_LANG = "en"
    else
        sender.text = "Polski"
        GLOBAL_OPTIONS.OPTS_LANG = "pl"
    end
    translateAll(GLOBAL_OPTIONS.OPTS_LANG)
end)

-- Muzyka

OPTS_PAGE_AUD_LB_VOL = "Ogólna głośność"
local sc4btnVolLabel = Button:new(0, 0, 300, OPTS_ROW_H, OPTS_PAGE_AUD_LB_VOL)
sc4btnVolLabel.colors = BTN_TRANSPARENT_THEME
sc4btnVolLabel.fontname = "text"
sc4btnVolLabel.textpos = "left"
sc4btnVolLabel.static = true

local sc4btnVolDownBtn = Button:new(-200, -200, 50, OPTS_ROW_H, "-")
sc4btnVolDownBtn.colors = BTN_WHITE_THEME
sc4btnVolDownBtn.fontname = "text"
sc4btnVolDownBtn.onClick = (function (sender) 
    if ManageMusic.volume == 0 then return end
    if ManageMusic.volume == 0.2 then ManageMusic:setVolume(0.1) end -- poprawić buga 
    ManageMusic:setVolume(ManageMusic.volume - 0.1)
end)
local sc4btnVolUpBtn = Button:new(-200, -200, 50, OPTS_ROW_H, "+")
sc4btnVolUpBtn.colors = BTN_WHITE_THEME
sc4btnVolUpBtn.fontname = "text"
sc4btnVolUpBtn.onClick = (function (sender) 
    if ManageMusic.volume == 1 then return end
    ManageMusic:setVolume(ManageMusic.volume + 0.1)
end)

-- reszta

loadDataFromOpts = (function () 

end)

function updateExOpts()
    if __START_LANG == GLOBAL_OPTIONS.OPTS_LANG then return end
    __START_LANG = GLOBAL_OPTIONS.OPTS_LANG

    btnOptsBack.text = OPTS_BTN_BACK

    btnPageGame.text = OPTS_PAGE_GAME
    btnPageControls.text = OPTS_PAGE_CONTROLS
    btnPageVideo.text = OPTS_PAGE_VIDEO
    btnPageAudio.text = OPTS_PAGE_AUDIO

    sc1btnFPS.text = OPTS_PAGE_GAME_BTN_FPS

    sc2btnMoveUpLabel.text = OPTS_PAGE_CONTR_LB_MOVEUP
    sc2btnMoveDownLabel.text = OPTS_PAGE_CONTR_LB_MOVEDOWN
    sc2btnMoveLeftLabel.text = OPTS_PAGE_CONTR_LB_MOVELEFT
    sc2btnMoveRightLabel.text = OPTS_PAGE_CONTR_LB_MOVERIGHT

    sc3btnLangLabel.text = OPTS_PAGE_VID_LB_LANG

    sc4btnVolLabel.text = OPTS_PAGE_AUD_LB_VOL
end

local function optionsPagesDraw()
    if OptionsActive == 1 then
        sc1btnFPS:draw()
    elseif OptionsActive == 2 then
        sc2btnMoveUpLabel:draw()
        sc2btnMoveDownLabel:draw()
        sc2btnMoveLeftLabel:draw()
        sc2btnMoveRightLabel:draw()

        sc2btnMoveUpBtn:draw()
        sc2btnMoveDownBtn:draw()
        sc2btnMoveLeftBtn:draw()
        sc2btnMoveRightBtn:draw()
    elseif OptionsActive == 3 then
        sc3btnLangLabel:draw()

        sc3btnLangBtn:draw()
    elseif OptionsActive == 4 then
        sc4btnVolLabel:draw()

        sc4btnVolDownBtn:draw()
        sc4btnVolUpBtn:draw()

        local pc = getPrevColor()
        love.graphics.setColor(clWhite)
        setFont("text", 30)
        local poz
        if ManageMusic.volume == 0 then 
            poz = "0"
        else
            poz = tostring(ManageMusic.volume * 100)
        end
        love.graphics.printf(poz .. "%", sc4btnVolDownBtn.position.x + sc4btnVolDownBtn.width + 1, sc4btnVolDownBtn.position.y - 15, 100, "center")
        love.graphics.setColor(pc)
    end
end

local function optionsPagesUpdate(dt)
    if OptionsActive == 1 then
        sc1btnFPS:update(dt)
    elseif OptionsActive == 2 then
        sc2btnMoveUpLabel:update(dt)
        sc2btnMoveDownLabel:update(dt)
        sc2btnMoveLeftLabel:update(dt)
        sc2btnMoveRightLabel:update(dt)

        sc2btnMoveUpBtn:update(dt)
        sc2btnMoveDownBtn:update(dt)
        sc2btnMoveLeftBtn:update(dt)
        sc2btnMoveRightBtn:update(dt)
    elseif OptionsActive == 3 then
        sc3btnLangLabel:update(dt)

        sc3btnLangBtn:update(dt)
    elseif OptionsActive == 4 then
        sc4btnVolLabel:update(dt)

        sc4btnVolDownBtn:update(dt)
        sc4btnVolUpBtn:update(dt)
    end
end

local function optionsPagesIupdate()
    updateExOpts()

    if OptionsActive == 1 then
        sc1btnFPS.width = love.graphics.getWidth() / 2
        sc1btnFPS:setPosition(sc1btnFPS.width, 50 + PAGE_BTN_HEIGHT * 2+ PAGE_BTN_SPACING)
    elseif OptionsActive == 2 then
        local exw = (love.graphics.getWidth() - (300 * 2 + 200)) / 2

        sc2btnMoveUpLabel:setPosition(300 + exw, 50 + PAGE_BTN_HEIGHT * 2 + PAGE_BTN_SPACING)
        sc2btnMoveDownLabel:setPosition(300 + exw, 50 + PAGE_BTN_HEIGHT * 2 + PAGE_BTN_SPACING + (OPTS_ROW_H + PAGE_BTN_SPACING))
        sc2btnMoveLeftLabel:setPosition(300 + exw, 50 + PAGE_BTN_HEIGHT * 2 + PAGE_BTN_SPACING + (OPTS_ROW_H + PAGE_BTN_SPACING) * 2)
        sc2btnMoveRightLabel:setPosition(300 + exw, 50 + PAGE_BTN_HEIGHT * 2 + PAGE_BTN_SPACING + (OPTS_ROW_H + PAGE_BTN_SPACING) * 3)

        sc2btnMoveUpBtn:setPosition(500 + exw, sc2btnMoveUpLabel.position.y)
        sc2btnMoveDownBtn:setPosition(500 + exw, sc2btnMoveDownLabel.position.y)
        sc2btnMoveLeftBtn:setPosition(500 + exw, sc2btnMoveLeftLabel.position.y)
        sc2btnMoveRightBtn:setPosition(500 + exw, sc2btnMoveRightLabel.position.y)
    elseif OptionsActive == 3 then
        local exw = (love.graphics.getWidth() - (300 * 2 + 200)) / 2
        sc3btnLangLabel:setPosition(300 + exw, 50 + PAGE_BTN_HEIGHT * 2 + PAGE_BTN_SPACING)

        sc3btnLangBtn:setPosition(500 + exw, sc3btnLangLabel.position.y)
    elseif OptionsActive == 4 then
        local exw = (love.graphics.getWidth() - (300 * 2 + 200)) / 2 - 20

        sc4btnVolLabel:setPosition(300 + exw, 50 + PAGE_BTN_HEIGHT * 2 + PAGE_BTN_SPACING)
        
        sc4btnVolDownBtn:setPosition(600 - 150 + exw, sc4btnVolLabel.position.y)
        sc4btnVolUpBtn:setPosition(700 - 50 + exw, sc4btnVolLabel.position.y)
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