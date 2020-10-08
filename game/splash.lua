local splashy = require("libs/splashy")
local gamem = require("gamemode")

function splashInit()
    splashy.addSplash(love.graphics.newImage("assets/img/test.png"), 2, -1, 5)
    splashy.onComplete(function() 
        gm = GM_MENU 
        love.graphics.setColor(0, 0, 0, 0) 
    end)
end

function splashDraw()
    splashy.draw()
end

function splashUpdate(dt)
    splashy.update(dt)
end