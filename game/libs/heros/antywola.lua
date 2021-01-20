local Class = require("libs/basics/middleclass")
local Hero = require("libs/objects/hero")
local herosdesc = require("libs/heros/herosdesc")

local Antywola = Class("Antywola", Hero)

function Antywola:initialize()
    Hero.initialize(self)
    self.strings = HERO_ANTYWOLA
    self.heartc_k = 0
    self.heart_k = 0
    self.heart_tm = 8
    self.onDraw = (function() 
        
    end)
    self.onUpdate = (function(dt) 
        
    end)
end

return Antywola