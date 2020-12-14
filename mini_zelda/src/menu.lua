menu = {}

menu.continuePos = 72
menu.exitPos = 95

menu.pX = 63
menu.pY = menu.continuePos

menu.waitTimer = 0

function menuReset()
    menu.continuePos = 72
    menu.exitPos = 95
    menu.pX = 63
    menu.pY = menu.continuePos
    menu.waitTimer = 0
end

function menu:update(dt)
    if gameState == 'game_over' and gameState ~= 'menu_continue' then
        menu.waitTimer = menu.waitTimer + 1 * dt
        if menu.waitTimer >= 2.400 then
            gameState = 'menu_continue'
        end
    end

    if gameState == 'menu_continue' then
        
        sounds.menuTheme:play()
        if love.keyboard.isDown('up') then
            menu.pY = menu.continuePos
        
        elseif love.keyboard.isDown('down') then
            menu.pY = menu.exitPos
        end

        if love.keyboard.isDown('return') then
            if menu.pY == menu.continuePos then
                sounds.menuTheme:stop()

                if Map.type == 'overworld' then
                    gameState = 'running'
                    respawnAllEnemies()
                    respawnOverworld()
                    playerRespawn()
                    menuReset()
                    loading = true
                    
                elseif Map.type == 'dungeon_1' then
                    gameState = 'running'
                    respawnAllEnemies()
                    playerRespawn()
                    menuReset()
                    respawnDungeon1()
                    loading = true
                end

            elseif menu.pY == menu.exitPos then
                love.event.quit()
            end
        end
    end
end

function menu:draw()
    if gameState == 'game_over' then

        love.graphics.setColor(0,0,0,1)
        love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)
        love.graphics.setColor(1,1,1,1)
        love.graphics.print('GAME OVER', 96, 136)

    elseif gameState == 'menu_continue' then

        love.graphics.setColor(0,0,0,1)
        love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)
        love.graphics.setColor(1,1,1,1)
        love.graphics.print('CONTINUE', 80, 72)
        love.graphics.print('EXIT', 80, 95)
        love.graphics.draw(sprites.heart_full, menu.pX, menu.pY)

    end
end
