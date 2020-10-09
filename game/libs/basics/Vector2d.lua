local Class = require("libs/basics/middleclass")
local Vec2 = Class("Vector2d")

function Vec2:initialize(x, y)
    self.x = x or 0
    self.y = y or 0
end

return Vec2