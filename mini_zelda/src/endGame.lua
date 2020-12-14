endGame = {}

function endGameStart()
    endGame.start = false
    endGame.timer = 0
    endGame.moveY = 0.3

    endGame.anim = Player.deathAnimation
    endGame.animX = 52
    endGame.animY = 168
    endGame.animSpeed = 80
end

function endGame:update(dt)

    if endGame.start == true then

        endGame.anim:update(dt)
        if endGame.animX <= 48 then
            endGame.animSpeed = 80
        elseif endGame.animX >= 192 then
            endGame.animSpeed = -80
        end
        endGame.animX = endGame.animX + endGame.animSpeed * dt

        endGame.timer = endGame.timer + 1 * dt
        if endGame.timer <= 8 then
            sounds.getShard:play()

        elseif endGame.timer <= 22 then
            sounds.endingTheme:play()
            writeHere(1, 'you got the last', 68, 100, 0.133)
            writeHere(2, 'triforce shard!', 72, 108, 0.133)

            textWait(3, 1)

            writeHere(4, 'finally,', 100, 180, 0.133)
            writeHere(5, 'peace returns to hyrule.', 36, 192, 0.133)

            textWait(6, 0.5)

            writeHere(7, 'this ends the story.', 51, 208, 0.133)
        elseif guiY >= -VIRTUAL_HEIGHT then
            guiY = guiY - endGame.moveY
        else
            if love.keyboard.isDown('return') then
                love.event.quit()
            end
        end
    end
end

function endGame:draw()
    if endGame.start == true then
        love.graphics.print('thanks for playing!', 56, 38+guiY+VIRTUAL_HEIGHT)
        love.graphics.print('this was my final project', 32, 54+guiY+VIRTUAL_HEIGHT)
        love.graphics.print('for CS50 made in love2d', 40, 62+guiY+VIRTUAL_HEIGHT)
        love.graphics.setColor(179/255, 48/255, 33/255, 1)
        love.graphics.print('credits: nintendo', 62, 88+guiY+VIRTUAL_HEIGHT)
        love.graphics.setColor(88/255, 225/255, 49/255, 1)
        love.graphics.print('coded by djheffeson', 54, 104+guiY+VIRTUAL_HEIGHT)
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.print('yaay', endGame.animX-8, endGame.animY-6+guiY+VIRTUAL_HEIGHT)
        endGame.anim:draw(sprites.linkSheet, endGame.animX, endGame.animY+2+guiY+VIRTUAL_HEIGHT)
        love.graphics.print('press enter to exit', 52, 186+guiY+VIRTUAL_HEIGHT)
    end
end
