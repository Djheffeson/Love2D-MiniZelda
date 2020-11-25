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

    love.graphics.draw(sprites.itemFrame, 123,20)
    love.graphics.draw(sprites.itemFrame, 147,20)
    love.graphics.print('B', 128, 17)
    love.graphics.print('A', 152, 17)

    if Player.slot1 == 'wooden_sword' then
        Sword.up:draw(sprites.woodenSword, 147, 25)
    end

    if Player.slot2 == 'wooden_sword' then
        Sword.up:draw(sprites.woodenSword, 123, 25)
    end

    love.graphics.draw(sprites.guiItems, 88 , 16)
    local money = string.format('X%d', Player.money)
    love.graphics.print(money, 96, 16)
    local keys = string.format('X%d', Player.keys)
    love.graphics.print(keys, 96, 32)
    local bombs = string.format('X%d', Player.bombs)
    love.graphics.print(bombs, 96, 40)
end
