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
local ItemEffect = require("libs/basics/ItemEffect")

local WholeWorld = Class("WholeWorld")

local BTN_WIDTH = 32 
btnMenu = Button:new(love.graphics.getWidth() / 2, 0, BTN_WIDTH, BTN_WIDTH, "...")

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

PORTALEFFECT_DS = 0.1
PortalEffect = ItemEffect:new(0, 0, 0, 0, 0, 1)
PortalEffect.ds = PORTALEFFECT_DS

function WholeWorld:initialize(hero)
    self.world = lightworld:new()
    self.world.hero = hero
    self.level = 1
    self.timer = 0
    self.paused = true
    self:generateLevels()

    bgEffect.fog.fog_color = self.levels[self.level].effectcolor

    self.next = false
    self.back = false
    self.finished = false
end

function WholeWorld:generateLevels()
    self.levels = {}
    for i = 1, 10 do 
        self.levels[#self.levels + 1] = Level:new(i, self.world, self)
    end
end

function WholeWorld:draw()
    if self.finished then
        local pc = getPrevColor()
        GamePauseMenuScenes:draw()
        love.graphics.setColor(pc) 
        return 
    end

    if self.paused and not (self.next or self.back) then 
        levelBlur.draw(function () 
            self.levels[self.level]:draw()
        end)
    else
        self.levels[self.level]:draw()
    end
    
    if not (self.next or self.back) then btnMenu:draw() end
    lbLevel:draw()
    lbTime:draw()

    if self.next or self.back then 
        local pc = getPrevColor()
        love.graphics.setColor(portal_colors[1])
        love.graphics.ellipse("fill", love.graphics.getWidth() / 2, love.graphics.getHeight() / 2, love.graphics.getWidth() / 2 * (PortalEffect.currentscale), love.graphics.getWidth() / 2 * (PortalEffect.currentscale))
        love.graphics.setColor(pc) 
    end

    if (GamePauseMenuScenes.active > 1) then 
        local pc = getPrevColor()
        GamePauseMenuScenes:draw()
        love.graphics.setColor(pc) 
    end
end

function WholeWorld:update(dt)
    if self.next or self.back then 
        self:updateSize()
    end

    if not self.paused then  
        self.world:Update()
        self.levels[self.level]:update(dt)

        self.timer = self.timer + (dt or 0)
        local sek = math.floor(self.timer) % 60
        local min = math.floor(math.floor(self.timer) / 60)
        local godz = math.floor(math.floor(self.timer) / 3600)
        lbTime.text = string.format("%02d:%02d:%02d", godz, min, sek)
        lbTime:update(dt)
    end

    if PortalEffect.active then PortalEffect:update(dt) end

    if self.next and PortalEffect.currentscale > 1 then
        self.next = false
        PortalEffect:stop()
        if self.level == 10 then
            self.finished = true
            self:stopTimer()
            
            GamePauseMenuScenes:setActive(4)
        else
            self.level = self.level + 1
            if self.level == 3 then 
                ManageMusic:play("level3")
            elseif self.level == 5 then
                ManageMusic:play("level5")
            elseif self.level == 7 then
                ManageMusic:play("level7")
            elseif self.level == 9 then
                ManageMusic:play("level9")
            end
            bgEffect.fog.fog_color = self.levels[self.level].effectcolor
            self.levels[self.level]:setHeroPosition("center")
            self.back = true
            PortalEffect:start()
        end
    end
    if self.back and PortalEffect.currentscale < 0 then 
        self.back = false
        PortalEffect.currentscale = 0
        PortalEffect:stop()
        self:resumeTimer()
    end
    
    if not (self.next or self.back or self.paused) then btnMenu:update(dt) end
    lbLevel.text = TEXT_LEVEL_NAME .. " " .. tostring(self.level)
    lbLevel:update(dt)

    if (GamePauseMenuScenes.active > 1) then GamePauseMenuScenes:update(dt) end
end

function WholeWorld:updateSize()
    self.world:Resize(love.graphics.getWidth(), love.graphics.getHeight())
    self.levels[self.level]:updateSize()

    levelBlur.resize(self.world.Width, self.world.Height)

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
    if self.finished then return end

    if key == "escape" then
        if self.paused then
            btnPContinue.onClick(btnPContinue)
        else
            btnMenu.onClick(btnMenu)
        end
    end
end

function WholeWorld:resetTimer()
    self.timer = 0
end

function WholeWorld:startTimer()
    self:resetTimer()
    self.paused = false
end

function WholeWorld:resumeTimer()
    self.paused = false
end

function WholeWorld:stopTimer()
    self.paused = true
end

function WholeWorld:nextLevel()
    PortalEffect.minscale = 0
    PortalEffect.maxscale = 1
    PortalEffect.currentscale = 0
    self:stopTimer()
    self.next = true
    PortalEffect:start()
end

return WholeWorld