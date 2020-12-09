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
    self:generateMinimap()
    self:updateSize()
    self:updateCurrentRoom()
    self:update(0)
end

function Level:newRoom(posx, posy)
    room = RectangleRoom:new(self.world, 0, 0, 0, 0)
    room:SetColor(gray(255, 1))
    room.xgrid, room.ygrid = posx, posy
    room.walls = {}
    room.surrounded = false

    self.rooms[#self.rooms + 1] = room
    self.grid[posx][posy] = room
end

function Level:countRoomsAround(room_index)
    surround_counter = 0
  
    room_xgrid = self.rooms[room_index].xgrid
    room_ygrid = self.rooms[room_index].ygrid
  
    --Check each surrounding grid for a room, add a counter if one is there
  
    if self.grid[room_xgrid + 1][room_ygrid] then
        surround_counter = surround_counter + 1
    end
  
    if self.grid[room_xgrid - 1][room_ygrid] then
        surround_counter = surround_counter + 1
    end
  
    if self.grid[room_xgrid][room_ygrid + 1] then
        surround_counter = surround_counter + 1
    end
  
    if self.grid[room_xgrid][room_ygrid - 1] then
        surround_counter = surround_counter + 1
    end
  
   return surround_counter
end
  
function Level:checkForSurrounded()
    for i = 1, #self.rooms do
      --if 3 or more rooms surrounding, lets enable the flag surrounded
  
        if self:countRoomsAround(i) >= 3 and not self.rooms[i].surrounded then
            self:closeNode(i)
        end
    end
end
  
function Level:closeNode(room_index)
    self.rooms[room_index].surrounded = true
  
    room_xgrid = self.rooms[room_index].xgrid
    room_ygrid = self.rooms[room_index].ygrid
  
    if not self.grid[room_xgrid - 1][room_ygrid] then
        self.grid[room_xgrid - 1][room_ygrid] = 'block'
    end
  
    if not self.grid[room_xgrid + 1][room_ygrid] then
        self.grid[room_xgrid + 1][room_ygrid] = 'block'
    end
  
    if not self.grid[room_xgrid][room_ygrid + 1] then
        self.grid[room_xgrid][room_ygrid + 1] = 'block'
    end
  
    if not self.grid[room_xgrid][room_ygrid - 1] then
        self.grid[room_xgrid][room_ygrid - 1] = 'block'
    end
end
  
function Level:selectOpenRoom()
    selected = false
  
    while not selected do
        random_room = math.random(1, #self.rooms)
  
        if not self.rooms[random_room].surrounded then
            selected = random_room
        end
    end
  
    return selected
end
  
function Level:selectAdjacentSpot(room_index)
    column = false
    row = false
  
    room_xgrid = self.rooms[room_index].xgrid
    room_ygrid = self.rooms[room_index].ygrid
  
    while not column and not row do
        random_adjacent = math.random(1, 4)
  
        if random_adjacent == 1 then
            if not self.grid[room_xgrid][room_ygrid - 1] then
                column = room_xgrid
                row = room_ygrid - 1
            end
        elseif random_adjacent == 2 then
            if not self.grid[room_xgrid + 1][room_ygrid] then
                column = room_xgrid + 1
                row = room_ygrid
            end
        elseif random_adjacent == 3 then
            if not self.grid[room_xgrid][room_ygrid + 1] then
                column = room_xgrid
                row = room_ygrid + 1
            end
        elseif random_adjacent == 4 then
            if not self.grid[room_xgrid - 1][room_ygrid] then
                column = room_xgrid - 1
                row = room_ygrid
            end
        end
    end
  
    return column, row
end

function Level:generateRoom(posx, posy)
    self:newRoom(0, 0)

    for i = 2, self.rooms_count do
        openroom = self:selectOpenRoom()
        newxgrid, newygrid = self:selectAdjacentSpot(openroom)

        self:newRoom(newxgrid, newygrid)
        self:checkForSurrounded()
    end
end

function Level:generateRooms()
    self.rooms_count = math.min(30, love.math.random(0, 1) + 5 + math.floor(self.nr * 10 / 3))
    self.rooms = {}

    self.grid = {}
    for i = -self.rooms_count, self.rooms_count do
        self.grid[i] = {}
    end

    self.start_room_index = 0
    self.current_room = {x = self.start_room_index, y = self.start_room_index}

    self:generateRoom(self.start_room_index, self.start_room_index)

    self.current_room = {x = self.start_room_index, y = self.start_room_index}
end

function Level:getRoom()
    return self.grid[self.current_room.x][self.current_room.y] 
end

function Level:draw() 
    if self:getRoom() == nil then return end

    self:getRoom():Draw()
    self:drawMinimap()
end

function Level:drawMinimap()
    local plc = getPrevColor()

    local rectw = 0.2 * self.gridsize
    local totalw = 9 * rectw + 4
    local totalh = 9 * rectw + 4
    local leftx = self.world.Width - totalw - 1
    local topy = 1

    local colfr1, colfr2, colrm1 = gray(0, 0.4), gray(0, 1), gray(50, 1)

    love.graphics.setColor(colfr1)
    love.graphics.rectangle("fill", leftx, topy, totalw, totalh)

    love.graphics.setColor(colfr2)
    love.graphics.setLineWidth(2)
    love.graphics.rectangle("line", leftx, topy, totalw, totalh)

    local ii, jj = 0, 0
    for i = self.current_room.x - 4, self.current_room.x + 4 do 
        jj = 0
        for j = self.current_room.x - 4, self.current_room.x + 4 do 
            if self.minimap[i][j] ~= "X" and self.minimap[i][j] ~= nil then 
                love.graphics.setColor(colfr2)
                love.graphics.rectangle("fill", leftx + 2 + ii * rectw, topy + 2 + jj * rectw, rectw, rectw)

                local roomcol = colrm1
                if self.minimap[i][j] == "A" then roomcol = GAME_COLOR_ACCENT end
                love.graphics.setColor(roomcol)
                love.graphics.rectangle("fill", leftx + 5 + ii * rectw, topy + 5 + jj * rectw, rectw - 6, rectw - 6, 3, 3)
            end
            jj = jj + 1
        end
        ii = ii + 1
    end

    -- for i = -self.rooms_count, self.rooms_count do 
    --     for j = -self.rooms_count, self.rooms_count do 
    --         if self.grid[i][j] ~= nil and self.grid[i][j] ~= "block" then
    --             love.graphics.setColor(colfr2)
    --             love.graphics.rectangle("fill", self.rooms_count * rectw + 2 + (i - 1) * rectw, self.rooms_count * rectw + 2 + (j - 1) * rectw, rectw, rectw)
    --         end
    --     end
    -- end

    love.graphics.setColor(plc)
end

function Level:generateMinimap()
    self.minimap = {}
    for i = -self.rooms_count, self.rooms_count do
        self.minimap[i] = {}
        for j = -self.rooms_count, self.rooms_count do 
            self.minimap[i][j] = "X"
        end
    end
end

function Level:updateMinimap()
    for i = -self.rooms_count, self.rooms_count do
        for j = -self.rooms_count, self.rooms_count do 
            if self.grid[i][j] ~= nil and self.grid[i][j] ~= "block" then
                if i == self.current_room.x and j == self.current_room.y then 
                    self.minimap[i][j] = "A"
                else
                    self.minimap[i][j] = "O"
                end
            else
                self.minimap[i][j] = "X"
            end
        end
    end
end

function Level:update(dt)
    if self:getRoom() == nil then return end

    self:getRoom():Update()
end

function Level:updateRoom(i, j)
    if self.grid[i] == nil or self.grid[i][j] == nil or self.grid[i][j] == "block" then return end

    self.grid[i][j].Transform:SetPosition(self.left, self.top, 0)
    self.grid[i][j]:SetDimensions(self.gridsize * 16, self.gridsize * 9) 
end

function Level:updateRooms()  
    for i = -self.rooms_count, self.rooms_count do 
        for j = -self.rooms_count, self.rooms_count do 
            self:updateRoom(i, j)
        end
    end
end

function Level:updateCurrentRoom()
    if self:getRoom() == nil then return end

    self:getRoom().Transform:SetPosition(self.left, self.top, 0)
    self:getRoom():SetDimensions(self.gridsize * 16, self.gridsize * 9) 

    self:updateMinimap()
end

function Level:updateSize()
    self.gridsize = math.min(self.world.Width / 16, self.world.Height / 9)
    self.left = (self.world.Width - self.gridsize * 16) / 2
    self.top = (self.world.Height - self.gridsize * 9) / 2

    self:updateRooms()
end

return Level