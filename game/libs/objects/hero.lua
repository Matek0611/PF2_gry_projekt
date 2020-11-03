local Creature = require("libs/objects/creature")

local Hero = Creature("", "")

function Hero:initialize()
    self.luck = 0
    self.money = 0
    self.pociecha = 0
    self.heartc_k = 0
    self.heart_k = 0
    self.heart_b = 0
    self.heart_tm = 0
    self.heart_s = 0
    self.heart_tc = 0 
end

function Hero:calcLife()
    self.life = self.heart_k + self.heart_b + self.heart_tm + self.heart_s + self.heart_tc 
end

return Hero