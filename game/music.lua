local Class = require("libs/basics/middleclass")

local Music = Class("Music")

function Music:initialize()
    self.path = "assets/music/"
    
    self.loading_and_menu = love.audio.newSource(self.path .. "Cover - Patrick Patrikios.mp3", "stream")
    self.loading_and_menu:setLooping(true)

    self.swoosh = love.audio.newSource(self.path .. "Swoosh.mp3", "stream")
    self.click = love.audio.newSource(self.path .. "Pen Clicking.mp3", "stream")
    self.bum = love.audio.newSource(self.path .. "Big Explosion Cut Off.mp3", "stream")

    self.level1 = love.audio.newSource(self.path .. "Pluckandplay - Kwon.mp3", "stream")
    self.level1:setLooping(true)
    self.level3 = love.audio.newSource(self.path .. "Forget Me Not - Patrick Patrikios.mp3", "stream")
    self.level3:setLooping(true)
    self.level5 = love.audio.newSource(self.path .. "The Emperor's New Nikes - DJ Williams.mp3", "stream")
    self.level5:setLooping(true)
    self.level7 = love.audio.newSource(self.path .. "Body And Attitude - DJ Freedem.mp3", "stream")
    self.level7:setLooping(true)
    self.level9 = love.audio.newSource(self.path .. "Danger Snow - Dan Henig.mp3", "stream")
    self.level9:setLooping(true)

    self.active = nil

    self.defvolume = 0.8
    self.volume = self.defvolume
end

function Music:play(what)
    local m = nil
    local issound = false

    if what == "loading" or what == "menu" then
        m = self.loading_and_menu
    elseif what == "swoosh" then
        m = self.swoosh
        issound = true
    elseif what == "bum" then
        m = self.bum
        issound = true
    elseif what == "click" then
        m = self.click
        issound = true
    elseif what == "level1" or what == "level2" then
        m = self.level1
    elseif what == "level3" or what == "level4" then
        m = self.level3
    elseif what == "level5" or what == "level6" then
        m = self.level5
    elseif what == "level7" or what == "level8" then
        m = self.level7
    elseif what == "level9" or what == "level10" then
        m = self.level9
    end

    if m ~= nil then 
        if not issound then self:stop() end

        self.active = m

        m:setVolume(self.volume)
        m:play()
    else
        self.active = nil
    end
end

function Music:setVolume(value)
    if self.active == nil or type(value) ~= "number" then return end

    if value > 1 then self.volume = 1 end
    if value < 0 then self.volume = 0 end 

    love.audio.setVolume(value)
    self.active:setVolume(value)
    self.volume = value
end

function Music:stop()
    love.audio.stop()
end

ManageMusic = Music:new()