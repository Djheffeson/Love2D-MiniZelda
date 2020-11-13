GUI = Class{}

function GUI:init()
    heart = sprites.heart_full
end

function GUI:update(dt)

end

function GUI:draw()
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.rectangle('fill', 0, 0, 256, 56)
    
    love.graphics.setColor(248/255, 56/255, 0, 1)
    love.graphics.print('-LIFE-', 184, 16)
    love.graphics.setColor(1, 1, 1, 1)
    for i = 1, Player.max_hearts - 0 do 
        
        if i <= Player.hearts then
            heart = sprites.heart_full
        elseif i - Player.hearts == 0.5 then
            heart = sprites.heart_half
        elseif i > Player.hearts then
            heart = sprites.heart_empty
        end
        local space = (i - 1) * 8
        love.graphics.draw(heart, 176 + space, 40)
    end
end