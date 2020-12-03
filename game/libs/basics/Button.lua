local Class = require("libs/basics/middleclass")
local Vector2d = require("libs/basics/Vector2d")
local globals = require("globals")
local music = require("music")

local Button = Class("Button")

BTN_WHITE_THEME = {
    face = {
        normal = gray(255, 1),
        hover = gray(200, 1),
        down = gray(170, 1),
        disabled = gray(150, 0.8),
        check = gray(0, 1)
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

BTN_BLACK_THEME = {
    face = {
        normal = gray(50, 1),
        hover = gray(70, 1),
        down = gray(35, 1),
        disabled = gray(150, 0.8),
        check = gray(255, 1)
    },
    font = {
        normal = gray(255, 1),
        hover = gray(255, 1),
        down = gray(255, 1),
        disabled = gray(0, 1)
    },
    shadow = {
        default = gray(255, 0.5)
    }
}

BTN_WHITE_THEME_ACCENT = {
    face = {
        normal = gray(255, 1),
        hover = gray(200, 1),
        down = GAME_COLOR_ACCENT,
        disabled = gray(150, 0.8),
        check = gray(0, 1)
    },
    font = {
        normal = gray(10, 1),
        hover = gray(10, 1),
        down = gray(10, 1),
        disabled = gray(0, 1)
    },
    shadow = {
        default = GAME_COLOR_ACCENT
    }
}

BTN_BLACK_THEME_ACCENT = {
    face = {
        normal = gray(50, 1),
        hover = gray(70, 1),
        down = GAME_COLOR_ACCENT,
        disabled = gray(150, 0.8),
        check = gray(255, 1)
    },
    font = {
        normal = gray(255, 1),
        hover = gray(255, 1),
        down = gray(255, 1),
        disabled = gray(0, 1)
    },
    shadow = {
        default = GAME_COLOR_ACCENT
    }
}

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
    self.down = false
    self.candown = false
    self.colors = dup2tab(BTN_WHITE_THEME)
    self.fontname = "header"
    self.fontsize = 20
    self.checkbox = false
    self.textpos = "center"
    self.downeffect = true
    self.checked = false
    self.prevlclick = false
    self.clicksound = true
    self.static = false
end

function Button:toggle()
    self.down = not self.down
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
    setFont(self.fontname, self.fontsize)
    local f = love.graphics.getFont()
    local _, lines = f:getWrap(self.text, self.width - (self.checkbox and 35 or 0))
    local fh = f:getHeight()
    local EXHVAL = 1.5
    local exh = 0
    
    if state == "disabled" then
        curc.face = self.colors.face.disabled
        curc.font = self.colors.font.disabled
    elseif state == "normal" then
        curc.face = self.colors.face.normal
        curc.font = self.colors.font.normal
    elseif state == "hover" then
        curc.face = self.colors.face.hover
        curc.font = self.colors.font.hover
        exh = self.downeffect and EXHVAL or 0
    elseif state == "down" or self.checked then
        curc.face = self.colors.face.down
        curc.font = self.colors.font.down 
    end     

    love.graphics.setColor(curc.face)
    if self.checkbox then
        love.graphics.rectangle("fill", self.position.x - self.width / 2 + 1 + exh, self.position.y - 12 + exh, 24, 24, 5, 5)
        love.graphics.setColor(self.colors.face.check)
        if self.checked then 
            love.graphics.ellipse("fill", self.position.x - self.width / 2 + 1 + 12 + exh, self.position.y + exh, 5, 5) 
        end
    else
        if self.shadow then
            love.graphics.setColor(self.colors.shadow.default)
            love.graphics.rectangle("fill", self.position.x - self.width / 2 + EXHVAL, self.position.y - self.height / 2 + EXHVAL, self.width, self.height, self.rx, self.ry)
            love.graphics.setColor(curc.face)
        end
        love.graphics.rectangle("fill", self.position.x - self.width / 2 + exh, self.position.y - self.height / 2 + exh, self.width, self.height, self.rx, self.ry)
    end
    
    love.graphics.setColor(curc.font)
    love.graphics.printf(self.text, self.position.x - self.width / 2 + (self.checkbox and 35 or 0) + exh, self.position.y - fh / 2 * #lines + exh, self.width - (self.checkbox and 35 or 0), self.textpos)

    love.graphics.setColor(r, g, b, a)
    love.graphics.setFont(oldf)
end

function Button:update(dt)
    if not self.visible then 
        self.__state = "invisible"
        return 
    end

    local x, y = love.mouse.getPosition()
    local leftclick = love.mouse.isDown(1)
    local inb = mouseInPoint(self, x, y)
    
    if not self.enabled then
        self.__state = "disabled"
    elseif self.static then
        self.__state = "normal"
    elseif self.checkbox then 
        if inb and not leftclick and self.prevlclick then
            self.checked = not self.checked
            if self.onClick ~= nil then
                self.onClick(self)
            end
            self.__state = "hover"
        else
            self.__state = inb and "hover" or "normal"
        end
    elseif self.down then 
        self.__state = "down"
    elseif inb then   
        if leftclick and not self.candown then
            self.__state = "down" 
        elseif self.prevlclick and not leftclick then
            if self.onClick ~= nil then
                self.onClick(self)
            end
            if self.clicksound then
                ManageMusic:play("click")
            end
            self.__state = "hover"        
        else
            self.__state = "hover"
        end  
    else 
        self.__state = "normal"
    end

    self.prevlclick = leftclick
end

function Button:setPosition(x, y)
    self.position.x = x or 0
    self.position.y = y or 0
end

return Button