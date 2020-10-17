local Class = require("libs/basics/middleclass")

local Scene = Class("Scene")

function Scene:initialize(name, ev_draw, ev_update, ev_iupdate)
    self.visible = false
    self.name = name
    self.onDraw = ev_draw
    self.onUpdate = ev_update
    self.oniUpdate = ev_iupdate
    self.canDrawAll = false
    self.onShow = nil
    self.scenes = nil
end

function Scene:show()
    if self.onShow ~= nil then 
        self.onShow()
        self:update()
    end
    self.visible = true
end

function Scene:hide()
    self.visible = false
end

function Scene:draw()
    if self.onDraw ~= nil then
        self.onDraw()
    end
end

function Scene:update(dt)
    if self.onUpdate ~= nil then
        self.onUpdate(dt)
    end
end

function Scene:iupdate()
    if self.oniUpdate ~= nil then
        self.oniUpdate()
    end
end

return Scene