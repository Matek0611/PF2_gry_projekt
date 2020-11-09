local Class = require("libs/basics/middleclass")
local Button = require("libs/basics/Button")
local Scene = require("libs/basics/Scene")
local Scenes = require("libs/basics/Scenes")
local globals = require("globals")
local gamemode = require("gamemode")
local hSieska = require("libs/heros/sieska")

local wSieska = hSieska:new()
wSieska.canmove = false

local aktywna = wSieska

local btnReturn = Button:new(0, 0, 150, 50, OPTS_BTN_BACK)
btnReturn.onClick = (function(sender) 
    MenuScenes:setActive(2)
end)

local function NewGameSceneDraw()
    btnReturn:draw()
end

local function NewGameSceneUpdate()
    btnReturn:update(dt)
end

local function NewGameSceneiUpdate()
    btnReturn:setPosition(love.graphics.getWidth() - 75 - 30, love.graphics.getHeight() - 50 - 10)
end

NewGameScene = Scene:new("newgame", NewGameSceneDraw, NewGameSceneUpdate, NewGameSceneiUpdate)

