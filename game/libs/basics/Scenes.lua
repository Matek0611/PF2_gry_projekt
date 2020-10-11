local Class = require("libs/basics/middleclass")
local Scene = require("libs/basics/Scene")

local Scenes = Class("Scenes")

local function emptySceneDraw()
    -- nic
end

local function emptySceneUpdate(dt)
    -- nic
end

function Scenes:initialize()
    self.list = {}
    self:addScene(Scene:new("empty", emptySceneDraw, emptySceneUpdate))
    self.active = 1
end

function Scenes:addScene(scene)
    table.insert(self.list, scene)
end

function Scenes:setActive(id)
    self.list[active].hide()
    if id < 2 or id > #self.list then
        self.list[1]:show()
        self.active = 1
    else
        self.list[id]:show()
        self.active = id
    end
end

return Scenes