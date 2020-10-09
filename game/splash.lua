local splashy = require("libs/splashy")
local tween = require("libs/splashy/tween")
local gamem = require("gamemode")
local menu = require("menu")

SPLASH_VISIBLE = true

subjectdata = {}
subjectdata.r, subjectdata.g, subjectdata.b, subjectdata.a = love.graphics.getBackgroundColor()
subjectdata.rgba = {subjectdata.r, subjectdata.g, subjectdata.b, subjectdata.a}
stw = nil
endof = false

function splashInit()
    splashy.addSplash(love.graphics.newImage("assets/img/test.png"), 2, -1, 5)
    splashy.onComplete(function() 
        endof = true
        subjectdata.r, subjectdata.g, subjectdata.b, subjectdata.a = love.graphics.getBackgroundColor()
        subjectdata.rgba = {subjectdata.r, subjectdata.g, subjectdata.b, subjectdata.a}
        stw = tween.new(1, subjectdata, {rgba = MENU_BG_COLOR}, 'outSine')
    end)
end

function splashDraw()
    if endof then
        love.graphics.setBackgroundColor(subjectdata.rgba)
    else
        splashy.draw()
    end
end

function splashUpdate(dt)
    if endof then
        local tu = stw:update(dt)
        if tu then
            gm = GM_MENU
        end
    else
        splashy.update(dt)
    end
end