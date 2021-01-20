local Class = require("libs/basics/middleclass")
local BasicObject = require("libs/objects/basicobject")

local Creature = Class("Creature", BasicObject)

function Creature:initialize(defname, defdescription)
    BasicObject.initialize(self, "")
    self.name = ""
    self.strings = {NAME = "", DESC = ""}
    
    self.onDraw = nil
    self.onUpdate = nil

    self.body = nil

    self.life = 1
    self.speed = 1.5
    self.basespeed = 3.5
    self.bullets = 1
    self.bullets_shape = "round"
    self.bullets_color = nil
    self.damage = 0.5
    self.fly = false
    self.canmove = true
    self.direction = "s"
    self.ismoving = false
    self.position = {x = 0, y = 0}
    self.scalefrom = 100
    self.scaleto = 100
    self.getscale = (function () return self.scalefrom / self.scaleto end)
    self.rectlimits = {left = 0, top = 0, right = 100, bottom = 100}
end

function Creature:draw()
    if self.onDraw ~= nil then 
        self.onDraw()
    end
end

function Creature:update(dt)
    self:updateEx(dt)
    if self.onUpdate ~= nil then
        self.onUpdate(dt)
    end
end

function Creature:updateEx(dt)

end

function Creature:setCenterPosition(x, y)
    self.position.x = (x or 0) - self.scalefrom / 2
    self.position.y = (y or 0) - self.scalefrom / 2
end

function Creature:setPosition(x, y)
    self.position.x = (x or self.position.x)
    self.position.y = (y or self.position.y)
end

function Creature:move(where)
    local ds = self.speed * self.basespeed * self.getscale()
    
    self.ismoving = true

    if where == "up" then
        if self.position.y - ds < self.rectlimits.top then 
            self.position.y = self.rectlimits.top
        else
            self.position.y = self.position.y - ds
        end
    elseif where == "down" then
        if self.position.y + ds > self.rectlimits.bottom then 
            self.position.y = self.rectlimits.bottom
        else
            self.position.y = self.position.y + ds
        end
    elseif where == "left" then
        if self.position.x - ds < self.rectlimits.left then 
            self.position.x = self.rectlimits.left
        else
            self.position.x = self.position.x - ds
        end
    elseif where == "right" then
        if self.position.x + ds > self.rectlimits.right then 
            self.position.x = self.rectlimits.right
        else
            self.position.x = self.position.x + ds
        end
    end
end

return Creature
