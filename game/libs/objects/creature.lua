local Class = require("libs/basics/middleclass")
local BasicObject = require("libs/objects/basicobject")

local Creature = Class("Creature", BasicObject)

function Creature:initialize(defname, defdescription)
    BasicObject.initialize(self, "")
    self.name = ""
    self.description = ""
    self.deftxt = {n = defname or "", d = defdescription or ""}
    self.onUpdateStrings = nil
    
    self.onDraw = nil
    self.onUpdate = nil

    self.life = 1
    self.speed = 1
    self.bullets = 1
    self.bullets_shape = "round"
    self.bullets_color = nil
    self.damage = 0.5
    self.fly = false
    self.canmove = true
end

function Creature:draw()
    if self.onDraw ~= nil then 
        self.onDraw()
    end
end

function Creature:update(dt)
    if self.onUpdate ~= nil then
        self.onUpdate(dt)
    end
    if self.onUpdateStrings ~= nil then
        if self.name ~= self.deftxt.n or self.description ~= self.deftxt.d then
            local str = self.onUpdateStrings(n, d)
            self.name = str[1] or ""
            self.description = str[2] or ""
            self.deftxt = {n = str[1] or "", d = str[2] or ""}
        end
    end
end

return Creature
