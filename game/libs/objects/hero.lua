local Class = require("libs/basics/middleclass")
local Creature = require("libs/objects/creature")

local Hero = Class("Hero", Creature)

function Hero:initialize()
    Creature.initialize(self, "", "")
    self.luck = 0
    self.money = 0
    self.pociecha = 0
    self.heartc_k = 0
    self.heart_k = 0
    self.heart_b = 0
    self.heart_tm = 0
    self.heart_s = 0
    self.heart_tc = 0 
    self.lives = 1
end

function Hero:calcLife()
    self.life = self.heart_k + self.heart_b + self.heart_tm + self.heart_s + self.heart_tc 
end

local img_serce_k_puste = love.graphics.newImage("assets/img/serca/serce_k_puste.png")
local img_serce_k_pol = love.graphics.newImage("assets/img/serca/serce_k_pol.png")
local img_serce_k_pelne = love.graphics.newImage("assets/img/serca/serce_k_pelne.png")
local img_serce_b_pol = love.graphics.newImage("assets/img/serca/serce_b_pol.png")
local img_serce_b_pelne = love.graphics.newImage("assets/img/serca/serce_k_pelne.png")
local img_serce_s_pol = love.graphics.newImage("assets/img/serca/serce_s_pol.png")
local img_serce_s_pelne = love.graphics.newImage("assets/img/serca/serce_s_pelne.png")
local img_serce_tm_pelne = love.graphics.newImage("assets/img/serca/serce_tm_pelne.png")
local img_serce_tc_pol = love.graphics.newImage("assets/img/serca/serce_tc_pol.png")
local img_serce_tc_pelne = love.graphics.newImage("assets/img/serca/serce_tc_pelne.png")

local img_scale = 0.35
local img_spacing = 5

function Hero:drawHearts(x, y)
    local lastx = x
    
    if self.heartc_k > 0 then 
        for i = 1, math.floor(self.heart_k) do
            love.graphics.draw(img_serce_k_pelne, lastx, y, 0, img_scale, img_scale)
            lastx = lastx + img_serce_k_pelne:getWidth() * img_scale + img_spacing
        end
        if self.heartc_k ~= self.heart_k then
            local ile = self.heart_k
            if self.heart_k - math.floor(self.heart_k) ~= 0 then 
                love.graphics.draw(img_serce_k_pol, lastx, y, 0, img_scale, img_scale)
                lastx = lastx + img_serce_k_pol:getWidth() * img_scale + img_spacing
                ile = math.ceil(self.heart_k)
            end
            for i = ile, self.heartc_k - 1 do
                love.graphics.draw(img_serce_k_puste, lastx, y, 0, img_scale, img_scale)
                lastx = lastx + img_serce_k_puste:getWidth() * img_scale + img_spacing
            end
        end
    end
end

return Hero