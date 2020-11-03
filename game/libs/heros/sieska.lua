local Hero = require("libs/objects/hero")
local herosdesc = require("libs/heros/herosdesc")

local Sieska = Hero()

function Sieska:initialize()
    self.deftxt = {n = HERO_SIESKA.NAME, d = HERO_SIESKA.DESC}
    self.name = HERO_SIESKA.NAME
    self.description = HERO_SIESKA.DESC
    self.onUpdateStrings = (function(n, d)  end)
    self.heartc_k = 3
    self.heart_k = 3
end

return Sieska