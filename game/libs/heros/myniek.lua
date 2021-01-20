local Class = require("libs/basics/middleclass")
local Hero = require("libs/objects/hero")
local herosdesc = require("libs/heros/herosdesc")

local Myniek = Class("Myniek", Hero)

function Myniek:initialize()
    Hero.initialize(self)
    self.strings = HERO_MYNIEK
    self.heartc_k = 2
    self.heart_k = 0
    self.heart_b = 0
    self.onDraw = (function() 
        
    end)
    self.onUpdate = (function(dt) 
        
    end)
end

return Myniek