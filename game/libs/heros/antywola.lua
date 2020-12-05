local Class = require("libs/basics/middleclass")
local Hero = require("libs/objects/hero")
local herosdesc = require("libs/heros/herosdesc")

local Antywola = Class("Antywola", Hero)

function Antywola:initialize()
    Hero.initialize(self)
    self.deftxt = {n = HERO_ANTYWOLA.NAME, d = HERO_ANTYWOLA.DESC}
    self.name = HERO_ANTYWOLA.NAME
    self.description = HERO_ANTYWOLA.DESC
    self.onUpdateStrings = (function(n, d) return {HERO_ANTYWOLA.NAME, HERO_ANTYWOLA.DESC} end)
    self.heartc_k = 0
    self.heart_k = 0
    self.heart_tm = 8
    self.onDraw = (function() 
        
    end)
    self.onUpdate = (function(dt) 
        
    end)
end

return Antywola