local Class = require("libs/basics/middleclass")

local Music = Class("Music")

function Music:initialize()
    self.path = "assets/music/"
    
    self.loading_and_menu = love.audio.newSource(self.path .. "Cover - Patrick Patrikios.mp3", "stream")
    self.loading_and_menu:setLooping(true)

    self.swoosh = love.audio.newSource(self.path .. "Swoosh.mp3", "stream")

    self.click = love.audio.newSource(self.path .. "Pen Clicking.mp3", "stream")

    self.level1 = love.audio.newSource(self.path .. "Pluckandplay - Kwon.mp3", "stream")
    self.level1:setLooping(true)

    self.active = nil

    self.defvolume = 0.9
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
    elseif what == "click" then
        m = self.click
        issound = true
    elseif what == "level1" then
        m = self.level1
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
    value = value or self.defvolume
    if value > 1 or value < 0 or self.active == nil then return end

    self.active:setVolume(value)
end

function Music:stop()
    love.audio.stop()
end

ManageMusic = Music:new()