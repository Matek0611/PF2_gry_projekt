local Class = require("libs/basics/middleclass")
local Hero = require("libs/objects/hero")
local herosdesc = require("libs/heros/herosdesc")

local Myniek = Class("Myniek", Hero)

function Myniek:initialize()
    Hero.initialize(self)
    self.deftxt = {n = HERO_MYNIEK.NAME, d = HERO_MYNIEK.DESC}
    self.name = HERO_MYNIEK.NAME
    self.description = HERO_MYNIEK.DESC
    self.onUpdateStrings = (function(n, d) return {HERO_MYNIEK.NAME, HERO_MYNIEK.DESC} end)
    self.heartc_k = 2
    self.heart_k = 2
    self.heart_b = 1
    self.onDraw = (function() 
        
    end)
    self.onUpdate = (function(dt) 
        
    end)
end

return Myniek