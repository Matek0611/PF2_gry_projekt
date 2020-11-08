local Class = require("libs/basics/middleclass")
local tween = require("libs/splashy/tween")
local globals = require("globals")
local ptext = require("libs/floatingtext/effects/PopupText")
local ptextm = require("libs/floatingtext/effects/PopupTextManager")

local Loading = Class("Loading")

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
    self.dots = ""
    self.rotation = 0
    self:reset()
end

function Loading:setupeffects()
    self.ptextm = PopupTextManager()
    local pf = love.graphics.getFont()
    setFont("text", 20)
    -- self.ptextm:addPopup({
    --     text = "Example Text",
    --     font = love.graphics.getFont(),
    --     color = {r = 1, g = 0, b = 0, a = 1},
    --     x = 200,
    --     y = 200,
    --     scaleX = 4,
    --     scaleY = 4,
    --     circular = {totalAngle = math.pi, radiusX = 40, radiusY = 40},
    --     blendMode = 'add',
    --     fadeIn = {start = 0.2, finish = 0.7},
    --     fadeOut = {start = 0.7, finish = 8},
    --     dX = 40,
    --     dY = 40,
    --     duration = 8
    -- })
    love.graphics.setFont(pf)
end

function Loading:draw()
    if not self.active then return end

    local pc = getPrevColor()
    local pf = love.graphics.getFont()

    local al = 1
    if self.isClosing then
        al = self.data.alpha
    end

    love.graphics.setColor(gray(50, al))
    love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())

    local topp = love.graphics.getHeight() / 3.5
    love.graphics.setColor(gray(255, al))
    local fh = love.graphics.getFont():getHeight()
    setFont("header", 25)
    love.graphics.printf(LOADSCR_TEXT1 .. " " .. self.dots, 0, love.graphics.getHeight() - topp - 5 - fh, love.graphics.getWidth(), "center")
    fh = love.graphics.getFont():getHeight() + 35
    love.graphics.setColor(gray(200, al))
    setFont("text", 18)
    love.graphics.printf(LoadingHints[__hint_id], (love.graphics.getWidth() - love.graphics.getWidth() / 3) / 2, love.graphics.getHeight() - topp + fh + 20, love.graphics.getWidth() / 3, "center")

    -- love.graphics.setColor(gray(0, al))
    -- love.graphics.rectangle("fill", love.graphics.getWidth() / 3, love.graphics.getHeight() - topp + fh - 20, love.graphics.getWidth() / 3, 20, 10, 10)
    -- love.graphics.setColor(gray(255, al))
    -- love.graphics.rectangle("fill", love.graphics.getWidth() / 3 + 5, love.graphics.getHeight() - topp + fh - 20 + 5, (love.graphics.getWidth() / 3 - 5*2) * (1 - self.data.position / self.defpos), 20 - 5*2, 5, 5)

    drawLargeLogo(love.graphics.getWidth() / 2, love.graphics.getHeight() / 3, false)

    self.ptextm:render()

    local imgload = love.graphics.newImage("assets/img/ladowanie.png")
    love.graphics.draw(imgload, love.graphics.getWidth() - 300*0.2, love.graphics.getHeight() - 300*0.2, math.deg(self.rotation), 0.2, 0.2, 0.5*300, 0.5*300)

    if not self.isClosing then
        local ccc = getPrevColor()
        ccc[4] = self.flame_alpha
        love.graphics.setColor(ccc)
    end
    
    local imgflame = love.graphics.newImage("assets/img/flame.png")
    love.graphics.draw(imgflame, love.graphics.getWidth() - 300*0.2, love.graphics.getHeight() - 300*0.2 - 15, 0, 0.3, 0.3)

    love.graphics.setColor(pc)
    love.graphics.setFont(pf)
end

function Loading:update(dt)
    if not self.active then return end

    self.ptextm:update(dt)

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
                self.onFinish()
            end
            self:reset() 
            self.isClosing = false
        end
    else
        self.data.position = self.data.position - love.math.random() / 70
        __dot_delay = (__dot_delay + 1) % 20
        if __dot_delay == 0 then
            self.dots = randdots()           
        end
        __hint_delay = (__hint_delay + 1) % 250
        if __hint_delay == 0 then 
            local hd = love.math.random(1, #LoadingHints)
            while hd == __hint_id do hd = love.math.random(1, #LoadingHints) end
            __hint_id = hd
        end

        __rot_delay = (__rot_delay + 1) % 2
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
end 

function Loading:reset()
    if self.iscustompos then
        self.defpos = self.custompos
    else
        self.defpos = love.math.random(1, 4.5)
    end
    self.data.position = self.defpos
    self.data.alpha = 1
    self.isClosing = false
    self.stw = nil
    self.flame_alpha = 1
    self.flame_grow = false
    self:setupeffects()
end

function Loading:isLoading()
    return self.active
end

function Loading:setLoading(value)
    self.active = value
    self:reset()
end

LoadingScreen = Loading:new()

return Loading