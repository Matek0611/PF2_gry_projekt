--np. setFont(true, 25)
function setFont(isheader, size)
    size = size or 16
    local afont = nil
    if isheader then
        afont = love.graphics.newFont("assets/font/sansitaswashed.ttf", size)
    else 
        afont = love.graphics.newFont("assets/font/roboto.ttf", size)
    end
    love.graphics.setFont(afont)
end

function drawFPS()
    love.graphics.setFont(love.graphics.newFont(20))
    love.graphics.print(tostring(love.timer.getFPS()), 0, 0)
end