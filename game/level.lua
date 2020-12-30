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
local moonshine = require("libs/moonshine")

local Level = Class("Level")

local bgEffect = moonshine.chain(moonshine.effects.fog)
bgEffect.fog.speed = {0.8, 0.9}
local time = 0

-- 1..9
local room_colors = {
    color(53, 31, 27, 1), 
    color(76, 61, 55, 1), 
    color(0, 0, 0, 1), 
    color(0, 0, 0, 1), 
    color(0, 0, 0, 1), 
    color(0, 0, 0, 1), 
    color(0, 0, 0, 1), 
    color(0, 0, 0, 1), 
    color(0, 0, 0, 1), 
    color(0, 0, 0, 1)
}

local room_colors_dark = {}
for i = 1, #room_colors do 
    room_colors_dark[i] = colorlight(room_colors[i], 0.65)
end

local room_colors_dark2 = {}
for i = 1, #room_colors do 
    room_colors_dark2[i] = colorlight(room_colors[i], 0.85)
end

local shVignette = moonshine.chain(moonshine.effects.vignette)

function Level:initialize(nr_level, world)
    self.world = world
    self.nr = nr_level
    self.current_room = {x = 0, y = 0}

    self.clRoomMain, self.clRoomBorder, self.clRoomWalls = room_colors[self.nr], room_colors_dark[self.nr], room_colors_dark2[self.nr]

    bgEffect.fog.fog_color = {self.clRoomMain[1], self.clRoomMain[2], self.clRoomMain[3]}

    self:generateRooms()
    self:generateMinimap()
    self:updateSize()
    self:updateCurrentRoom()
    self:update(0)
end

function Level:newRoom(posx, posy)
    room = RectangleRoom:new(self.world, 0, 0, 0, 0)
    room.xgrid, room.ygrid = posx, posy
    room.walls = {}
    room.surrounded = false
    room.id = 0

    table.insert(self.rooms, room)
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
    self:newRoom(posx, posy)

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

    for i = -self.rooms_count, self.rooms_count do 
        for j = -self.rooms_count, self.rooms_count do 
            if self.grid[i][j] ~= nil and self.grid[i][j] ~= "block" then
                if i == self.start_room_index then 
                    self.grid[i][j].id = 0 
                else
                    local rand_id = 0
                    local surr = {top = false, bottom = false, left = false, right = false}
                    local x, y = i, j

                    if self.grid[x - 1][y] ~= nil and self.grid[x - 1][y] ~= "block" then
                        surr.left = true
                    end
                    if self.grid[x + 1][y] ~= nil and self.grid[x + 1][y] ~= "block" then
                        surr.right = true
                    end
                    if self.grid[x][y - 1] ~= nil and self.grid[x][y - 1] ~= "block" then
                        surr.top = true
                    end
                    if self.grid[x][y + 1] ~= nil and self.grid[x][y + 1] ~= "block" then
                        surr.bottom = true
                    end

                    if surr.top and surr.bottom and surr.left and surr.right then
                        -- ze wszystkich czterech stron jest
                        rand_id = love.math.random(1, 99)
                    elseif not surr.top then
                        -- górnego nie ma
                        rand_id = love.math.random(100, 199)
                    elseif not surr.bottom then 
                        -- dolnego nie ma
                        rand_id = love.math.random(200, 299)
                    elseif not surr.left then
                        -- lewego nie ma
                        rand_id = love.math.random(300, 399)
                    else
                        -- prawego nie ma
                        rand_id = love.math.random(400, 499)
                    end

                    self.grid[i][j].id = rand_id
                end

                self:setObjectsForRoom(i, j)
            end
        end
    end

    self.current_room = {x = self.start_room_index, y = self.start_room_index}
end

function Level:setObjectsForRoom(i, j)
    local room = self.grid[i][j]
    local id = room.id

    
end

function Level:getRoomFromGrid(room_id)
    return self.grid[self.rooms[room_id].gridx][self.rooms[room_id].gridy]
end

function Level:getRoom()
    return self.grid[self.current_room.x][self.current_room.y] 
end

function Level:roomDraw()
    local pc = getPrevColor()

    love.graphics.setColor(self.clRoomWalls)
    love.graphics.rectangle("fill", self.left, self.top, self.gridsize * 16, self.gridsize * 9)

    love.graphics.setColor(self.clRoomMain)
    love.graphics.rectangle("fill", self.left + self.gridsize, self.top + self.gridsize, self.gridsize * 14, self.gridsize * 7)

    love.graphics.setColor(self.clRoomBorder)
    love.graphics.setLineWidth(4)
    love.graphics.rectangle("line", self.left + 2, self.top + 2, self.gridsize * 16 - 4, self.gridsize * 9 - 4)

    love.graphics.setColor(self.clRoomBorder)
    love.graphics.setLineWidth(3)
    love.graphics.rectangle("line", self.left + self.gridsize + 1, self.top + self.gridsize + 1, self.gridsize * 14 - 3, self.gridsize * 7 - 3)

    love.graphics.line(self.left + 2, self.top + 2, self.left + self.gridsize + 2, self.top + self.gridsize + 2)
    love.graphics.line(self.left + 2, self.top + self.gridsize * 16 - 2, self.left + self.gridsize + 2, self.top + self.gridsize * 15 - 2)
    love.graphics.line(self.left + self.gridsize * 16 - 2, self.top + 2, self.left + self.gridsize * 15 - 2, self.top + self.gridsize + 2)
    love.graphics.line(self.left + self.gridsize * 16 - 2, self.top + self.gridsize * 9 + 2, self.left + self.gridsize * 15 - 2, self.top + self.gridsize * 8 - 2)

    love.graphics.setColor(pc)

    self.world.hero:draw()
end

function Level:bgDraw()
    bgEffect.draw(function()
        love.graphics.setColor(clBlack)
        love.graphics.rectangle("fill", 0, 0, self.world.Width, self.world.Height)
    end)
end

function Level:bgUpdate(dt)
    time = time + dt 
	bgEffect.fog.time = time % 100
end

function Level:drawLastEffects()
    
end

function Level:updateLastEffects(dt)

end

function Level:draw() 
    if self:getRoom() == nil then return end

    local plc = getPrevColor()

    self:bgDraw()
    self:getRoom():Draw()
    self:roomDraw()
    self:drawMinimap()

    love.graphics.setColor(plc)
end

local colfr1, colfr2, colrm1 = gray(0, 0.4), gray(0, 1), gray(50, 1)

function Level:drawMinimap()
    local rectw = 0.2 * self.gridsize
    local totalw = 9 * rectw + 4
    local totalh = 9 * rectw + 4
    local leftx = self.world.Width - totalw - 1
    local topy = 1

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

                -- local red = color(255, 0, 0, 1)
                -- love.graphics.setColor(red)
                -- love.graphics.print("["..tostring(self.grid[i][j].id).."]", leftx + 2 + ii * rectw, topy + 2 + jj * rectw)
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
    self:bgUpdate(dt)
    self.world.hero:update(dt)
    self:updateLastEffects(dt)
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

    self.world.hero.scalefrom = self.gridsize

    bgEffect.resize(self.world.Width, self.world.Height)
    shVignette.resize(self.world.Width, self.world.Height)

    self:updateRooms()
end

return Level