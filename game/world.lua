local Class = require("libs/basics/middleclass")
local globals = require("globals")
local gamemode = require("gamemode")
local translation = require("translation")
local loading = require("loading")
local options = require("options")
local music = require("music")
local shadows = require("libs/shadows")
local lightworld = require("libs/shadows.lightworld")
local Level = require("level")

local WholeWorld = Class("WholeWorld")

function WholeWorld:initialize()
    self.hero = nil
    self.world = lightworld:new()
    self.level = 1
    self:generateLevels()
end

function WholeWorld:generateLevels()
    self.levels = {}
    for i = 1, 10 do 
        self.levels[#self.levels + 1] = Level:new(i, self.world)
    end
end

function WholeWorld:draw()
    self.levels[self.level]:draw()
end

function WholeWorld:update(dt)
    self.world:Update()
    self.levels[self.level]:update(dt)
end

function WholeWorld:updateSize()
    self.world:Resize(love.graphics.getWidth(), love.graphics.getHeight())
    self.levels[self.level]:updateSize()
end

ActiveWorld = nil

return WholeWorld