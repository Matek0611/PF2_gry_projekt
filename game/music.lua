local Class = require("libs/basics/middleclass")

local Music = Class("Music")

function Music:initialize()
    self.path = "assets/music/"
    
    self.loading_and_menu = love.audio.newSource(self.path .. "Cover - Patrick Patrikios.mp3", "stream")
    self.loading_and_menu:setLooping(true)

    self.swoosh = love.audio.newSource(self.path .. "Swoosh.mp3", "stream")

    self.click = love.audio.newSource(self.path .. "Pen Clicking.mp3", "stream")

    self.volume = 0.9
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
    end

    if m ~= nil then 
        if not issound then self:stop() end

        m:setVolume(self.volume)
        m:play()
    end
end

function Music:stop()
    love.audio.stop()
end

ManageMusic = Music:new()