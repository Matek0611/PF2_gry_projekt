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
local Button = require("libs/basics/Button")

local WholeWorld = Class("WholeWorld")

local BTN_WIDTH = 32
local btnMenu = Button:new(love.graphics.getWidth() / 2, 0, BTN_WIDTH, BTN_WIDTH, "...")

function WholeWorld:initialize(hero)
    self.world = lightworld:new()
    self.world.hero = hero
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
    
    btnMenu:draw()
end

function WholeWorld:update(dt)
    self.world:Update()
    self.levels[self.level]:update(dt)
    
    btnMenu:update(dt)
end

function WholeWorld:updateSize()
    self.world:Resize(love.graphics.getWidth(), love.graphics.getHeight())
    self.levels[self.level]:updateSize()
    
    btnMenu:setPosition(love.graphics.getWidth() - BTN_WIDTH / 2 - 5, love.graphics.getHeight() - BTN_WIDTH / 2 - 5)
end

return WholeWorld