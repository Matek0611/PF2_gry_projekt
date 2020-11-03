local Class = require("libs/basics/middleclass")

local BasicObject = Class("BasicObject")

function BasicObject:initialize(name) 
    self.name = name or ""
end

return BasicObject