require("utf8")
require("menu")
require("globals")
require("gamemode")
require("splash")

function love.load() 
    love.window.setTitle(" ")
    love.window.setMode(1280, 720, {resizable=true, minwidth=800, minheight=600})

    splashInit()
    menuInit()
end

function love.draw()
    if gm == GM_SPLASH then
        splashDraw()
    elseif gm == GM_MENU then 
        menuDraw()
    end

    drawFPS()
end

function love.update(dt)
    if gm == GM_SPLASH then
        splashUpdate(dt)
    elseif gm == GM_MENU then 
        menuUpdate(dt)
    end
end