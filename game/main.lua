local utf8 = require("utf8")
local menu = require("menu")
local globals = require("globals")
local gamemode = require("gamemode")
local splash = require("splash")
local translation = require("translation")
local loading = require("loading")
local options = require("options")
local newgame = require("newgame")
local music = require("music")
local world = require("world")

function love.load() 
    math.randomseed(os.time())

    love.window.setMode(1280, 720, {resizable=true, minwidth=800, minheight=600, msaa=3})
    love.window.setIcon(love.image.newImageData("assets/img/ikona1.png"))
    love.graphics.setDefaultFilter("nearest", "nearest")
    love.graphics.setBackgroundColor(gray(255, 1))
    -- love.window.setFullscreen(true, "exclusive")

    ManageOpts:load()

    if SPLASH_VISIBLE then
        splashInit()
    else
        gm = GM_MENU
    end
    menuInit()

    translateAll(GLOBAL_OPTIONS.OPTS_LANG)

    ManageMusic:play("loading")
end

function love.quit()
    ManageMusic:stop()
    ManageOpts:save()
end

function love.draw()
    if LoadingScreen:isLoading() then
        LoadingScreen:draw()
    elseif gm == GM_SPLASH and SPLASH_VISIBLE then
        splashDraw()
    elseif gm == GM_MENU then 
        menuDraw()
    elseif gm == GM_MAP then 
        ActiveWorld:draw()
    end

    if GLOBAL_OPTIONS.DEBUG_MODE or GLOBAL_OPTIONS.OPTS_FPS_ON then
        drawFPS()
    end
end

function love.update(dt)
    GlobalTextItemEffect:update(dt)

    if LoadingScreen:isLoading() then
        LoadingScreen:update(dt)
    elseif gm == GM_SPLASH and SPLASH_VISIBLE then
        splashUpdate(dt)
    elseif gm == GM_MENU then 
        menuUpdate(dt)
    elseif gm == GM_MAP then
        ActiveWorld:update(dt)
    end
end

function love.resize(w, h)
    if LoadingScreen:isLoading() then
        LoadingScreen:updateSize()
    elseif gm == GM_MAP then
        ActiveWorld:updateSize()
    end
end