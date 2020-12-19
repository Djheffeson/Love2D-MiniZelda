minimap = {}

function minimap:init()
    minimap.x = 24
    minimap.y = 28

    minimap.playerX = 42
    minimap.playerY = 44

    minimap.targetX = 66
    minimap.targetY = 28

    minimap.change = true
end

function minimap:update(dt)

    if gameState == 'changingRoom' or gameState == 'animation' then
        minimap.change = false
    end

    if direct == 'up' and gameState == 'running' and minimap.change == false then
        minimap.playerY = minimap.playerY - 4
        minimap.change = true

    elseif direct == 'down' and gameState == 'running' and minimap.change == false then
        minimap.playerY = minimap.playerY + 4
        minimap.change = true

    elseif direct == 'left' and gameState == 'running' and minimap.change == false then
        minimap.playerX = minimap.playerX - 8
        minimap.change = true

    elseif direct == 'right' and gameState == 'running' and minimap.change == false then
        minimap.playerX = minimap.playerX + 8
        minimap.change = true
    end

    if Map.type == 'overworld' and currentOverworldRoom == 3 then
        minimap.playerX = 34
        minimap.playerY = 28
    elseif Map.type == 'dungeon_1' and currentDungeonRoom == 27 then
        minimap.playerX = 42
        minimap.playerY = 44
    end
end

function minimap:draw()

    if Map.type == 'dungeon_1' then
        if Player.hasMap1 then
            love.graphics.draw(sprites.minimap1, minimap.x, minimap.y+guiY)
        end

        if Player.hasCompass1 then
            if math.floor(math.cos(love.timer.getTime() * 4 % 2 * math.pi)) == 0 then
                love.graphics.setColor(1, 0, 0, 1)
            else
                love.graphics.setColor(0.5, 0, 0, 1)
            end
            love.graphics.rectangle('fill', minimap.targetX, minimap.targetY+guiY, 3, 3)
        end

        love.graphics.setColor(0, 1, 0, 1)
        love.graphics.rectangle('fill', minimap.playerX, minimap.playerY+guiY, 3, 3)
        love.graphics.setColor(1, 1, 1, 1)

    elseif Map.type == 'overworld' then
        love.graphics.setColor(0.5, 0.5, 0.5, 1)
        love.graphics.rectangle('fill', 16, 16, 64, 32)
        love.graphics.setColor(0, 1, 0, 1)
        love.graphics.rectangle('fill', minimap.playerX, minimap.playerY+guiY, 3, 3)
        love.graphics.setColor(1, 1, 1, 1)
    end

end
