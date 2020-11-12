local Class = require("libs/basics/middleclass")

local ItemEffect = Class("ItemEffect")

local time = 0.1

function ItemEffect:initialize(minx, maxx, miny, maxy, minscale, maxscale)
    self.minx = math.min(minx or 0, maxx or 0)
    self.maxx = math.max(minx or 0, maxx or 0)
    self.miny = math.min(miny or 0, maxy or 0)
    self.maxy = math.max(miny or 0, maxy or 0)
    self.minscale = math.min(minscale or 0, maxscale or 0)
    self.maxscale = math.max(minscale or 0, maxscale or 0)
    self.currentx = self.minx
    self.currenty = self.miny
    self.currentscale = self.minscale
    self.dx = 1
    self.dy = 1
    self.ds = 1
    self.time = time
    self.active = false
end

function ItemEffect:update(dt)
    if not self.active then return end

    self.time = self.time - (dt or 0)
    if self.time < 0 then 
        self.time = time

        if (self.currentx > self.maxx) or (self.currentx < self.minx) then self.dx = -self.dx end
        self.currentx = self.currentx + self.dx * 1

        if (self.currenty > self.maxy) or (self.currenty < self.miny) then self.dy = -self.dy end
        self.currenty = self.currenty + self.dy * 1

        if (self.currentscale > self.maxscale) or (self.currentscale < self.minscale) then self.ds = -self.ds end
        self.currentscale = self.currentscale + self.ds * 1
    end
end

function ItemEffect:start()
    self.active = true
end

function ItemEffect:stop()
    self.active = false
end

return ItemEffect