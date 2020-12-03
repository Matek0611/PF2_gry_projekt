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

    self:updateSize()
    self:generateRooms()
    self:update(0)
end

function Level:generateRoom(posx, posy)
    if self.current_room_count >= self.rooms_count then return end

    self.rooms[posx][posy] = RectangleRoom:new(self.world, 0, 0, 0, 0)
    self.current_room_count = self.current_room_count + 1

    local a, b, c, d = love.math.random(0, 1), love.math.random(0, 1), love.math.random(0, 1), love.math.random(0, 1)
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
    self:updateCurrentRoom()
end

function Level:getRoom()
    if self.current_room == nil then return nil end

    return self.rooms[self.current_room.x][self.current_room.y] 
end

function Level:draw() 
    if self.getRoom() ~= nil then
        self:getRoom():Draw()
    end
end

function Level:update(dt)
    if self.getRoom() ~= nil then
        self:getRoom():Update()
    end
end

function Level:updateRoom(i, j)
    if self.rooms[i][j] == "X" or self.rooms[i][j] == nil then return end

    if i ~= self.start_room_index and j ~= self.start_room_index then 
        self.rooms[i][j].Transform.SetPosition(0, 0, 0)
        self.rooms[i][j]:SetDimension(0, 0) 
    else 
        self.rooms[i][j].Transform.SetPosition(self.left, self.top, 0)
        self.rooms[i][j]:SetDimension(self.gridsize * 16, self.gridsize * 9) 
    end

    updateRoom(i, j - 1)
    updateRoom(i, j + 1)
    updateRoom(i - 1, j)
    updateRoom(i + 1, j)
end

function Level:updateRooms()
    updateRoom(self.start_room_index, self.start_room_index)
end

function Level:updateCurrentRoom()
    if self:getRoom() == nil then return end

    self:getRoom().Transform.SetPosition(self.left, self.top, 0)
    self:getRoom():SetDimension(self.gridsize * 16, self.gridsize * 9) 
end

function Level:updateSize()
    self.gridsize = self.world.Width / 9
    self.left = (self.world.Width - self.gridsize * 16) / 2
    self.top = (self.world.Height - self.gridsize * 9) / 2

    self:updateCurrentRoom()
end

return Level