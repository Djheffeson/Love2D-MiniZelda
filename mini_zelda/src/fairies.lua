fairies = {}

function spawnFairy(x, y)
    local fairy = {}

    fairy.x = x
    fairy.y = y
    fairy.heal = false
    fairy.heartsShow = false

    local grid = anim8.newGrid(8, 16, sprites.fairy:getWidth(), sprites.fairy:getHeight())
    fairy.animation = anim8.newAnimation(grid('1-2', 1), 0.07)

    fairy.timerHeal = 0
    fairy.timerHealing = 0
    fairy.timerHeart = 1

    sounds.getItem:play()
    table.insert(fairies, fairy)

end

function fairies:update(dt)

    if gameState == 'changingRoom' then
        fairiesDelete()
        heartsDelete()
    end

    for i, fairy in ipairs(fairies) do

        fairy.animation:update(dt)

        -- anim the hearts
        for j, heart in ipairs(hearts) do
            heart.x = fairy.x + heart.radius * math.cos(heart.angle)
            heart.y = (fairy.y + 22) + heart.radius * math.sin(heart.angle)
            heart.angle = heart.angle - math.pi * dt
        end

        -- check if the player is on the healing area
        if (Player.x >= 120 and Player.x <= 136) and (Player.y <= 184 and Player.y >= 168) and fairy.heal == false then
            fairy.heartsShow = true
            fairyHeal(dt)
        end

        if fairy.heartsShow then

            fairy.timerHeart = fairy.timerHeart + 1 * dt
            if fairy.timerHeart >= 0.25 and #hearts < 8 then
                createHearts()
                fairy.timerHeart = 0
            end

            if fairy.heal == true then
                fairy.timerHealing = fairy.timerHealing + 1 * dt
                if fairy.timerHealing >= 2 then
                    fairy.timerHealing = 0
                    fairy.heartsShow = false
                    Player.isHealing = false
                    heartsDelete()
                end
            end

        end
    end
end

function fairies:draw()
    
    for i, heart in ipairs(hearts) do
        love.graphics.draw(sprites.heart_full, heart.x, heart.y)
    end

    for i, fairy in ipairs(fairies) do
        fairy.animation:draw(sprites.fairy, fairy.x, fairy.y)
    end
end

function fairyHeal(dt)
    for i, fairy in ipairs(fairies) do

        Player.isHealing = true
        sounds.refillLoop:play()

        fairy.timerHeal = fairy.timerHeal + 1 * dt
        if fairy.timerHeal >= 0.2 and Player.hearts < Player.max_hearts then
            playerHeal(0.5)
            fairy.timerHeal = 0
        end

        if Player.hearts == Player.max_hearts then
            fairy.heal = true
            sounds.text:play()
        end
        
    end
end

function fairiesDelete()
    for i, fairy in ipairs(fairies) do
        table.remove(fairies, i)
    end
end

hearts = {}

function createHearts()
    local heart = {}
    heart = {}
    heart.x = 0
    heart.y = 0
    heart.radius = 50
    heart.angle = math.pi + math.rad(90)
    table.insert(hearts, heart)
end

function heartsDelete()
    for i=#hearts, 0, -1 do
        table.remove(hearts, i)
    end
end
