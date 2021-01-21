local Class = require("libs/basics/middleclass")
local Hero = require("libs/objects/hero")
local herosdesc = require("libs/heros/herosdesc")

local Myniek = Class("Myniek", Hero)

img_hero_Myniek = love.graphics.newImage("assets/img/postacie/projekt_postaci_myniek.png")

function Myniek:initialize()
    Hero.initialize(self)
    self.strings = HERO_MYNIEK
    self.heartc_k = 2
    self.heart_k = 2
    self.lives = 2
    self.heart_b = 0
    self.onDraw = (function() 
        love.graphics.draw(img_hero_Myniek, self.sprite, self.position.x, self.position.y, 0, self.getscale(), self.getscale(), 0, 0)
    end)
    self.onUpdate = (function(dt) 
        
    end)
end

return Myniek