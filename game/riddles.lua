local Class = require("libs/basics/middleclass")
local globals = require("globals")
local gamemode = require("gamemode")
local translation = require("translation")
local loading = require("loading")
local options = require("options")
local music = require("music")
local shadows = require("libs/shadows")
local lightworld = require("libs/shadows.lightworld")
local RectangleRoom = require("libs/shadows.Room.RectangleRoom")

local Riddle = Class("Riddle")

RIDDLES_COUNT = 10
RIDDLES_LANG = ""

RIDDLES = {}
for i = 1, RIDDLES_COUNT do 
    RIDDLES[i] = {}
    RIDDLES[i].content = ""
end

function translateRiddles()
    if GLOBAL_OPTIONS.OPTS_LANG == RIDDLES_LANG then return end

    if GLOBAL_OPTIONS.OPTS_LANG == "en" then 
        RIDDLES[1].content = "What number will be next in this sequence?\n0, %d, %d, %d, %d, %d, ?"
        RIDDLES[2].content = "What number will be next in this sequence?\n%d, %d, %d, %d, %d, %d, ?"
        RIDDLES[3].content = "In the last %d matches, Adam scored %d, Wojtek scored %d, and Maciek half the number of goals scored by Adam and Wojtek together. How many goals have they scored in total?"
        RIDDLES[4].content = "%d people pick up their coats after the party. But it's a mess there. If %d people have their own coat, what is the probability that person number %d has someone else's coat?"
        RIDDLES[5].content = "If log(x, ⁡%d) = log(x, ⁡%d) + log(x, ⁡%d), x = e is true."
        RIDDLES[6].content = "Arrange the numbers in ascending order.\n%d, %d, %d, %d, %d, %d"
        RIDDLES[7].content = "If %s has less money than %s and %s has more money than %s, then %s has less money than %s. True or False?"
        RIDDLES[8].content = "Which number does not match the rest?\n%d, %d, %d, %d, %d, %d, %d"
        RIDDLES[9].content = "Calculate (%d - (- %d)) / 3 / (- %d + 2 * %d)."
        RIDDLES[10].content = "Do both equations give the same result?\nx - log%d1 = 1\n%d⁰ = x + 0!"
    else
        RIDDLES[1].content = "Jaka liczba będzie następna w tym ciągu?\n0, %d, %d, %d, %d, %d, ?"
        RIDDLES[2].content = "Jaka liczba będzie następna w tym ciągu?\n%d, %d, %d, %d, %d, %d, ?"
        RIDDLES[3].content = "W ostatnich %d meczach Adam strzelił %d bramek, Wojtek strzelił %d, a Maciek połowę liczby bramek uzyskanych przez Adama i Wojtka razem. Ile goli zdobyli łącznie?"
        RIDDLES[4].content = "%d osób odbiera swoje płaszcze po przyjęciu. Panuje tam jednak bałagan. Jeżeli %d osób ma swój płaszcz, to jakie jest prawdopodobieństwo, że osoba numer %d ma cudzy płaszcz?"
        RIDDLES[5].content = "Jeżeli log(x, ⁡%d) = log(x, ⁡%d) + log(x, ⁡%d), to x = e jest prawdziwe."
        RIDDLES[6].content = "Uporządkuj liczby od najmniejszej do największej.\n%d, %d, %d, %d, %d, %d"
        RIDDLES[7].content = "Jeśli %s ma mniej pieniędzy niż %s, a %s ma więcej pieniędzy niż %s, to %s ma mniej pieniędzy niż %s. Prawda czy fałsz?"
        RIDDLES[8].content = "Która liczba nie pasuje do pozostałych?\n%d, %d, %d, %d, %d, %d, %d"
        RIDDLES[9].content = "Oblicz (%d - (- %d)) / 3 / (- %d + 2 * %d)."
        RIDDLES[10].content = "Czy oba równania dają taki sam wynik?\nx - log(%d, 1) = 1\n%d⁰ = x + 0!"
    end
end

function Riddle:initialize(room, level)
    self.room = room
    self.level = level
    self.vars = {}
    self.odp = {}
    self.type = "number"
    self:setup()
end

function Riddle:setup()
    local id = self.room.id
    local nr = self.level.nr
    
    if id == 1 then
        self.vars.a = love.math.random(-10 * nr, 10 * nr)
        self.vars.b = self.vars.a
        self.vars.c = self.vars.b + self.vars.a
        self.vars.d = self.vars.c + self.vars.b
        self.vars.e = self.vars.d + self.vars.c

        self.type = "number"
        self.odp = {self.vars.e + self.vars.d, 2 * self.vars.d, self.vars.e}
    elseif id == 2 then
        self.vars.a = love.math.random(-25 * nr, 25 * nr)
        self.vars.A = love.math.random(-self.vars.a, self.vars.a)

        self.type = "number"
        self.odp = {self.vars.a, self.vars.A, self.vars.a + 6}
    elseif id == 3 then
        self.vars.Y = love.math.random(5, nr * 8)
        self.vars.x = love.math.random(1, nr * 3)

        self.type = "number"
        self.odp = {4.5 * self.vars.x, 1.5 * self.vars.x, 4.5 * self.vars.x + self.vars.Y, self.vars.Y}
    elseif id == 4 then
        self.vars.x = love.math.random(nr + 4, nr * 15)

        self.type = "number"
        self.odp = {0, 1 / self.vars.x, 1 / (self.vars.x - 1), 1}
    elseif id == 5 then
        self.vars.a = love.math.random(2, nr * 11)
        self.vars.b = love.math.random(1, nr * 100)

        self.type = "boolean"
        self.odp = {true, false}
    elseif id == 6 then
        self.vars.x = love.math.random(-999 * nr, nr * 999)
        self.vars.a = self.vars.x + 2
        self.vars.b = self.vars.x - 10
        self.vars.c = self.vars.x + 99
        self.vars.d = self.vars.x - 8
        self.vars.e = self.vars.x
        self.vars.f = self.vars.x + 31
        
        self.type = "array"
        self.odp = {
            {self.vars.b, self.vars.d, self.vars.a, self.vars.e, self.vars.f, self.vars.c},
            {self.vars.d, self.vars.b, self.vars.f, self.vars.e, self.vars.a, self.vars.c},
            {self.vars.b, self.vars.d, self.vars.e, self.vars.a, self.vars.f, self.vars.c},
            {self.vars.b, self.vars.d, self.vars.e, self.vars.a, self.vars.c, self.vars.f}
        }
    elseif id == 7 then
        local imiona1 = {"Ola", "Oliwia", "Xawier", "Olek"}
        local imiona2 = {"Marcin", "Maciej", "Maria", "Monika", "Łukasz"}
        local imiona3 = {"Jasiek", "Dominik", "Ewa", "Oskar"}
        self.vars.A = imiona1[love.math.random(1, #imiona1)]
        self.vars.B = imiona2[love.math.random(1, #imiona2)]
        self.vars.C = imiona3[love.math.random(1, #imiona3)]

        self.type = "boolean"
        self.odp = {true, false}
    elseif id == 8 then
        self.vars.x = love.math.random(1, nr * 999)
        
        self.type = "number"
        self.odp = {self.vars.x + 16, self.vars.x + 7, self.vars.x}
    elseif id == 9 then
        self.vars.x = love.math.random(1, nr * 9999)

        self.type = "number"
        self.odp = {self.vars.x, 1, -1, 0}
    elseif id == 10 then
        self.vars.b = love.math.random(2, nr * 25)
        self.vars.c = love.math.random(0, nr * 69)

        self.type = "bool"
        self.odp = {true, false}
    end
end

function Riddle:update(dt) 

end

function Riddle:draw()
    local pc = getPrevColor()

    local tresc = ""
    local id = self.room.id

    if id == 1 then 
        tresc = string.format(RIDDLES[id].content, self.vars.a, self.vars.b, self.vars.c, self.vars.d, self.vars.e)
    elseif id == 2 then
        tresc = string.format(RIDDLES[id].content, self.vars.A, self.vars.a, self.vars.A, self.vars.a + 2, self.vars.A, self.vars.a + 4, self.vars.A)
    elseif id == 3 then
        tresc = string.format(RIDDLES[id].content, self.vars.Y, self.vars.x * 2, self.vars.x)
    elseif id == 4 then
        tresc = string.format(RIDDLES[id].content, self.vars.x, self.vars.x - 1, self.vars.x)
    elseif id == 5 then
        tresc = string.format(RIDDLES[id].content, self.vars.a * self.vars.b, self.vars.a, self.vars.b)
    elseif id == 6 then
        tresc = string.format(RIDDLES[id].content, self.vars.a, self.vars.b, self.vars.c, self.vars.d, self.vars.e, self.vars.f)
    elseif id == 7 then
        tresc = string.format(RIDDLES[id].content, self.vars.A, self.vars.B, self.vars.C, self.vars.B, self.vars.C, self.vars.A)
    elseif id == 8 then
        tresc = string.format(RIDDLES[id].content, self.vars.x + 6, self.vars.x + 2, self.vars.x, self.vars.x + 10, self.vars.x + 7, self.vars.x + 22, self.vars.x + 16)
    elseif id == 9 then
        tresc = string.format(RIDDLES[id].content, self.vars.x * 2, self.vars.x, self.vars.x, self.vars.x)
    elseif id == 10 then
        tresc = string.format(RIDDLES[id].content, self.vars.b, self.vars.c)
    end

    love.graphics.setColor(clWhite)
    setFont("math", math.round(self.level.gridsize / 3))
    if GLOBAL_OPTIONS.DEBUG_MODE then tresc = "(" .. tostring(id) .. ") " .. tresc end
    love.graphics.printf(tresc, self.level.left + self.level.gridsize * 3, self.level.top + self.level.gridsize * 2, self.level.gridsize * 10, "center")

    love.graphics.setColor(pc)
end

return Riddle