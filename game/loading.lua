local Class = require("libs/basics/middleclass")
local tween = require("libs/splashy/tween")
local globals = require("globals")

local Loading = Class("Loading")

__dot_count = 1
__dot_delay = 0
__hint_id = 1
__hint_delay = 0
LOADING_BG_COLOR = color(30, 1)

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
    self.data = {position=3, time=5}
    self.defpos = 3
    self.iscustompos = false
    self.custompos = 3
    self.stw = nil
    self.onFinish = nil
    self.dots = ""
    self:reset()
end

function Loading:draw()
    if not self.active then return end

    local pc = getPrevColor()
    local pf = love.graphics.getFont()

    love.graphics.setColor(LOADING_BG_COLOR)
    love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())

    local topp = love.graphics.getHeight() / 3.5
    love.graphics.setColor(color(255, 1))
    local fh = love.graphics.getFont():getHeight()
    setFont("header", 25)
    love.graphics.printf(LOADSCR_TEXT1 .. " " .. self.dots, 0, love.graphics.getHeight() - topp - 5 - fh, love.graphics.getWidth(), "center")
    fh = love.graphics.getFont():getHeight() + 35
    love.graphics.setColor(color(200, 1))
    setFont("text", 18)
    love.graphics.printf(LoadingHints[__hint_id], (love.graphics.getWidth() - love.graphics.getWidth() / 3) / 2, love.graphics.getHeight() - topp + fh + 20, love.graphics.getWidth() / 3, "center")

    love.graphics.setColor(color(0, 1))
    love.graphics.rectangle("fill", love.graphics.getWidth() / 3, love.graphics.getHeight() - topp + fh - 20, love.graphics.getWidth() / 3, 20, 10, 10)
    love.graphics.setColor(color(255, 0.2))
    love.graphics.rectangle("fill", love.graphics.getWidth() / 3 + 5, love.graphics.getHeight() - topp + fh - 20 + 5, (love.graphics.getWidth() / 3 - 5*2) * (1 - self.data.position / self.defpos), 20 - 5*2, 5, 5)

    drawLargeLogo(love.graphics.getWidth() / 2, love.graphics.getHeight() / 3)

    love.graphics.setColor(pc)
    love.graphics.setFont(pf)

    local img = love.graphics.newImage("assets/img/flame.png")
    love.graphics.draw(img, love.graphics.getWidth() - 45, love.graphics.getHeight() - 50, 0, 0.2, 0.2)
end

function Loading:update(dt)
    if not self.active then return end

    if self.data.position <= 0 then 
        self.active = false
        if self.onFinish ~= nil then 
            self.onFinish()
        end
        self:reset()
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
    end
end 

function Loading:reset()
    if self.iscustompos then
        self.defpos = self.custompos
    else
        self.defpos = love.math.random(1, 4.5)
    end
    self.data.position = self.defpos
    self.stw = nil
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