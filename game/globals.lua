GAME_PRINT_NAME = "Koglomoglowy Uciekinier"
GAME_VERSION = "1.0 alpha"

STR_VERSION = "wersja"
STR_DEBUGMODE = " (tryb debugowania)"

DEBUG_MODE = true
OPTS_FPS_ON = false --przenieść do ustawień

function globalsTranslate()

end

function setFont(name, size)
    size = size or 16
    local afont = nil

    if name == "header" then
        afont = love.graphics.newFont("assets/font/sansitaswashed.ttf", size)
    elseif name == "text" then
        afont = love.graphics.newFont("assets/font/roboto.ttf", size)
    elseif name == "math" then 
        afont = love.graphics.newFont("assets/font/lmroman10.otf", size)
    else
        afont = love.graphics.newFont(size)
    end

    love.graphics.setFont(afont)
end

function drawFPS()
    local r, g, b, a = love.graphics.getColor()
    local oldf = love.graphics.getFont()

    love.graphics.setColor(1, 0, 0, 1)
    setFont("math", 20)
    local db = (DEBUG_MODE and STR_DEBUGMODE or "") 
    love.graphics.print(" " .. tostring(love.timer.getFPS() .. db), 0, 0)
    
    love.graphics.setColor(r, g, b, a)
    love.graphics.setFont(oldf)
end

function color(r, g, b, a)
    return {r / 255, (r or g) / 255, (r or b) / 255, a or 1}
end

function gray(l, a)
    return {l / 255, l / 255, l / 255, a or 1}
end