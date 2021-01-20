local Class = require("libs/basics/middleclass")
local Hero = require("libs/objects/hero")
local herosdesc = require("libs/heros/herosdesc")

local Sieska = Class("Sieska", Hero)

img_hero_Sieska = love.graphics.newImage("assets/img/postacie/projekt_postaci_sieska.png")

function Sieska:initialize()
    Hero.initialize(self)
    self.strings = HERO_SIESKA
    self.heartc_k = 3
    self.heart_k = 3

    self.onDraw = (function() 
        love.graphics.draw(img_hero_Sieska, self.sprite, self.position.x, self.position.y, 0, self.getscale(), self.getscale(), 0, 0)
    end)
    self.onUpdate = (function(dt) 
        
    end)
end

return Sieska