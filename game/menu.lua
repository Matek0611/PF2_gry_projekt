local Button = require("libs/basics/Button")
local globals = require("globals")
local Scenes = require("libs/basics/Scenes")
local Scene = require("libs/basics/Scene")
local options = require("options")
local newgame = require("newgame")

btnPlay, btnNewGame, btnOpts, btnAbout, btnExit = nil, nil, nil, nil, nil 
MenuScenes = Scenes:new()
MenuScenes.drawAll = true

local PARTICLES_1 = love.graphics.newParticleSystem(love.graphics.newImage("assets/img/particle1.png"), 100)
PARTICLES_1:setParticleLifetime(1, 8)
PARTICLES_1:setEmissionRate(5)
PARTICLES_1:setSizeVariation(1)
PARTICLES_1:setLinearAcceleration(-50, -50, 50, 50)
PARTICLES_1:setColors(1, 1, 1, 1, 1, 1, 1, 0)
local PARTICLES_2 = love.graphics.newParticleSystem(love.graphics.newImage("assets/img/particle1.png"), 100)
PARTICLES_2:setParticleLifetime(1, 8)
PARTICLES_2:setEmissionRate(5)
PARTICLES_2:setSizeVariation(1)
PARTICLES_2:setLinearAcceleration(-50, -50, 50, 50)
PARTICLES_2:setColors(1, 1, 1, 1, 1, 1, 1, 0)
local PARTICLES_3 = love.graphics.newParticleSystem(love.graphics.newImage("assets/img/particle1.png"), 100)
PARTICLES_3:setParticleLifetime(1, 8)
PARTICLES_3:setEmissionRate(5)
PARTICLES_3:setSizeVariation(1)
PARTICLES_3:setLinearAcceleration(-50, -50, 50, 50)
PARTICLES_3:setColors(1, 1, 1, 1, 1, 1, 1, 0)
local PARTICLES_4 = love.graphics.newParticleSystem(love.graphics.newImage("assets/img/particle1.png"), 100)
PARTICLES_4:setParticleLifetime(1, 8)
PARTICLES_4:setEmissionRate(5)
PARTICLES_4:setSizeVariation(1)
PARTICLES_4:setLinearAcceleration(-50, -50, 50, 50)
PARTICLES_4:setColors(1, 1, 1, 1, 1, 1, 1, 0)
local PARTICLES_5 = love.graphics.newParticleSystem(love.graphics.newImage("assets/img/particle1.png"), 100)
PARTICLES_5:setParticleLifetime(1, 8)
PARTICLES_5:setEmissionRate(5)
PARTICLES_5:setSizeVariation(1)
PARTICLES_5:setLinearAcceleration(-50, -50, 50, 50)
PARTICLES_5:setColors(1, 1, 1, 1, 1, 1, 1, 0)

TEXT_BTN_CONTINUE = "Kontynuuj"
TEXT_BTN_NEWGAME = "Nowa ucieczka"
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

local function btnNewGameClick(sender)
    MenuScenes:setActive(4)
end

local function btnAboutClick(sender)
    MenuScenes:setActive(5)
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
    btnNewGame.onClick = btnNewGameClick
    btnAbout.onClick = btnAboutClick
    btnPlay.colors = BTN_WHITE_THEME_ACCENT
    btnNewGame.colors = BTN_WHITE_THEME_ACCENT
    btnOpts.colors = BTN_WHITE_THEME_ACCENT
    btnAbout.colors = BTN_WHITE_THEME_ACCENT
    btnExit.colors = BTN_WHITE_THEME_ACCENT
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
    love.graphics.draw(PARTICLES_1, love.graphics.getWidth() * 0.5, BTN_TOPEX+100)
    love.graphics.draw(PARTICLES_2, love.graphics.getWidth() * 0.5, BTN_TOPEX+160)
    love.graphics.draw(PARTICLES_3, love.graphics.getWidth() * 0.5, BTN_TOPEX+220)
    love.graphics.draw(PARTICLES_4, love.graphics.getWidth() * 0.5, BTN_TOPEX+280)
    love.graphics.draw(PARTICLES_5, love.graphics.getWidth() * 0.5, BTN_TOPEX+340)

    drawLargeLogo(love.graphics.getWidth() / 2, 120, true)

    buttonsDraw()
end

local function menuHomeUpdate(dt)
    PARTICLES_1:update(dt or 0)
    PARTICLES_2:update(dt or 0)
    PARTICLES_3:update(dt or 0)
    PARTICLES_4:update(dt or 0)
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
    love.graphics.setColor(gray(255, 1))
    love.graphics.rectangle("fill", 100, 80, love.graphics.getWidth() - 200, love.graphics.getHeight() - 200, 10, 10)
    
    love.graphics.setColor(gray(0, 1))
    setFont("header", 35)
    love.graphics.printf(GAME_PRINT_NAME .. "  " .. GAME_VERSION, 110, 90, love.graphics.getWidth() - 220, "center")
    love.graphics.setColor(GAME_COLOR_ACCENT)
    setFont("header", 30)
    love.graphics.printf(TEXT_ABOUT_AUTHOR, 110, 90 + 35 + 30, love.graphics.getWidth() - 220, "center")
    love.graphics.setColor(gray(0, 1))
    setFont("text", 20)
    love.graphics.printf(GAME_AUTHOR, 110, 205, love.graphics.getWidth() - 220, "center")
    love.graphics.setColor(GAME_COLOR_ACCENT)
    setFont("header", 30)
    love.graphics.printf(TEXT_ABOUT_MUSIC, 110, 225 + 30, love.graphics.getWidth() - 220, "center")
    love.graphics.setColor(gray(0, 1))
    setFont("text", 20)
    love.graphics.printf(GAME_MUSIC, 110, 255 + 30*2, love.graphics.getWidth() - 220, "center")

    love.graphics.setColor(MENU_BG_COLOR)

    btnReturn:draw()
end

local function menuAboutUpdate(dt)
    btnReturn:update(dt)
end

local function menuAboutiUpdate()
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