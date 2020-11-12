local Class = require("libs/basics/middleclass")
local Button = require("libs/basics/Button")
local Scene = require("libs/basics/Scene")
local Scenes = require("libs/basics/Scenes")
local globals = require("globals")
local gamemode = require("gamemode")
local Hero = require("libs/objects/hero")
local herosdesc = require("libs/heros/herosdesc")
local hSieska = require("libs/heros/sieska")

TEXT_NEWGAME_TITLE = "Rozpocznij nową ucieczkę"
TEXT_NEWGAME_HEADER = "Z którym bohaterem zaczniesz dziś nową ucieczkę?"

local wSieska = hSieska:new()
wSieska.canmove = false

local aktywna = wSieska

local btnReturn = Button:new(0, 0, 50, 50, "<")
btnReturn.rx, btnReturn.ry = 25, 25
btnReturn.fontname = "text"
btnReturn.onClick = (function(sender) 
    MenuScenes:setActive(2)
end)

local btnStart = Button:new(0, 0, 320, 100, TEXT_NEWGAME_TITLE)
btnStart.rx, btnStart.ry = 50, 50
btnStart.colors = dup2tab(BTN_WHITE_THEME_ACCENT)
btnStart.colors.font = {
    normal = GAME_COLOR_ACCENT,
    hover = GAME_COLOR_ACCENT,
    down = gray(255, 1),
    disabled = gray(0, 1)
}
btnStart.onClick = (function(sender) 

end)

local PARTICLES_1 = love.graphics.newParticleSystem(love.graphics.newImage("assets/img/particle1.png"), 100)
PARTICLES_1:setParticleLifetime(1, 8)
PARTICLES_1:setEmissionRate(5)
PARTICLES_1:setSizeVariation(1)
PARTICLES_1:setLinearAcceleration(-50, -50, 50, 50)
PARTICLES_1:setColors(1, 1, 1, 1, 1, 1, 1, 0)

local function NewGameSceneDraw()
    love.graphics.draw(gradientMesh("vertical", gray(100, 1), gray(20, 1)), 0, 0, 0, love.graphics.getDimensions())

    love.graphics.draw(PARTICLES_1, love.graphics.getWidth() * 0.5, love.graphics.getHeight() - 100 - 10)

    local pc = getPrevColor()

    love.graphics.setColor(GAME_COLOR_ACCENT)
    setFont("header", 35)
    love.graphics.printf(TEXT_NEWGAME_HEADER, 0, 15, love.graphics.getWidth(), "center")

    love.graphics.setColor(pc)

    aktywna:drawHearts(love.graphics.getWidth() / 2 + 15, love.graphics.getHeight() / 2)

    btnReturn:draw()
    btnStart:draw()
end

local function NewGameSceneUpdate(dt)
    btnReturn:update(dt)
    btnStart:update(dt)
    PARTICLES_1:update(dt or 0)

    aktywna:update(dt)
end

local function NewGameSceneiUpdate()
    btnReturn:setPosition(45, love.graphics.getHeight() / 2)
    btnStart:setPosition(love.graphics.getWidth() / 2, love.graphics.getHeight() - 110 + GlobalTextItemEffect.currenty)
end

NewGameScene = Scene:new("newgame", NewGameSceneDraw, NewGameSceneUpdate, NewGameSceneiUpdate)

