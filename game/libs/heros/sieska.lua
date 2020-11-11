local Class = require("libs/basics/middleclass")
local Hero = require("libs/objects/hero")
local herosdesc = require("libs/heros/herosdesc")

local Sieska = Class("Sieska", Hero)

function Sieska:initialize()
    Hero.initialize(self)
    self.deftxt = {n = HERO_SIESKA.NAME, d = HERO_SIESKA.DESC}
    self.name = HERO_SIESKA.NAME
    self.description = HERO_SIESKA.DESC
    self.onUpdateStrings = (function(n, d) return {HERO_SIESKA.NAME, HERO_SIESKA.DESC} end)
    self.heartc_k = 3
    self.heart_k = 3
    self.onDraw = (function() 
        
    end)
    self.onUpdate = (function(dt) 
        
    end)
end

return Sieska