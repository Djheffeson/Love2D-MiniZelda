endGame = {}

function endGameStart()
    endGame.start = false
    endGame.timer = 0
    endGame.moveY = 0.3
end

function endGame:update(dt)
    if endGame.start == true then
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
            print(guiY)
            guiY = guiY - endGame.moveY
        else
            if love.keyboard.isDown('return') then
                love.event.quit()
            end
        end
    end
    
end

function endGame:draw()
    love.graphics.print('this is was my final\n  project for CS50!', 50, 38+VIRTUAL_HEIGHT+guiY)
    love.graphics.print('made in love2d', 74, 62+VIRTUAL_HEIGHT+guiY)
    love.graphics.setColor(88/255, 225/255, 49/255, 1)
    love.graphics.print('coded by djheffeson', 54, 90+VIRTUAL_HEIGHT+guiY)
    love.graphics.setColor(179/255, 48/255, 33/255, 1)
    love.graphics.print('credits: nintendo', 62, 106+VIRTUAL_HEIGHT+guiY)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.print('thanks for playing!', 56, 170+VIRTUAL_HEIGHT+guiY)
    love.graphics.print('press enter to close the game', 12, 186+VIRTUAL_HEIGHT+guiY)
end
