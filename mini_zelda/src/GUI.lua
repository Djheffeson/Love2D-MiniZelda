GUI = Class{}

function GUI:init()
    minimap:init()
    heart = sprites.heart_full
    guiY = 0
end

function GUI:update(dt)
    minimap:update(dt)
end

function GUI:draw()
    if gameState == 'menu_continue' then return end
    
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.rectangle('fill', 0, 0+guiY, 256, 56)
    
    love.graphics.setColor(248/255, 56/255, 0, 1)
    love.graphics.print('-LIFE-', 184, 16+guiY)
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
        love.graphics.draw(heart, 176 + space, 40+guiY)
    end

    love.graphics.draw(sprites.itemFrame, 123,20+guiY)
    love.graphics.draw(sprites.itemFrame, 147,20+guiY)
    love.graphics.print('B', 128, 17+guiY)
    love.graphics.print('A', 152, 17+guiY)

    if Player.slot1 == 'wooden_sword' then
        Sword.up:draw(sprites.woodenSword, 147, 25+guiY)
    end

    if Player.slot2 == 'bow' then
        love.graphics.draw(sprites.arrow, 130, 25+guiY)
    end

    love.graphics.draw(sprites.guiItems, 88 , 16+guiY)
    local money
    if Player.money < 100 then
        money = string.format('X%d', Player.money)
    else
        money = string.format('%d', Player.money)
    end
    love.graphics.print(money, 96, 16+guiY)
    local keys = string.format('X%d', Player.keys)
    love.graphics.print(keys, 96, 32+guiY)
    local bombs = string.format('X%d', Player.bombs)
    love.graphics.print(bombs, 96, 40+guiY)

    if Map.type == 'dungeon_1' then
        love.graphics.print('level-1', 16, 8+guiY)
    end
    minimap:draw()
end
