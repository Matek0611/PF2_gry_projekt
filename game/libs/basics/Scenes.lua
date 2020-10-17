local Class = require("libs/basics/middleclass")
local Scene = require("libs/basics/Scene")

local Scenes = Class("Scenes")

local function emptySceneDraw() end

local function emptySceneUpdate(dt) end

function Scenes:initialize()
    self.list = {}
    self:addScene(Scene:new("empty", emptySceneDraw, emptySceneUpdate))
    self.active = 1
    self.drawAll = false
end

function Scenes:addScene(scene)
    local id = #self.list + 1
    self.list[id] = scene
end

function Scenes:setActive(id)
    self.list[self.active]:hide()
    if id < 2 or id > #self.list then
        self.list[1]:show()
        self.active = 1
    else
        self.list[id]:show()
        self.active = id
    end
end

function Scenes:draw()
    if self.drawAll then 
        for i, s in ipairs(self.list) do
            if i ~= self.active and self.list[i].canDrawAll then
                self.list[i]:draw()
            end
        end
    end
    self.list[self.active]:draw()
end

function Scenes:update(dt)
    for i, s in ipairs(self.list) do
        s:iupdate()
    end
    self.list[self.active]:update()
end

return Scenes