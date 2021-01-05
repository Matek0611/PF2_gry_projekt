local Class = require("libs/basics/middleclass")
local Button = require("libs/basics/Button")
local Scene = require("libs/basics/Scene")
local Scenes = require("libs/basics/Scenes")
local globals = require("globals")
local gamemode = require("gamemode")
local music = require("music")
local Hero = require("libs/objects/hero")
local herosdesc = require("libs/heros/herosdesc")
local hSieska = require("libs/heros/sieska")
local hMyniek = require("libs/heros/myniek")
local hAntywola = require("libs/heros/antywola")
local hPusia = require("libs/heros/pusia")
local translation = require("translation")
local world = require("world")
local activeworld = require("activeworld")
local ItemEffect = require("libs/basics/ItemEffect")

local ceffect = ItemEffect:new(0, 0, 0, 0, 1, 30)
ceffect.ds = 1
ceffect:start()

local wSieska = hSieska:new()
wSieska.canmove = false
local wMyniek = hMyniek:new()
wMyniek.canmove = false
local wAntywola = hAntywola:new()
wAntywola.canmove = false
local wPusia = hPusia:new()
wPusia.canmove = false

local wHeroes = {wSieska, wMyniek, wAntywola, wPusia}
local wHero = 1

local btnReturn = Button:new(0, 0, 50, 50, "<<")
btnReturn.rx, btnReturn.ry = 25, 25
btnReturn.fontname = "text"
btnReturn.onClick = (function(sender) 
    MenuScenes:setActive(2)
end)

local btnStart = Button:new(0, 0, 320, 100, TEXT_NEWGAME_TITLE)
btnStart.rx, btnStart.ry = 50, 50
btnStart.colors = dup2tab(BTN_WHITE_THEME_ACCENT)
btnStart.colors.font = {
    normal = GAME_COLOR_ACCENT,
    hover = GAME_COLOR_ACCENT,
    down = gray(255, 1),
    disabled = gray(0, 1)
}
btnStart.onClick = (function(sender)
    local h
    if wHeroes[wHero] == wSieska then
        h = hSieska:new()
    elseif wHeroes[wHero] == wMyniek then
        h = hMyniek:new()
    elseif wHeroes[wHero] == wAntywola then
        h = hAntywola:new()
    else
        h = hPusia:new()
    end
    ActiveWorld = world:new(h)

    LoadingScreen.onFinish = (function (sender) 
        ActiveWorld:updateSize()
        gm = GM_MAP
        ManageMusic.volume = ManageMusic.defvolume
        ManageMusic:play("level1")
        sender.onUpdate = nil
        ActiveWorld:startTimer()
    end)
    LoadingScreen:setLoading(true)
end)

lbHeroName = Button:new(0, 0, 280, 80, wHeroes[wHero].name)
lbHeroName.shadow = false
lbHeroName.static = true
lbHeroName.fontsize = 30

btnPrevHero = Button:new(0, 0, 90, 80, "<")
btnPrevHero.rx, btnPrevHero.ry = 10, 10
btnPrevHero.colors = dup2tab(BTN_BLACK_THEME_ACCENT)
btnPrevHero.shadow = false
btnPrevHero.downeffect = false
btnPrevHero.fontname = "text"
btnPrevHero.onClick = (function (sender) 
    if wHero == 1 then 
        wHero = #wHeroes
    else
        wHero = wHero - 1
    end 
end)

btnNextHero = Button:new(0, 0, 90, 80, ">")
btnNextHero.rx, btnNextHero.ry = 10, 10
btnNextHero.colors = dup2tab(BTN_BLACK_THEME_ACCENT)
btnNextHero.fontname = "text"
btnNextHero.shadow = false
btnNextHero.downeffect = false
btnNextHero.onClick = (function (sender) 
    if wHero == #wHeroes then 
        wHero = 1
    else
        wHero = wHero + 1
    end 
end)

local PARTICLES_1 = love.graphics.newParticleSystem(love.graphics.newImage("assets/img/particle1.png"), 100)
PARTICLES_1:setParticleLifetime(1, 8)
PARTICLES_1:setEmissionRate(8)
PARTICLES_1:setSizes(1, 0.8, 0.6, 0.5, 0.3, 0.2, 0.1)
PARTICLES_1:setSizeVariation(0.2)
PARTICLES_1:setLinearAcceleration(-50, -50, 50, 50)
PARTICLES_1:setColors(1, 1, 1, 1, 1, 1, 1, 0)

local PARTICLES_2 = love.graphics.newParticleSystem(love.graphics.newImage("assets/img/particle_cursor.png"), 100)
PARTICLES_2:setParticleLifetime(1, 8)
PARTICLES_2:setEmissionRate(30)
PARTICLES_2:setSizes(2, 1.8, 1.6, 1.5, 1.3, 1.2, 1)
PARTICLES_2:setSizeVariation(0.2)
PARTICLES_2:setLinearAcceleration(-50, -50, 50, 50)
PARTICLES_2:setColors(1, 1, 1, 1, 1, 1, 1, 0)

local gradient_bg = gradientMesh("vertical", gray(45, 1), gray(30, 1))

local function NewGameSceneDraw()
    love.graphics.draw(gradient_bg, 0, 0, 0, love.graphics.getDimensions())

    love.graphics.draw(PARTICLES_1, love.graphics.getWidth() * 0.5, love.graphics.getHeight() - 100 - 10)
    love.graphics.draw(PARTICLES_2, wHeroes[wHero].position.x + wHeroes[wHero].scalefrom / 2, wHeroes[wHero].position.y + wHeroes[wHero].scalefrom / 2)

    local pc = getPrevColor()

    love.graphics.setColor(GAME_COLOR_ACCENT)
    setFont("header", 35)
    love.graphics.printf(TEXT_NEWGAME_HEADER, 0, 15, love.graphics.getWidth(), "center")

    btnPrevHero:draw()
    btnNextHero:draw()
    lbHeroName:draw()

    love.graphics.setColor(clWhite)
    setFont("text", 20)
    love.graphics.printf(wHeroes[wHero].description, 0, 210, love.graphics.getWidth(), "center")

    love.graphics.setColor(pc)

    wHeroes[wHero]:draw()

    btnReturn:draw()
    btnStart:draw()
end

local function NewGameSceneUpdate(dt)
    btnReturn:update(dt)
    btnStart:update(dt)
    PARTICLES_1:update(dt or 0)
    PARTICLES_2:update(dt or 0)

    ceffect:update(dt)

    wHeroes[wHero]:update(dt)
    
    btnPrevHero:update(dt)
    btnNextHero:update(dt)
    lbHeroName.text = wHeroes[wHero].name
    lbHeroName:update(dt)
end

local function NewGameSceneiUpdate()
    btnReturn:setPosition(45, love.graphics.getHeight() / 2)
    btnStart:setPosition(love.graphics.getWidth() / 2, love.graphics.getHeight() - 110 + GlobalTextItemEffect.currenty)
    
    lbHeroName:setPosition(love.graphics.getWidth() / 2, 150)
    btnPrevHero:setPosition((love.graphics.getWidth() - lbHeroName.width - btnPrevHero.width) / 2 + 20, lbHeroName.position.y)
    btnNextHero:setPosition((love.graphics.getWidth() + lbHeroName.width + btnNextHero.width) / 2 - 20, lbHeroName.position.y)

    for i = 1, #wHeroes do 
        wHeroes[i].scalefrom = math.round(love.graphics.getHeight() / 720 * 100)
        wHeroes[i]:setCenterPosition(love.graphics.getWidth() / 2, love.graphics.getHeight() / 2 + 20)
    end
end

NewGameScene = Scene:new("newgame", NewGameSceneDraw, NewGameSceneUpdate, NewGameSceneiUpdate)

