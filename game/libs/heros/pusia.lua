local Class = require("libs/basics/middleclass")
local Hero = require("libs/objects/hero")
local herosdesc = require("libs/heros/herosdesc")

local Pusia = Class("Pusia", Hero)

img_hero_Pusia = love.graphics.newImage("assets/img/postacie/projekt_postaci_pusia.png")

function Pusia:initialize()
    Hero.initialize(self)
    self.strings = HERO_PUSIA
    self.heartc_k = 1
    self.heart_k = 1
    self.heart_tc = 0
    self.lives = 9
    self.onDraw = (function() 
        love.graphics.draw(img_hero_Pusia, self.sprite, self.position.x, self.position.y, 0, self.getscale(), self.getscale(), 0, 0)
    end)
    self.onUpdate = (function(dt) 
        
    end)
end

return Pusia