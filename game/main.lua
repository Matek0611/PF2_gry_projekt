local utf8 = require("utf8")
local menu = require("menu")
local globals = require("globals")
local gamemode = require("gamemode")
local splash = require("splash")
local translation = require("translation")
local loading = require("loading")

function love.load() 
    love.window.setMode(1280, 720, {resizable=true, minwidth=800, minheight=600, msaa=3})
    love.graphics.setDefaultFilter("nearest", "nearest")
    love.graphics.setBackgroundColor(color(255, 1))

    if SPLASH_VISIBLE then
        splashInit()
    else
        gm = GM_MENU
    end
    menuInit()

    translateAll()
end

function love.draw()
    if LoadingScreen:isLoading() then
        LoadingScreen:draw()
    elseif gm == GM_SPLASH and SPLASH_VISIBLE then
        splashDraw()
    elseif gm == GM_MENU then 
        menuDraw()
    end

    if DEBUG_MODE or OPTS_FPS_ON then
        drawFPS()
    end
end

function love.update(dt)
    if LoadingScreen:isLoading() then
        LoadingScreen:update(dt)
    elseif gm == GM_SPLASH and SPLASH_VISIBLE then
        splashUpdate(dt)
    elseif gm == GM_MENU then 
        menuUpdate(dt)
    end
end