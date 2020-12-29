local Class = require("libs/basics/middleclass")
local Hero = require("libs/objects/hero")
local herosdesc = require("libs/heros/herosdesc")

local Sieska = Class("Sieska", Hero)

img_hero_Sieska = love.graphics.newImage("assets/img/postacie/projekt_postaci_sieska.png")

function Sieska:initialize()
    Hero.initialize(self)
    self.deftxt = {n = HERO_SIESKA.NAME, d = HERO_SIESKA.DESC}
    self.name = HERO_SIESKA.NAME
    self.description = HERO_SIESKA.DESC
    self.onUpdateStrings = (function(n, d) return {HERO_SIESKA.NAME, HERO_SIESKA.DESC} end)
    self.heartc_k = 3
    self.heart_k = 3

    self.fps = 15
    self.anim_timer = 1 / self.fps
    self.frame = 1
    self.frames = 3
    self.xoffset = 0
    self.sprite = sprite_hero_s

    self.onDraw = (function() 
        love.graphics.draw(img_hero_Sieska, self.sprite, self.position.x, self.position.y, 0, self.getscale(), self.getscale(), 0, 0)
    end)
    self.onUpdate = (function(dt) 
        dt = dt or 0
        if self.ismoving then
            if dt > 0.035 then return end

            self.anim_timer = self.anim_timer - dt
            if self.anim_timer <= 0 then 
                self.anim_timer = 1 / self.fps
                self.frame = self.frame + 1
                if self.frame > self.frames then self.frame = 1 end
                self.xoffset = 100 * self.frame
                self.sprite:setViewport(self.xoffset, self.spritetop(), 100, 100)
            end
        else
            self.frame = 0
            self.xoffset = 0
            self.sprite:setViewport(self.xoffset, self.spritetop(), 100, 100)
        end
    end)
end

return Sieska