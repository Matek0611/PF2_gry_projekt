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
    splashy.addSplash(love.graphics.newImage("assets/img/logo.png"), 2, 0, 5)
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
        love.graphics.setBackgroundColor(gray(255, 1))
        splashy.draw()
    end
end

function splashUpdate(dt)
    if endof then
        local tu = stw:update(dt)
        if tu then
            LoadingScreen.onFinish = (function () 
                menuUpdate()
                gm = GM_MENU
            end)
            LoadingScreen:setLoading(true)
        end
    else
        splashy.update(dt)
    end
end