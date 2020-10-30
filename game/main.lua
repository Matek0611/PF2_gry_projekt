local utf8 = require("utf8")
local menu = require("menu")
local globals = require("globals")
local gamemode = require("gamemode")
local splash = require("splash")
local translation = require("translation")
local loading = require("loading")
local options = require("options")

function love.load() 
    love.window.setMode(1280, 720, {resizable=true, minwidth=800, minheight=600, msaa=3})
    love.window.setIcon(love.image.newImageData("assets/img/ikona1.png"))
    love.graphics.setDefaultFilter("nearest", "nearest")
    love.graphics.setBackgroundColor(gray(255, 1))

    ManageOpts:load()

    if SPLASH_VISIBLE then
        splashInit()
    else
        gm = GM_MENU
    end
    menuInit()

    translateAll("en")
end

function love.quit()
    ManageOpts:save()
end

function love.draw()
    blurEffect.resize(love.graphics.getWidth(), love.graphics.getHeight())

    if LoadingScreen:isLoading() then
        LoadingScreen:draw()
    elseif gm == GM_SPLASH and SPLASH_VISIBLE then
        splashDraw()
    elseif gm == GM_MENU then 
        menuDraw()
    elseif gm == GM_MAP then 
        
    end

    if GLOBAL_OPTIONS.DEBUG_MODE or GLOBAL_OPTIONS.OPTS_FPS_ON then
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