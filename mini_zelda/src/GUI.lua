GUI = Class{}

function GUI:init()
    heart_full = love.graphics.newImage('assets/graphics/heart_full.png')
    heart_half = love.graphics.newImage('assets/graphics/heart_half.png')
    heart_empty = love.graphics.newImage('assets/graphics/heart_empty.png')

    heart = heart_full
end

function GUI:update(dt)

end
-- 176
-- 28
function GUI:draw()
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.rectangle('fill', 0, 0, 256, 48)
    love.graphics.setColor(1, 1, 1, 1)
    
    for i = 1, Player.max_hearts - 0 do 
        
        if i <= Player.hearts then
            heart = heart_full
        elseif i - Player.hearts == 0.5 then
            heart = heart_half
        elseif i > Player.hearts then
            heart = heart_empty
        end
        local space = (i - 1) * 8
        love.graphics.draw(heart, 176 + space, 28)
    end
end