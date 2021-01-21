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

function Riddle:initialize(room, level)
    self.room = room
    self.level = level
    self.vars = {}
    self.odp = {}
    self.got = {}
    self.type = "int"
    self.finished = false
    self.correct = 0
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

        self.type = "int"
        self.odp = {self.vars.e + self.vars.d, 2 * self.vars.d, self.vars.e}
        self.got = {false, false, false}
        self.correct = 1
    elseif id == 2 then
        self.vars.a = love.math.random(-25 * nr, 25 * nr)
        self.vars.A = love.math.random(-self.vars.a, self.vars.a)

        self.type = "int"
        self.odp = {self.vars.a, self.vars.A, self.vars.a + 6}
        self.got = {false, false, false}
        self.correct = 3
    elseif id == 3 then
        self.vars.Y = love.math.random(5, nr * 8)
        self.vars.x = love.math.random(1, nr * 3)

        self.type = "float"
        self.odp = {1.5 * self.vars.x, 4.5 * self.vars.x, 4.5 * self.vars.x + self.vars.Y, self.vars.Y}
        self.got = {false, false, false, false}
        self.correct = 2
    elseif id == 4 then
        self.vars.x = love.math.random(nr + 4, nr * 15)

        self.type = "float"
        self.odp = {1, 1 / self.vars.x, 1 / (self.vars.x - 1), 0}
        self.got = {false, false, false, false}
        self.correct = 4
    elseif id == 5 then
        self.vars.a = love.math.random(2, nr * 11)
        self.vars.b = love.math.random(1, nr * 100)

        self.type = "boolean"
        self.odp = {true, false}
        self.got = {false, false}
        self.correct = 1
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
        self.got = {false, false, false, false}
        self.correct = 3
    elseif id == 7 then
        local imiona1 = {"Ola", "Oliwia", "Xawier", "Olek"}
        local imiona2 = {"Marcin", "Maciej", "Maria", "Monika", "Łukasz"}
        local imiona3 = {"Jasiek", "Dominik", "Ewa", "Oskar"}
        self.vars.A = imiona1[love.math.random(1, #imiona1)]
        self.vars.B = imiona2[love.math.random(1, #imiona2)]
        self.vars.C = imiona3[love.math.random(1, #imiona3)]

        self.type = "boolean"
        self.odp = {true, false}
        self.got = {false, false}
        self.correct = 2
    elseif id == 8 then
        self.vars.x = love.math.random(1, nr * 999)
        
        self.type = "int"
        self.odp = {self.vars.x + 16, self.vars.x + 7, self.vars.x}
        self.got = {false, false, false}
        self.correct = 2
    elseif id == 9 then
        self.vars.x = love.math.random(1, nr * 9999)

        self.type = "int"
        self.odp = {0, -1, 1, self.vars.x}
        self.got = {false, false, false, false}
        self.correct = 3
    elseif id == 10 then
        self.vars.b = love.math.random(2, nr * 25)
        self.vars.c = love.math.random(0, nr * 69)

        self.type = "bool"
        self.odp = {false, true}
        self.got = {false, false}
        self.correct = 1
    elseif id == 11 then
        self.vars.x = love.math.random(2, nr * 25)
        self.vars.y = love.math.random(3, nr * 100)

        self.type = "int"
        self.odp = {self.vars.x - 60 + self.vars.y, self.vars.x - 12 + self.vars.y, self.vars.x + self.vars.y, self.vars.x - 6 + self.vars.y}
        self.got = {false, false, false, false}
        self.correct = 4
    end
end

function Riddle:drawBtn(nr)
    if nr < 1 or nr > #self.odp then return end 
    local baseleft = self.room.level.left + self.room.level.gridsize * 2 + (4 - #self.odp) * 1.5 * self.room.level.gridsize
    local s = ""

    if self.type == "int" then
        s = string.format("%d", self.odp[nr])
    elseif self.type == "float" then 
        s = string.format("%0.2f", self.odp[nr])
    elseif self.type == "boolean" then 
        if self.odp[nr] then 
            s = ODP_TRUE
        else
            s = ODP_FALSE
        end
    elseif self.type == "bool" then 
        if self.odp[nr] then 
            s = ODP_YES
        else
            s = ODP_NO
        end
    elseif self.type == "array" then 
        for i = 1, #self.odp[nr] do 
            s = s .. self.odp[nr][i]
            if i < #self.odp[nr] then s = s .. ", " end
        end
    end

    setFont("math", math.round(self.level.gridsize / 4))
    love.graphics.setColor(clWhite)
    love.graphics.printf(s, baseleft + (nr - 1) * self.room.level.gridsize * 3, self.room.level.top + self.room.level.gridsize * 6, self.room.level.gridsize * 3, "center")
    
    local col
    if self.got[nr] then
        if self.correct == nr then 
            col = color(76, 175, 80)
        else
            col = color(213, 0, 0)
        end
    else
        col = color(189, 189, 189)
    end
    love.graphics.setColor(col)
    love.graphics.ellipse("fill", baseleft + (nr - 1) * self.room.level.gridsize * 3 + self.room.level.gridsize * 1.5, self.room.level.top + self.room.level.gridsize * 5, self.room.level.gridsize / 2, self.room.level.gridsize / 2)
    love.graphics.setColor(clBlack)
    love.graphics.setLineWidth(3)
    love.graphics.ellipse("line", baseleft + (nr - 1) * self.room.level.gridsize * 3 + self.room.level.gridsize * 1.5, self.room.level.top + self.room.level.gridsize * 5, self.room.level.gridsize / 2, self.room.level.gridsize / 2)
end

function Riddle:drawOdp()
    for i = 1, #self.odp do 
        self:drawBtn(i)
    end
end

function Riddle:hero()
    return self.room.level.world.hero
end

function Riddle:update(dt) 
    local in_rect = (function (nr) 
        local baseleft = self.room.level.left + self.room.level.gridsize * 2 + (4 - #self.odp) * 1.5 * self.room.level.gridsize
        local pos = self:hero().position
        local sx, sy = baseleft + (nr - 1) * self.room.level.gridsize * 3 + self.room.level.gridsize * 0.75, self.room.level.top + self.room.level.gridsize * 4.2
        local r = self.room.level.gridsize / 2

        return math.pow(pos.x - sx, 2) + math.pow(pos.y - sy, 2) < math.pow(r, 2)
    end)

    if not self.finished then 
        for i = 1, #self.got do 
            if in_rect(i) then 
                if self.got[i] == true then break end

                self.got[i] = true
                if i == self.correct then 
                    self.finished = true 
                    ManageMusic:play("swoosh")
                    if love.math.random(0, 100) < 15 then self:hero():cure() end
                else
                    self:hero():hurt()
                end 

                break
            end
        end
    else
        self.room.level:getRoom().closed = false
    end
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
    elseif id == 11 then
        tresc = string.format(RIDDLES[id].content, self.vars.x, self.vars.y)
    end

    love.graphics.setColor(clWhite)
    setFont("math", math.round(self.level.gridsize / 3))
    if GLOBAL_OPTIONS.DEBUG_MODE then tresc = "(" .. tostring(id) .. ") " .. tresc end
    love.graphics.printf(tresc, self.level.left + self.level.gridsize * 3, self.level.top + self.level.gridsize * 2, self.level.gridsize * 10, "center")

    self:drawOdp()

    love.graphics.setColor(pc)
end

return Riddle