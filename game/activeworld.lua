local Class = require("libs/basics/middleclass")
local Button = require("libs/basics/Button")
local Scene = require("libs/basics/Scene")
local Scenes = require("libs/basics/Scenes")
local globals = require("globals")
local gamemode = require("gamemode")
local music = require("music")
local Hero = require("libs/objects/hero")
local herosdesc = require("libs/heros/herosdesc")
local hSieska = require("libs/heros/sieska")
local hMyniek = require("libs/heros/myniek")
local hAntywola = require("libs/heros/antywola")
local hPusia = require("libs/heros/pusia")
local translation = require("translation")
local world = require("world")

ActiveWorld = nil

btnMenu.onClick = (function (sender)
    GamePauseMenuScenes:setActive(2)
    ActiveWorld:stopTimer()
end)

