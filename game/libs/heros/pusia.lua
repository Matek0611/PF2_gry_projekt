local Class = require("libs/basics/middleclass")
local Hero = require("libs/objects/hero")
local herosdesc = require("libs/heros/herosdesc")

local Pusia = Class("Pusia", Hero)

function Pusia:initialize()
    Hero.initialize(self)
    self.deftxt = {n = HERO_PUSIA.NAME, d = HERO_PUSIA.DESC}
    self.name = HERO_PUSIA.NAME
    self.description = HERO_PUSIA.DESC
    self.onUpdateStrings = (function(n, d) return {HERO_PUSIA.NAME, HERO_PUSIA.DESC} end)
    self.heartc_k = 0
    self.heart_k = 0
    self.heart_tm = 8
    self.onDraw = (function() 
        
    end)
    self.onUpdate = (function(dt) 
        
    end)
end

return Pusia