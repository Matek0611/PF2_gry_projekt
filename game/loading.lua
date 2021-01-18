local Class = require("libs/basics/middleclass")
local tween = require("libs/splashy/tween")
local globals = require("globals")

local Loading = Class("Loading")

local PARTICLES_1 = love.graphics.newParticleSystem(love.graphics.newImage("assets/img/particle1.png"), 1000)
PARTICLES_1:setParticleLifetime(1, 9)
PARTICLES_1:setEmissionRate(100)
PARTICLES_1:setSizes(0.7, 0.6, 0.5, 0.4, 0.3, 0.2, 0.1)
PARTICLES_1:setSizeVariation(0.2)
PARTICLES_1:setLinearAcceleration(10, 10, 55, -80)
PARTICLES_1:setColors(1, 1, 1, 1, 1, 1, 1, 0)
PARTICLES_1:setSpeed(0.1, 5)

__dot_count = 1
__dot_delay = 0
__hint_id = 1
__hint_delay = 0
__rot_delay = 0

local function randdots()
    if __dot_count > 2 then 
        __dot_count = 0
    else
        __dot_count = __dot_count + 1
    end

    local str = ""
    for x = 1, __dot_count do str = str .. "." end
    return str
end

function Loading:initialize()
    self.active = false
    self.data = {position=3, time=5, alpha=1}
    self.defpos = 3
    self.iscustompos = false
    self.custompos = 3
    self.stw = nil
    self.onFinish = nil
    self.onUpdate = nil
    self.dots = ""
    self.rotation = 0
    self:reset()
end

local gradient_bg = {} 
for i = 0, 10 do
    gradient_bg[i] = gradientMesh("vertical", gray(30, i / 10.0), color(35, 21, 0, i / 10.0))
end

local imgflame = love.graphics.newImage("assets/img/flame.png")
local imgload = love.graphics.newImage("assets/img/ladowanie.png")

function Loading:draw()
    if not self.active then return end

    local pc = getPrevColor()
    local pf = love.graphics.getFont()

    local al = 1
    if self.isClosing then
        al = self.data.alpha
    end

    love.graphics.draw(gradient_bg[math.round(al * 10)], 0, 0, 0, love.graphics.getDimensions())

    PARTICLES_1:setColors(al, al, al, al, al, al, al, 0)
    love.graphics.draw(PARTICLES_1, love.graphics.getWidth() / 2, love.graphics.getHeight())

    local col1 = color(255, 163, 22, al)
    love.graphics.setColor(col1)
    drawLargeLogo(love.graphics.getWidth() / 2, love.graphics.getHeight() / 3, false)

    local col2 = gray(200, al)
    love.graphics.setColor(col2)
    setFont("text", 18)
    love.graphics.printf(LoadingHints[__hint_id], (love.graphics.getWidth() - love.graphics.getWidth() / 3) / 2, love.graphics.getHeight() - love.graphics.getFont():getHeight()*4 - 15, love.graphics.getWidth() / 3, "center")

    love.graphics.draw(imgload, love.graphics.getWidth() - 300*0.2, love.graphics.getHeight() - 300*0.2, math.deg(self.rotation), 0.2, 0.2, 0.5*300, 0.5*300)

    if not self.isClosing then
        local ccc = getPrevColor()
        ccc[4] = self.flame_alpha
        love.graphics.setColor(ccc)
    end
    
    love.graphics.draw(imgflame, love.graphics.getWidth() - 300*0.2 - 0.125*121*0.5, love.graphics.getHeight() - 300*0.2 - 0.125*158*0.5, 0, 0.125, 0.125)

    love.graphics.setColor(pc)
    love.graphics.setFont(pf)
end

function Loading:update(dt)
    if not self.active then return end

    if self.data.position <= 0 then
        self.data.position = 0
        if self.stw == nil then
            self.isClosing = true 
            self.stw = tween.new(2.5, self.data, {alpha=0}, 'outSine')
        end
        self.stw:update(dt)
        if self.data.alpha > 0 then 
            self.isClosing = true
        else
            self.active = false
            if self.onFinish ~= nil then 
                self.onFinish(self)
            end
            self:reset() 
            self.isClosing = false
        end
    else
        if self.onUpdate ~= nil then 
            self.onUpdate(self)
        end

        self.data.position = self.data.position - love.math.random() / 70
        __dot_delay = (__dot_delay + 1) % 20
        if __dot_delay == 0 then
            self.dots = randdots()           
        end
        __hint_delay = (__hint_delay + 1) % 200
        if __hint_delay == 0 then 
            local hd = love.math.random(1, #LoadingHints)
            while hd == __hint_id do hd = love.math.random(1, #LoadingHints) end
            __hint_id = hd
        end

        __rot_delay = (__rot_delay + 1) % 3
        if __rot_delay == 0 then self.rotation = (self.rotation + 1) % 360 end

        if self.flame_grow then
            self.flame_alpha = self.flame_alpha + love.math.random() / 30
            if self.flame_alpha > 1 then 
                self.flame_alpha = 1
                self.flame_grow = false
            end
        else
            self.flame_alpha = self.flame_alpha - love.math.random() / 30
            if self.flame_alpha < 0 then 
                self.flame_alpha = 0
                self.flame_grow = true
            end
        end
    end

    PARTICLES_1:update(dt or 0)
end 

function Loading:reset()
    if self.iscustompos then
        self.defpos = self.custompos
    else
        self.defpos = love.math.random(5, 8)
    end
    self.data.position = self.defpos
    self.data.alpha = 1
    self.isClosing = false
    self.stw = nil
    self.flame_alpha = 1
    self.flame_grow = false
    self:updateSize()
end

function Loading:isLoading()
    return self.active
end

function Loading:setLoading(value)
    self.active = value or false
    self:reset()
end

function Loading:updateSize()
    PARTICLES_1:setEmissionArea("normal", love.graphics.getWidth() / 2, 10, 0, false)
end

LoadingScreen = Loading:new()

return Loading