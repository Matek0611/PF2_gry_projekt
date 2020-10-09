local Class = require("libs/basics/middleclass")
local Vector2d = require("libs/basics/Vector2d")
local globals = require("globals")

local Button = Class("Button")

local function mouseInPoint(self, mx, my)
    return mx >= self.position.x - self.width / 2 and mx <= self.position.x + self.width / 2 and my >= self.position.y - self.height / 2 and my <= self.position.y + self.height / 2
end

function Button:initialize(x, y, w, h, text)
    self.position = Vector2d(x or 0, y or 0)
    self.width = w
    self.height = h
    self.shadow = true
    self.text = text or ""
    self.rx = 10
    self.ry = 10
    self.visible = true
    self.enabled = true
    self.onClick = nil
    self.__state = "normal"
    
    self.colors = {
        face = {
            normal = gray(255, 1),
            hover = gray(200, 1),
            down = gray(170, 1),
            disabled = gray(150, 0.8)
        },
        font = {
            normal = gray(10, 1),
            hover = gray(10, 1),
            down = gray(10, 1),
            disabled = gray(0, 1)
        },
        shadow = {
            default = gray(0, 0.5)
        }
    }
end

function Button:setLeft(x)
    self.position.x = x + self.width / 2
end

function Button:setTop(y)
    self.position.y = y + self.width / 2
end

function Button:getState()
    return self.__state
end

function Button:draw()
    if not self.visible then return end

    local r, g, b, a = love.graphics.getColor()
    local oldf = love.graphics.getFont()
    local curc = {face=gray(1,1), font=gray(0,1)}
    local state = self.__state
    setFont("header", 20)
    local f = love.graphics.getFont()
    local _, lines = f:getWrap(self.text, self.width)
    local fh = f:getHeight()
    
    if state == "disabled" then
        curc.face = self.colors.face.disabled
        curc.font = self.colors.font.disabled
    elseif state == "normal" then
        curc.face = self.colors.face.normal
        curc.font = self.colors.font.normal
    elseif state == "hover" then
        curc.face = self.colors.face.hover
        curc.font = self.colors.font.hover
    elseif state == "down" then
        curc.face = self.colors.face.down
        curc.font = self.colors.font.down
    end

    love.graphics.setColor(curc.face)
    love.graphics.rectangle("fill", self.position.x - self.width / 2, self.position.y - self.height / 2, self.width, self.height, self.rx, self.ry)
    love.graphics.setColor(curc.font)
    love.graphics.printf(self.text, self.position.x - self.width / 2, self.position.y - fh / 2 * #lines, self.width, "center")

    love.graphics.setColor(r, g, b, a)
    love.graphics.setFont(oldf)
end

function Button:update(dt)
    if not self.visible then 
        self.__state = "invisible"
        return 
    end

    x, y = love.mouse.getPosition()
    local leftclick = love.mouse.isDown(1)
    local inb = mouseInPoint(self, x, y)
    
    if not self.enabled then
        self.__state = "disabled"
    elseif inb then
        if leftclick then
            self.__state = "down"
            if self.onClick ~= nil then
                self.onClick(self)
            end
        else
            self.__state = "hover"
        end  
    else 
        self.__state = "normal"
    end
end

return Button