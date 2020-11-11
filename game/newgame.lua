local Class = require("libs/basics/middleclass")
local Button = require("libs/basics/Button")
local Scene = require("libs/basics/Scene")
local Scenes = require("libs/basics/Scenes")
local globals = require("globals")
local gamemode = require("gamemode")
local Hero = require("libs/objects/hero")
local herosdesc = require("libs/heros/herosdesc")
local hSieska = require("libs/heros/sieska")

local wSieska = hSieska:new()
wSieska.canmove = false

local aktywna = wSieska

local btnReturn = Button:new(0, 0, 150, 50, OPTS_BTN_BACK)
btnReturn.onClick = (function(sender) 
    MenuScenes:setActive(2)
end)

local function NewGameSceneDraw()
    love.graphics.draw(gradientMesh("vertical", gray(100, 1), gray(20, 1)), 0, 0, 0, love.graphics.getDimensions())

    btnReturn:draw()

    aktywna:drawHearts(50, 50)
end

local function NewGameSceneUpdate(dt)
    btnReturn:update(dt)

    aktywna:update(dt)
end

local function NewGameSceneiUpdate()
    btnReturn:setPosition(love.graphics.getWidth() - 75 - 30, love.graphics.getHeight() - 50 - 10)
end

NewGameScene = Scene:new("newgame", NewGameSceneDraw, NewGameSceneUpdate, NewGameSceneiUpdate)

