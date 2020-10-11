GAME_PRINT_NAME = "Koglomoglowy Uciekinier"
GAME_PRINT_NAME_SP = "Koglomoglowy,Uciekinier"
GAME_VERSION = "1.2 alpha"

STR_VERSION = "wersja"
STR_DEBUGMODE = " (tryb debugowania)"

LOADSCR_TEXT1 = "Ładowanie"

LoadingHints = {}

function scale(value)
    return love.window.toPixels(value)
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

function drawLargeLogo(x, y)
    x = x or 0
    y = y or 0
    local pc = getPrevColor()
    local pf = love.graphics.getFont()
    local lst = split(GAME_PRINT_NAME_SP, ",")

    setFont("header", 30)
    local fw = love.graphics.getFont():getWidth(lst[1])
    local fh = love.graphics.getFont():getHeight()
    setFont("header", 80)
    fw = math.max(fw, love.graphics.getFont():getWidth(lst[2]) + 20)
    fh = fh + 5 + love.graphics.getFont():getHeight()

    x = x - fw / 2
    y = y - fh / 2 

    setFont("header", 30)
    love.graphics.print(lst[1], x, y)
    fh = love.graphics.getFont():getHeight()
    setFont("header", 80)
    love.graphics.print(lst[2], x + 20, y + fh + 5)

    love.graphics.setColor(pc)
    love.graphics.setFont(pf)
end

function drawVersion()
    setFont("math", 15)
    love.graphics.setColor(gray(255, 1))
    love.graphics.printf("(" .. STR_VERSION .. ": " .. GAME_VERSION .. ")", 0, love.graphics.getHeight() - love.graphics.getFont():getHeight() - 10, love.graphics.getWidth() - 10, "right")  
end

function color(r, g, b, a)
    return {r / 255, (g or r) / 255, (b or r) / 255, a or 1}
end

GAME_COLOR_ACCENT = color(255, 163, 22, 1)

function gray(l, a)
    return {l / 255, l / 255, l / 255, a or 1}
end

function getPrevColor()
    local r, g, b, a = love.graphics.getColor()
    return {r, g, b, a}
end

function split(pString, pPattern)
    local Table = {}  
    local fpat = "(.-)" .. pPattern
    local last_end = 1
    local s, e, cap = pString:find(fpat, 1)
    while s do
        if s ~= 1 or cap ~= "" then
        table.insert(Table,cap)
        end
        last_end = e+1
        s, e, cap = pString:find(fpat, last_end)
    end
    if last_end <= #pString then
        cap = pString:sub(last_end)
        table.insert(Table, cap)
    end
    return Table
end

local moonshine = require("libs/moonshine")

blurEffect = moonshine(moonshine.effects.boxblur)

__mpx, __mpy = -1, -1

function mouseIsPressed(x, y)
    return __mpx == x and __mpy == y
end

function love.mousepressed(x, y, button, istouch)
    if button == 1 then 
        __mpx = x
        __mpy = y
    else
        __mpx = -1
        __mpy = -1
    end
end