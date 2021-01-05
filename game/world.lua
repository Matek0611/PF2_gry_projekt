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

local lbLevel = Button:new(love.graphics.getWidth() / 2, love.graphics.getHeight() - 5 - 45 / 2, 150, 45, TEXT_LEVEL_NAME)
lbLevel.static = true
lbLevel.fontname = "text"
lbLevel.shadow = false
lbLevel.rx = 10
lbLevel.ry = 10
lbLevel.colors = dup2tab(BTN_BLACK_THEME)

local lbTime = Button:new(15 + 300 / 2, love.graphics.getHeight() - 5 - 45 / 2, 300, 45, "00:00:00")
lbTime.static = true
lbTime.fontname = "text"
lbTime.shadow = false
lbTime.textpos = "left"
lbTime.colors = dup2tab(BTN_TRANSPARENT_THEME)

function WholeWorld:initialize(hero)
    self.world = lightworld:new()
    self.world.hero = hero
    self.level = 1
    self.timer = 0
    self.paused = true
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
    lbLevel:draw()
    lbTime:draw()
end

function WholeWorld:update(dt)
    self.world:Update()
    self.levels[self.level]:update(dt)

    if not self.paused then 
        self.timer = self.timer + (dt or 0)
        local sek = math.floor(self.timer) % 60
        local min = math.floor(math.floor(self.timer) / 60)
        local godz = math.floor(math.floor(self.timer) / 3600)
        lbTime.text = string.format("%02d:%02d:%02d", godz, min, sek)
        lbTime:update(dt)
    end
    
    btnMenu:update(dt)
    lbLevel.text = TEXT_LEVEL_NAME .. " " .. tostring(self.level)
    lbLevel:update(dt)
end

function WholeWorld:updateSize()
    self.world:Resize(love.graphics.getWidth(), love.graphics.getHeight())
    self.levels[self.level]:updateSize()

    local hl = self.world.hero.rectlimits
    hl.left = self.levels[self.level].left + self.levels[self.level].gridsize - 25
    hl.right = hl.left + 13 * self.levels[self.level].gridsize + 50
    hl.top = self.levels[self.level].top + self.levels[self.level].gridsize - 70
    hl.bottom = hl.top + 6 * self.levels[self.level].gridsize + 70
    
    btnMenu:setPosition(love.graphics.getWidth() - BTN_WIDTH / 2 - 5, love.graphics.getHeight() - BTN_WIDTH / 2 - 5)
    lbLevel:setPosition(love.graphics.getWidth() / 2, love.graphics.getHeight() - 5 - 45 / 2)
    lbTime:setPosition(15 + 300 / 2, love.graphics.getHeight() - 5 - 45 / 2)
end

function WholeWorld:keypressed(key, scancode, isrepeat)
    
end

function WholeWorld:resetTimer()
    self.timer = 0
end

function WholeWorld:startTimer()
    self:resetTimer()
    self.paused = false
end

function WholeWorld:stopTimer()
    self.paused = true
end

return WholeWorld