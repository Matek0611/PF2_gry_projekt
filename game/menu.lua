local Button = require("libs/basics/Button")
local globals = require("globals")
local Scenes = require("libs/basics/Scenes")
local Scene = require("libs/basics/Scene")
local options = require("options")
local newgame = require("newgame")
local translation = require("translation")

btnPlay, btnNewGame, btnStats, btnOpts, btnAbout, btnExit = nil, nil, nil, nil, nil 
MenuScenes = Scenes:new()
MenuScenes.drawAll = true

local PARTICLES_1 = love.graphics.newParticleSystem(love.graphics.newImage("assets/img/particle1.png"), 100)
PARTICLES_1:setParticleLifetime(1, 8)
PARTICLES_1:setEmissionRate(5)
PARTICLES_1:setSizes(1, 0.9, 0.8, 0.7, 0.6, 0.5, 0.4, 0.3)
PARTICLES_1:setSizeVariation(0.2)
PARTICLES_1:setLinearAcceleration(-50, -50, 50, 50)
PARTICLES_1:setColors(1, 1, 1, 1, 1, 1, 1, 0)
local PARTICLES_2 = love.graphics.newParticleSystem(love.graphics.newImage("assets/img/particle1.png"), 100)
PARTICLES_2:setParticleLifetime(1, 8)
PARTICLES_2:setEmissionRate(5)
PARTICLES_2:setSizes(1, 0.9, 0.8, 0.7, 0.6, 0.5, 0.4, 0.3)
PARTICLES_2:setSizeVariation(0.2)
PARTICLES_2:setLinearAcceleration(-50, -50, 50, 50)
PARTICLES_2:setColors(1, 1, 1, 1, 1, 1, 1, 0)
local PARTICLES_3 = love.graphics.newParticleSystem(love.graphics.newImage("assets/img/particle1.png"), 100)
PARTICLES_3:setParticleLifetime(1, 8)
PARTICLES_3:setEmissionRate(5)
PARTICLES_3:setSizes(1, 0.9, 0.8, 0.7, 0.6, 0.5, 0.4, 0.3)
PARTICLES_3:setSizeVariation(0.2)
PARTICLES_3:setLinearAcceleration(-50, -50, 50, 50)
PARTICLES_3:setColors(1, 1, 1, 1, 1, 1, 1, 0)
local PARTICLES_4 = love.graphics.newParticleSystem(love.graphics.newImage("assets/img/particle1.png"), 100)
PARTICLES_4:setParticleLifetime(1, 8)
PARTICLES_4:setEmissionRate(5)
PARTICLES_4:setSizes(1, 0.9, 0.8, 0.7, 0.6, 0.5, 0.4, 0.3)
PARTICLES_4:setSizeVariation(0.2)
PARTICLES_4:setLinearAcceleration(-50, -50, 50, 50)
PARTICLES_4:setColors(1, 1, 1, 1, 1, 1, 1, 0)
local PARTICLES_5 = love.graphics.newParticleSystem(love.graphics.newImage("assets/img/particle1.png"), 100)
PARTICLES_5:setParticleLifetime(1, 8)
PARTICLES_5:setEmissionRate(5)
PARTICLES_5:setSizes(1, 0.9, 0.8, 0.7, 0.6, 0.5, 0.4, 0.3)
PARTICLES_5:setSizeVariation(0.2)
PARTICLES_5:setLinearAcceleration(-50, -50, 50, 50)
PARTICLES_5:setColors(1, 1, 1, 1, 1, 1, 1, 0)

MENU_BG_COLOR = gray(30, 1)

local BTN_WIDTH, BTN_HEIGHT, BTN_TOPEX = 200, 50, 150

local function btnExitClick(sender)
    love.event.quit(0)
end

local function btnOptsClick(sender)
    MenuScenes:setActive(3)
end

local function btnOptsBackMenuClick(sender)
    MenuScenes:setActive(2)
end

local function btnNewGameClick(sender)
    MenuScenes:setActive(4)
end

local function btnStatsClick(sender)
    MenuScenes:setActive(6)
end

local function btnAboutClick(sender)
    MenuScenes:setActive(5)
end

local function buttonsInit()
    btnPlay = Button:new(love.graphics.getWidth() / 2, BTN_TOPEX+100, BTN_WIDTH, BTN_HEIGHT)
    btnPlay.enabled = false
    btnPlay.visible = false
    btnNewGame = Button:new(love.graphics.getWidth() / 2, BTN_TOPEX+160, BTN_WIDTH, BTN_HEIGHT)
    btnStats = Button:new(love.graphics.getWidth() / 2, BTN_TOPEX+220, BTN_WIDTH, BTN_HEIGHT)
    btnOpts = Button:new(love.graphics.getWidth() / 2, BTN_TOPEX+280, BTN_WIDTH, BTN_HEIGHT)
    btnAbout = Button:new(love.graphics.getWidth() / 2, BTN_TOPEX+340, BTN_WIDTH, BTN_HEIGHT)
    btnExit = Button:new(love.graphics.getWidth() / 2, BTN_TOPEX+400, BTN_WIDTH, BTN_HEIGHT)
    btnExit.onClick = btnExitClick
    btnOpts.onClick = btnOptsClick
    btnNewGame.onClick = btnNewGameClick
    btnStats.onClick = btnStatsClick
    btnAbout.onClick = btnAboutClick
    btnPlay.colors = BTN_WHITE_THEME_ACCENT
    btnNewGame.colors = BTN_WHITE_THEME_ACCENT
    btnStats.colors = BTN_WHITE_THEME_ACCENT
    btnOpts.colors = BTN_WHITE_THEME_ACCENT
    btnAbout.colors = BTN_WHITE_THEME_ACCENT
    btnExit.colors = BTN_WHITE_THEME_ACCENT
end

local function buttonsUpdate(dt)
    btnPlay:update(dt)
    btnNewGame:update(dt)
    btnStats:update(dt)
    btnOpts:update(dt)
    btnAbout:update(dt)
    btnExit:update(dt)
end

local function buttonsiUpdate()
    local left = love.graphics.getWidth() / 2
    btnPlay.position.x = left
    btnNewGame.position.x = left
    btnStats.position.x = left
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
    btnStats:draw()
    btnOpts:draw()
    btnAbout:draw()
    btnExit:draw()
end

local function bgDraw()
    love.graphics.setBackgroundColor(MENU_BG_COLOR)
end

local function menuHomeDraw()
    -- love.graphics.draw(PARTICLES_1, love.graphics.getWidth() * 0.5, BTN_TOPEX+100)
    love.graphics.draw(PARTICLES_2, love.graphics.getWidth() * 0.5, BTN_TOPEX+160)
    love.graphics.draw(PARTICLES_3, love.graphics.getWidth() * 0.5, BTN_TOPEX+220)
    love.graphics.draw(PARTICLES_4, love.graphics.getWidth() * 0.5, BTN_TOPEX+280)
    love.graphics.draw(PARTICLES_5, love.graphics.getWidth() * 0.5, BTN_TOPEX+340)

    drawLargeLogo(love.graphics.getWidth() / 2, 120, true)

    buttonsDraw()
end

local function menuHomeUpdate(dt)
    -- PARTICLES_1:update(dt or 0)
    PARTICLES_2:update(dt or 0)
    PARTICLES_3:update(dt or 0)
    PARTICLES_4:update(dt or 0)
    PARTICLES_5:update(dt or 0)
    buttonsUpdate(dt)
end

local function menuHomeiUpdate(dt)
    buttonsiUpdate(dt)
end

local btnReturn = Button:new(0, 0, 150, 50, OPTS_BTN_BACK)
btnReturn.onClick = (function(sender) 
    MenuScenes:setActive(2)
end)

local function menuAboutDraw()
    love.graphics.setColor(clWhite)
    love.graphics.rectangle("fill", 100, 80, love.graphics.getWidth() - 200, love.graphics.getHeight() - 200, 10, 10)
    
    love.graphics.setColor(clBlack)
    setFont("header", 35)
    love.graphics.printf(GAME_PRINT_NAME .. "  " .. GAME_VERSION, 110, 90, love.graphics.getWidth() - 220, "center")
    love.graphics.setColor(GAME_COLOR_ACCENT)

    setFont("header", 30)
    love.graphics.printf(TEXT_ABOUT_AUTHOR, 110, 90 + 35 + 30 + GlobalTextItemEffect.currenty, love.graphics.getWidth() - 220, "center")
    love.graphics.setColor(clBlack)
    setFont("text", 20)
    love.graphics.printf(GAME_AUTHOR, 110, 205, love.graphics.getWidth() - 220, "center")
    love.graphics.setColor(GAME_COLOR_ACCENT)

    setFont("header", 30)
    love.graphics.printf(TEXT_ABOUT_HELP, 110, 225 + GlobalTextItemEffect.currenty, love.graphics.getWidth() - 220, "center")
    love.graphics.setColor(clBlack)
    setFont("text", 20)
    love.graphics.printf(GAME_HELP, 110, 205 + 30*2 + 10, love.graphics.getWidth() - 220, "center")
    love.graphics.setColor(GAME_COLOR_ACCENT)

    setFont("header", 30)
    love.graphics.printf(TEXT_ABOUT_MUSIC, 110, 225 + 30 + 20*2 + GlobalTextItemEffect.currenty, love.graphics.getWidth() - 220, "center")
    love.graphics.setColor(clBlack)
    setFont("text", 20)
    love.graphics.printf(GAME_MUSIC, 110, 255 + 30*3, love.graphics.getWidth() - 220, "center")

    love.graphics.setColor(MENU_BG_COLOR)

    btnReturn:draw()
end

local function menuAboutUpdate(dt)
    btnReturn:update(dt)
end

local function menuAboutiUpdate()
    btnReturn:setPosition(love.graphics.getWidth() / 2, love.graphics.getHeight() - 50 - 10)
end

local function menuStatsDraw()
    local pc = getPrevColor()

    love.graphics.setColor(gray(255, 1))
    love.graphics.rectangle("fill", 100, 80, love.graphics.getWidth() - 200, love.graphics.getHeight() - 200, 10, 10)
    
    love.graphics.setColor(GAME_COLOR_ACCENT)
    setFont("header", 35)
    love.graphics.printf(TEXT_BTN_STATS, 110, 90 + GlobalTextItemEffect.currenty, love.graphics.getWidth() - 220, "center")

    love.graphics.setColor(clBlack)
    setFont("header", 30)
    local sek = math.floor(GLOBAL_OPTIONS.BEST_TIME) % 60
    local min = math.floor(math.floor(GLOBAL_OPTIONS.BEST_TIME) / 60)
    local godz = math.floor(math.floor(GLOBAL_OPTIONS.BEST_TIME) / 3600)
    love.graphics.printf(STATS_TIME .. " - " .. string.format("%02d:%02d:%02d", godz, min, sek), 110, 90 + 35 + 30, love.graphics.getWidth() - 220, "center")

    love.graphics.setColor(pc)

    btnReturn:draw()
end

local function menuStatsUpdate(dt)
    btnReturn:update(dt)
end

local function menuStatsiUpdate()
    btnReturn:setPosition(love.graphics.getWidth() / 2, love.graphics.getHeight() - 50 - 10)
end

function menuInit()
    local sc = Scene:new("home", menuHomeDraw, menuHomeUpdate, menuHomeiUpdate)
    -- sc.canDrawAll = true
    MenuScenes:addScene(sc)

    MenuScenes:addScene(OptionsScene)

    MenuScenes:addScene(NewGameScene)

    sc = Scene:new("about", menuAboutDraw, menuAboutUpdate, menuAboutiUpdate)
    MenuScenes:addScene(sc)

    sc = Scene:new("stats", menuStatsDraw, menuStatsUpdate, menuStatsiUpdate)
    MenuScenes:addScene(sc)

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

GamePauseMenuScenes = Scenes:new()
GamePauseMenuScenes.drawAll = true

TEXT_PAUSED = "Pauza"
TEXT_PAUSED_CONTINUE = "Kontunnuj"
TEXT_PAUSED_LOSE = "Przegraj"

btnPContinue = Button:new(love.graphics.getWidth() / 2, BTN_TOPEX+160, BTN_WIDTH, BTN_HEIGHT)
btnPOptions = Button:new(love.graphics.getWidth() / 2, BTN_TOPEX+220, BTN_WIDTH, BTN_HEIGHT)
btnPOptions.onClick = (function (sender)
    GamePauseMenuScenes:setActive(3)
    btnOptsBack.onClick = (function()
        GamePauseMenuScenes:setActive(2)
        btnOptsBack.onClick = btnOptsBackMenuClick
    end)
end)
btnPLose = Button:new(love.graphics.getWidth() / 2, BTN_TOPEX+280, BTN_WIDTH, BTN_HEIGHT)

btnPContinue.onClick = (function (sender)
    GamePauseMenuScenes:setActive(1)
    ActiveWorld:resumeTimer()
end)

btnPLose.onClick = (function (sender)
    ActiveWorld:stopTimer()
    -- GLOBAL_OPTIONS.BEST_TIME = math.max(ActiveWorld.timer, GLOBAL_OPTIONS.BEST_TIME)
    ActiveWorld = nil
    ManageMusic:play("menu")
    LoadingScreen.onFinish = (function (sender) 
        GamePauseMenuScenes:setActive(1)
        MenuScenes:setActive(2)
        gm = GM_MENU
    end)
    LoadingScreen:setLoading(true)
end)

PauseScene = Scene:new("paused", (function () 
    love.graphics.setColor(gray(127, 0.5))
    love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())

    love.graphics.setColor(GAME_COLOR_ACCENT)
    setFont("header", 50)
    love.graphics.printf(TEXT_PAUSED, 0, 100, love.graphics.getWidth(), "center")

    btnPContinue:draw()
    btnPOptions:draw()
    btnPLose:draw()
end),
(function (dt)
    btnPContinue:update(dt)
    btnPOptions:update(dt)
    btnPLose:update(dt)
end),
(function ()
    local left = love.graphics.getWidth() / 2
    btnPContinue.position.x = left
    btnPOptions.position.x = left
    btnPLose.position.x = left
end))

btnEGame = Button:new(love.graphics.getWidth() / 2, BTN_TOPEX+160, BTN_WIDTH*2, BTN_HEIGHT)
btnEGame.onClick = (function (sender) 
    ActiveWorld:stopTimer()
    ActiveWorld = nil
    ManageMusic:play("menu")
    LoadingScreen.onFinish = (function (sender) 
        GamePauseMenuScenes:setActive(1)
        MenuScenes:setActive(2)
        gm = GM_MENU
    end)
    LoadingScreen:setLoading(true)
end)

GameEndScene = Scene:new("game_end", (function () 
    local pc = getPrevColor()

    love.graphics.setColor(color(85, 0, 38))
    love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
    
    love.graphics.setColor(GAME_COLOR_ACCENT)
    setFont("header", 50)
    love.graphics.printf(TEXT_END, 0, 100, love.graphics.getWidth(), "center")
    btnEGame:draw()

    love.graphics.setColor(pc)
end),
(function (dt) 
    btnEGame:update(dt)
end),
(function () 
    local left = love.graphics.getWidth() / 2
    btnEGame.position.x = left
end))

function pausemenuInit()
    PauseScene.canDrawAll = true
    GamePauseMenuScenes:addScene(PauseScene)

    GamePauseMenuScenes:addScene(OptionsScene)

    GamePauseMenuScenes:addScene(GameEndScene)

    GamePauseMenuScenes:setActive(1)
end

pausemenuInit()

function menuTranslate()
    btnPlay.text = TEXT_BTN_CONTINUE
    btnNewGame.text = TEXT_BTN_NEWGAME
    btnStats.text = TEXT_BTN_STATS
    btnOpts.text = TEXT_BTN_OPTS
    btnAbout.text = TEXT_BTN_ABOUT
    btnExit.text = TEXT_BTN_EXIT

    btnPContinue.text = TEXT_PAUSED_CONTINUE
    btnPOptions.text = TEXT_BTN_OPTS
    btnPLose.text = TEXT_PAUSED_LOSE

    btnEGame.text = TEXT_END_BTN
end