local Class = require("libs/basics/middleclass")
local Creature = require("libs/objects/creature")

local Hero = Class("Hero", Creature)

sprite_hero_s = love.graphics.newQuad(0, 0, 400, 100, 400, 400)
sprite_hero_s:setViewport(0, 0, 100, 100);
sprite_hero_w = love.graphics.newQuad(0, 100, 400, 100, 400, 400)
sprite_hero_w:setViewport(0, 0, 100, 100);
sprite_hero_e = love.graphics.newQuad(0, 200, 400, 100, 400, 400)
sprite_hero_e:setViewport(0, 0, 100, 100);
sprite_hero_n = love.graphics.newQuad(0, 300, 400, 100, 400, 400)
sprite_hero_n:setViewport(0, 0, 100, 100);

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
    self.dead = false

    self.fps = 15
    self.anim_timer = 1 / self.fps
    self.frame = 0
    self.frames = 3
    self.xoffset = 0

    self.sprite = sprite_hero_s
    self.spritetop = (function () 
        if self.sprite == sprite_hero_s then 
            return 0
        elseif self.sprite == sprite_hero_w then
            return 100
        elseif self.sprite == sprite_hero_e then 
            return 200
        else 
            return 300
        end
    end)
end

function Hero:updateEx(dt)
    if not self.canmove then return end

    if self.heart_k < 0.5 or self.heart_k > self.heartc_k then 
        self:hurt()
    end

    local go = GLOBAL_OPTIONS
    local k = love.keyboard

    if k.isDown(go.HERO_LEFT) then
        self:move("left")
        self.sprite = sprite_hero_w
    end
    if k.isDown(go.HERO_RIGHT) then
        self:move("right")
        self.sprite = sprite_hero_e
    end
    if k.isDown(go.HERO_UP) then
        self:move("up")
        self.sprite = sprite_hero_n
    end
    if k.isDown(go.HERO_DOWN) then
        self:move("down")
        self.sprite = sprite_hero_s
    end

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

    self.ismoving = false
end

function Hero:calcLife()
    self.life = self.heart_k + self.heart_b + self.heart_tm + self.heart_s + self.heart_tc 
end

function Hero:hurt()
    local Music = require("music")

    if self.heart_k < 0.5 and self.lives == 1 then 
        self.dead = true
        ManageMusic:play("bum")
    else
        if self.heart_k < 0.5 then 
            self.lives = self.lives - 1
            self.heart_k = self.heartc_k
        else
            self.heart_k = math.max(self.heart_k - 0.5, 0)
        end
    end
end

function Hero:cure()
    if self.heart_k == self.heartc_k then return end

    self.heart_k = self.heart_k + 0.5
end

img_serce_k_puste = love.graphics.newImage("assets/img/serca/serce_k_puste.png")
img_serce_k_pol = love.graphics.newImage("assets/img/serca/serce_k_pol.png")
img_serce_k_pelne = love.graphics.newImage("assets/img/serca/serce_k_pelne.png")
img_serce_b_pol = love.graphics.newImage("assets/img/serca/serce_b_pol.png")
img_serce_b_pelne = love.graphics.newImage("assets/img/serca/serce_k_pelne.png")
img_serce_s_pol = love.graphics.newImage("assets/img/serca/serce_s_pol.png")
img_serce_s_pelne = love.graphics.newImage("assets/img/serca/serce_s_pelne.png")
img_serce_tm_pelne = love.graphics.newImage("assets/img/serca/serce_tm_pelne.png")
img_serce_tc_pol = love.graphics.newImage("assets/img/serca/serce_tc_pol.png")
img_serce_tc_pelne = love.graphics.newImage("assets/img/serca/serce_tc_pelne.png")

img_serce_width = img_serce_k_pelne:getWidth()
img_serce_scale = 0.35
img_serce_spacing = 5

function Hero:drawHearts(x, y)
    local lastx = x
    
    if self.heartc_k > 0 then 
        for i = 1, math.floor(self.heart_k) do
            love.graphics.draw(img_serce_k_pelne, lastx, y, 0, img_serce_scale, img_serce_scale)
            lastx = lastx + img_serce_k_pelne:getWidth() * img_serce_scale + img_serce_spacing
        end
        if self.heartc_k ~= self.heart_k then
            local ile = self.heart_k
            if self.heart_k - math.floor(self.heart_k) ~= 0 then 
                love.graphics.draw(img_serce_k_pol, lastx, y, 0, img_serce_scale, img_serce_scale)
                lastx = lastx + img_serce_k_pol:getWidth() * img_serce_scale + img_serce_spacing
                ile = math.ceil(self.heart_k)
            end
            for i = ile, self.heartc_k - 1 do
                love.graphics.draw(img_serce_k_puste, lastx, y, 0, img_serce_scale, img_serce_scale)
                lastx = lastx + img_serce_k_puste:getWidth() * img_serce_scale + img_serce_spacing
            end
        end
    end

    if self.lives > 1 then 
        local globals = require("globals")

        love.graphics.setColor(clWhite)
        setFont("text", 20)
        love.graphics.printf(string.format("x%d", self.lives), lastx + 10, y + 8, 100, "left")
    end
end

return Hero