local BasicObject = require("libs/objects/basicobject")

local Creature = BasicObject()

function Creature:initialize(defname, defdescription)
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
            self.onUpdateStrings(n, d)
            self.name = n or ""
            self.description = d or ""
            self.deftxt = {n = n or "", d = d or ""}
        end
    end
end

return Creature
