GAME_PRINT_NAME = "Koglomoglowy Uciekinier"
GAME_PRINT_NAME_SP = "Koglomoglowy,Uciekinier"
GAME_VERSION = "1.6 alpha"
GAME_AUTHOR = "Marcin Stefanowicz"
GAME_MUSIC = "Dan Henig\nDJ Freedem\nPatrick Patrikios\nDJ Williams\nKwon\nVans in Japan"

STR_VERSION = "wersja"
STR_DEBUGMODE = " (tryb debugowania)"

LOADSCR_TEXT1 = "Ładowanie"

LoadingHints = {}

function math.round(x)
    return math.floor(x + 0.5)
end

local ItemEffect = require("libs/basics/ItemEffect")

GlobalTextItemEffect = ItemEffect:new(0, 0, 0, 10, 1, 1)
GlobalTextItemEffect:start()

function scale(value)
    return love.window.toPixels(value)
end

FontHeader = {}
for i = 1, 100 do
    FontHeader[#FontHeader + 1] = love.graphics.newFont("assets/font/sansitaswashed.ttf", i)
end
FontText = {}
for i = 1, 100 do
    FontText[#FontText + 1] = love.graphics.newFont("assets/font/roboto.ttf", i)
end
FontMath = {}
for i = 1, 100 do
    FontMath[#FontMath + 1] = love.graphics.newFont("assets/font/lmroman10.otf", i)
end
FontDef = {}
for i = 1, 100 do
    FontDef[#FontDef + 1] = love.graphics.newFont(i)
end

function setFont(name, size)
    size = size or 16
    local afont = nil

    if name == "header" then
        afont = FontHeader[size]
    elseif name == "text" then
        afont = FontText[size]
    elseif name == "math" then 
        afont = FontMath[size]
    else
        afont = FontDef[size]
    end

    love.graphics.setFont(afont)
end

function drawFPS()
    local r, g, b, a = love.graphics.getColor()
    local oldf = love.graphics.getFont()

    love.graphics.setColor(1, 0, 0, 1)
    setFont("math", 20)
    local db = (GLOBAL_OPTIONS.DEBUG_MODE and STR_DEBUGMODE or "") 
    love.graphics.print(" " .. tostring(love.timer.getFPS() .. db), 0, 0)
    
    love.graphics.setColor(r, g, b, a)
    love.graphics.setFont(oldf)
end

MOUSE_MOVE_X = 0
MOUSE_MOVE_Y = 0

function love.mousemoved(x, y, dx, dy, istouch) 
    MOUSE_MOVE_X = x
    MOUSE_MOVE_Y = y
end

function drawLargeLogo(x, y, ifanim)
    ifanim = ifanim or false

    x = (x or 0)
    y = (y or 0)

    if ifanim then
        x = x + (MOUSE_MOVE_X - love.graphics.getWidth() / 2)*0.065
        y = y + (MOUSE_MOVE_Y - love.graphics.getHeight() / 2)*0.065
    else
        y = y + GlobalTextItemEffect.currenty
    end

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

function drawVersion(color)
    setFont("math", 15)
    love.graphics.setColor(color or gray(255, 1))
    love.graphics.printf("(" .. STR_VERSION .. ": " .. GAME_VERSION .. ")", 0, love.graphics.getHeight() - love.graphics.getFont():getHeight() - 10, love.graphics.getWidth() - 10, "right")  
end

function color(r, g, b, a)
    return {r / 255, (g or r) / 255, (b or r) / 255, a or 1}
end

GAME_COLOR_ACCENT = color(255, 163, 22, 1)

function gray(l, a)
    return {l / 255, l / 255, l / 255, a or 1}
end

function changealpha(c, alpha) 
    local r, g, b, a = c[1], c[2], c[3], c[4]
    a = alpha
    return {r, g, b, a} 
end

function colordarken(c, x) 
    local r, g, b, a = c[1], c[2], c[3], c[4]
    return {r - x, g - x, b - x, a} 
end

function colorlighten(c, x) 
    local r, g, b, a = c[1], c[2], c[3], c[4]
    return {r + x, g + x, b + x, a} 
end

function colorlight(c, x) 
    local r, g, b, a = c[1], c[2], c[3], c[4]
    return {r * x, g * x, b * x, a} 
end

function getPrevColor()
    local r, g, b, a = love.graphics.getColor()
    return {r, g, b, a}
end

clBlack = gray(0, 1)
clWhite = gray(255, 1)

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

__mpx, __mpy = -1, -1

function mouseIsPressed(x, y)
    return __mpx == x and __mpy == y
end

function love.mousereleased(x, y, button)
    if button == 1 then 
        __mpx = x
        __mpy = y
    else
        __mpx = -1
        __mpy = -1
    end
end

local COLOR_MUL = love._version >= "11.0" and 1 or 255
 
function gradientMesh(dir, ...)
    -- Check for direction
    local isHorizontal = true
    if dir == "vertical" then
        isHorizontal = false
    elseif dir ~= "horizontal" then
        error("bad argument #1 to 'gradient' (invalid value)", 2)
    end
 
    -- Check for colors
    local colorLen = select("#", ...)
    if colorLen < 2 then
        error("color list is less than two", 2)
    end
 
    -- Generate mesh
    local meshData = {}
    if isHorizontal then
        for i = 1, colorLen do
            local color = select(i, ...)
            local x = (i - 1) / (colorLen - 1)
 
            meshData[#meshData + 1] = {x, 1, x, 1, color[1], color[2], color[3], color[4] or (1 * COLOR_MUL)}
            meshData[#meshData + 1] = {x, 0, x, 0, color[1], color[2], color[3], color[4] or (1 * COLOR_MUL)}
        end
    else
        for i = 1, colorLen do
            local color = select(i, ...)
            local y = (i - 1) / (colorLen - 1)
 
            meshData[#meshData + 1] = {1, y, 1, y, color[1], color[2], color[3], color[4] or (1 * COLOR_MUL)}
            meshData[#meshData + 1] = {0, y, 0, y, color[1], color[2], color[3], color[4] or (1 * COLOR_MUL)}
        end
    end
 
    -- Resulting Mesh has 1x1 image size
    return love.graphics.newMesh(meshData, "strip", "static")
end

kursor_glowny = love.mouse.newCursor(love.image.newImageData("assets/img/cursor_arrow_icon24.png"), 0, 0)
love.mouse.setCursor(kursor_glowny)

function dup2tab(table)
    r = {}
    for k, v in pairs(table) do
        r[k] = v
    end
    return r
end