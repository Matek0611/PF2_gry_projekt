local Class = require("libs/basics/middleclass")
local Hero = require("libs/objects/hero")
local herosdesc = require("libs/heros/herosdesc")

local Pusia = Class("Pusia", Hero)

function Pusia:initialize()
    Hero.initialize(self)
    self.strings = HERO_PUSIA
    self.heartc_k = 1
    self.heart_k = 0
    self.heart_tc = 0
    self.lives = 9
    self.onDraw = (function() 
        
    end)
    self.onUpdate = (function(dt) 
        
    end)
end

return Pusia