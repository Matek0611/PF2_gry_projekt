local Class = require("libs/basics/middleclass")
local Hero = require("libs/objects/hero")
local herosdesc = require("libs/heros/herosdesc")

local Antywola = Class("Antywola", Hero)

img_hero_Antywola = love.graphics.newImage("assets/img/postacie/projekt_postaci_antywola.png")

function Antywola:initialize()
    Hero.initialize(self)
    self.strings = HERO_ANTYWOLA
    self.heartc_k = 8
    self.heart_k = 8
    self.heart_tm = 0
    self.onDraw = (function() 
        love.graphics.draw(img_hero_Antywola, self.sprite, self.position.x, self.position.y, 0, self.getscale(), self.getscale(), 0, 0)
    end)
    self.onUpdate = (function(dt) 
        
    end)
end

return Antywola