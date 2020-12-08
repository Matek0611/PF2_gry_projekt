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
local Light = require("libs/shadows.Light")
local Star = require("libs/shadows.Star")

local Level = Class("Level")

function Level:initialize(nr_level, world)
    self.world = world
    self.nr = nr_level
    self.current_room = {x = 0, y = 0}

    self:generateRooms()
    self:updateSize()
    self:update(0)
end

function Level:generateRoom(posx, posy)
    if self.current_room_count >= self.rooms_count or self.rooms[posx][posy] ~= "X"  then return end

    self.rooms[posx][posy] = RectangleRoom:new(self.world, 0, 0, 0, 0)
    
    self.rooms[posx][posy]:SetColor(gray(255, 1))
    
    self.current_room_count = self.current_room_count + 1

    local a, b, c, d = love.math.random(0, 3), love.math.random(0, 3), love.math.random(0, 3), love.math.random(0, 3)
    if not (a or b or c or d) then 
        local e = love.math.random(1, 4)
        if e == 1 then 
            a = 1
        elseif e == 2 then
            b = 1
        elseif e == 3 then
            c = 1
        else
            d = 1
        end
    end

    if a == 1 then self:generateRoom(posx - 1, posy) end
    if b == 1 then self:generateRoom(posx + 1, posy) end
    if c == 1 then self:generateRoom(posx, posy - 1) end
    if d == 1 then self:generateRoom(posx, posy + 1) end
end

function Level:generateRooms()
    self.rooms_count = love.math.random(5 + self.nr, 15 + 2 * self.nr) 
    self.rooms = {}

    for i = 1, self.rooms_count * self.rooms_count do 
        self.rooms[i] = {}
        for j = 1, self.rooms_count * self.rooms_count do 
            self.rooms[i][j] = "X"
        end
    end

    self.start_room_index = math.round(self.rooms_count * self.rooms_count / 2)
    self.current_room = {x = self.start_room_index, y = self.start_room_index}
    self.current_room_count = 0

    self:generateRoom(self.start_room_index, self.start_room_index)
end

function Level:getRoom()
    if self.current_room.x == 0 or self.current_room.y == 0 then return nil end

    return self.rooms[self.current_room.x][self.current_room.y] 
end

function Level:draw() 
    if self:getRoom() ~= nil then
        self:getRoom():Draw()
    end
end

function Level:update(dt)
    if self:getRoom() ~= nil then
        self:getRoom():Update()
    end
end

function Level:updateRoom(i, j)
    if self.rooms[i][j] == "X" or self.rooms[i][j] == nil then return end

    self.rooms[i][j].Transform:SetPosition(self.left, self.top, 0)
    self.rooms[i][j]:SetDimensions(self.gridsize * 16, self.gridsize * 9) 
end

function Level:updateRooms()  
    for i = 1, self.rooms_count * self.rooms_count do 
        for j = 1, self.rooms_count * self.rooms_count do 
            self:updateRoom(i, j)
        end
    end
end

function Level:updateCurrentRoom()
    if self:getRoom() == nil then return end

    self:getRoom().Transform:SetPosition(self.left, self.top, 0)
    self:getRoom():SetDimensions(self.gridsize * 16, self.gridsize * 9) 
end

function Level:updateSize()
    self.gridsize = math.min(self.world.Width / 16, self.world.Height / 9)
    self.left = (self.world.Width - self.gridsize * 16) / 2
    self.top = (self.world.Height - self.gridsize * 9) / 2

    self:updateRooms()
end

return Level