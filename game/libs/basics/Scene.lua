local Class = require("libs/basics/middleclass")

local Scene = Class("Scene")

function Scene:initialize(name, ev_draw, ev_update)
    self.visible = false
    self.name = name
    self.onDraw = ev_draw
    self.onUpdate = ev_update
end

function Scene:show()
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

return Scene