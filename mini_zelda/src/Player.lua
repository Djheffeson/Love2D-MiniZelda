Player = Class{}

PLAYER_WIDTH = 16
PLAYER_HEIGHT = 16
WALK_SPEED = 80

function playerRespawn()
    baw = false
    Player.hearts = 3
    Player.x = 130
    Player.y = 150

    Player.collider:setPosition(Player.x, Player.y)

    Player.isMoving = false
    Player.state = 'walking'
    Player.direction = 'up'
    Player.invincible = false
    Player.receive_damage = false
    Player.grabbed = false
    Player.visible = true

    Player.currentAnimation = Player.walkUp

    Player.timer = 0
    Player.animationTimer = 0
    Player.waitTimer = 0
    Player.deathAnimTimer = 0
    Player.waitMenuTimer = 0
end

function Player:init()

    Player.x = 130
    Player.y = 150

    -- Create a vector for collision
    Player.vectorX = 0
    Player.vectorY = 0

    Player.isMoving = false
    Player.state = 'walking'
    Player.direction = 'up'
    Player.invincible = false
    Player.receive_damage = false
    Player.grabbed = false
    Player.visible = true

    Player.slot1 = nil
    Player.slot2 = nil

    Player.maxMoney = 255
    Player.money = 0
    Player.keys = 0
    Player.bombs = 0
    Player.max_hearts = 3
    Player.hearts = Player.max_hearts
    
    Player.enterInClosedDoor = false
    Player.exitEntrance = true
    Player.walkDistance = 16

    Player.collider = world:newCircleCollider(Player.x, Player.y, 5)
    Player.collider:setCollisionClass('Player')
    Player.collider:setObject(Player)
    
    -- Create the animation of the player
    walkGrid = anim8.newGrid(PLAYER_WIDTH, PLAYER_HEIGHT, 
        sprites.linkSheet:getWidth(), sprites.linkSheet:getHeight())
    
    Player.walkDown = anim8.newAnimation(walkGrid('1-2', 1), 0.1)
    Player.walkRight = anim8.newAnimation(walkGrid('1-2', 2), 0.1)
    Player.walkLeft = anim8.newAnimation(walkGrid('1-2', 2), 0.1):flipH()
    Player.walkUp = anim8.newAnimation(walkGrid('1-2', 3), 0.1)
    Player.currentAnimation = Player.walkUp

    Player.attackDown = anim8.newAnimation(walkGrid(3,1, 3,1, 3,1), {0.07, 0.077, 0.07}, attackComplete)
    Player.attackRight = anim8.newAnimation(walkGrid(3,2, 3,2, 3,2), {0.07, 0.077, 0.07}, attackComplete)
    Player.attackLeft = anim8.newAnimation(walkGrid(3,2, 3,2, 3,2), {0.07, 0.077, 0.07}, attackComplete):flipH()
    Player.attackUp = anim8.newAnimation(walkGrid(3,3, 3,3, 3,3), {0.07, 0.077, 0.07}, attackComplete)

    Player.holdingSword = anim8.newAnimation(walkGrid(1, 5), 1)
    Player.holdingItem = anim8.newAnimation(walkGrid(2, 5), 1)

    Player.deathAnimation = anim8.newAnimation(walkGrid(1, '1-4'), 0.083)

    Player.timer = 0
    Player.animationTimer = 0
    Player.waitTimer = 0

    Player.deathAnimTimer = 0
    Player.waitMenuTimer = 0
    Player.timerHoldingItem = 0
end

function Player:update(dt)

    if Player.state == 'dead' then

        Player.waitMenuTimer = Player.waitMenuTimer + 1 * dt
        if Player.waitMenuTimer >= 0.750 then
            gameState = 'game_over'
        end
        return

    end

    if writing == true then
        Player.collider:setLinearVelocity(0, 0)
        return
    end

    if Player.hearts <= 0 and Player.state ~= 'dead' then
        sounds.overworldTheme:stop()
        sounds.dungeonTheme:stop()
        deleteItems()
        deleteAllEntities()
        gameState = 'death'

        Player.deathAnimTimer = Player.deathAnimTimer + 1 * dt

        if Player.deathAnimTimer <= 1 then
            Player.currentAnimation = Player.walkDown

        elseif Player.deathAnimTimer <= 2.250 then
            Player.currentAnimation = Player.deathAnimation
            Player.currentAnimation:update(dt)
            sounds.deathMusic:play()

        elseif Player.deathAnimTimer <= 3.200 then
            Player.currentAnimation = Player.walkDown

            if Player.deathAnimTimer >= 2.800 then
                baw = true
            end

        elseif #deaths == 0 then
            Player.state = 'dead'
            deathSpawn(Player.x-6.2, Player.y-10, 0)
        end

        if Player.hearts < 0 then Player.hearts = 0 end
        return
    end

    if Player.grabbed == true then
        Player.currentAnimation:update(dt)
        Player.collider:setLinearVelocity(0, 0)
        Player.x, Player.y = Player.collider:getPosition()
        return
    end

    if Player.enter == true then
        gameState = 'animation'
        playerEnterAnimation(dt)
    end

    if Player.out == true then
        gameState = 'animation'
        playerOutAnimation(dt)
    end

    if Player.enterInUndergroundRoom == true then
        gameState = 'animation'
        playerWalkAnimation(dt, Player.walkDistance)
    end

    if gameState == 'running' then
        
        if Player.hearts > Player.max_hearts then
            Player.hearts = Player.max_hearts
        end

        if Player.money > Player.maxMoney then
            Player.money = Player.maxMoney
        end
        
        if Player.hearts <= 1 then
            sounds.lowHealth:play()
        end

        if Player.receive_damage then
            Player.invincible = true
            Player.receive_damage = false
            Player.state = 'pushed'
            damage_timer = 0
        end
        if Player.invincible then
            Player.timer = Player.timer + 1 * dt
        end
        
        if Player.timer >= 0.750 then
            Player.timer = 0
            if Player.invincible then
                Player.invincible = false
            end
        end
        
        if love.keyboard.wasPressed('f') and Sword.timer < 0 and Player.state == 'walking' and Player.slot1 ~= nil then
            Player:attack()
        end

        if Player.state == 'walking' then

            if Player.isMoving then
                Player.currentAnimation:update(dt)
            end

            Player.vectorX = 0
            Player.vectorY = 0

            Player.x, Player.y = Player.collider:getPosition()
            if love.keyboard.isDown('up') then
                Player.vectorY = -1
                Player.currentAnimation = Player.walkUp
                Player.direction = 'up'

            elseif love.keyboard.isDown('down') then
                Player.vectorY = 1
                Player.currentAnimation = Player.walkDown
                Player.direction = 'down'

            elseif love.keyboard.isDown('left') then
                Player.vectorX = -1
                Player.currentAnimation = Player.walkLeft
                Player.direction = 'left'

            elseif love.keyboard.isDown('right') then
                Player.vectorX = 1
                Player.currentAnimation = Player.walkRight
                Player.direction = 'right'
            end

            if Player.vectorX == 0 and Player.vectorY == 0 then
                Player.isMoving = false
            elseif not Player.isMoving then
                Player.isMoving = true
            end

            checkPlayerEnterInDoor()

            Player.collider:setLinearVelocity(Player.vectorX * WALK_SPEED, Player.vectorY * WALK_SPEED)
        
        elseif Player.state == 'attacking' then
            Player.currentAnimation:update(dt)

        elseif Player.state == 'pushed' then
            Player.x, Player.y = Player.collider:getPosition()
            
            -- link is pushed
            local v1, v2 = ((getDirectionVector(Player.direction):rotateInplace(math.pi)) * dt * 300):unpack()
            Player.collider:setLinearVelocity(v1 * WALK_SPEED, v2 * WALK_SPEED)
            damage_timer = damage_timer + 1 * dt
            if damage_timer >= 0.133 then
                damage_timer = 0
                Player.state = 'walking'
            end

        elseif Player.state == 'holding_weapon' then        
            Player.collider:setLinearVelocity(0, 0)
            Player.currentAnimation = Player.holdingSword
            Player.timerHoldingItem = Player.timerHoldingItem + 1 * dt
            if Player.timerHoldingItem >= 2 then
                Player.state = 'walking'
                Player.currentAnimation = Player.walkDown
            end
        end
        Player:pickupItems()

    elseif gameState == 'changingRoom' then
        Player.currentAnimation:update(dt)
        Player.collider:setLinearVelocity(0, 0)

    elseif gameState == 'animation' then
        Player.currentAnimation:update(dt)

        -- make the player walk more for the door close behind them
        if Player.enterInClosedDoor then
            Player.walkDistance = 32
            Player.animationTimer = Player.animationTimer + 1 * dt
            if Player.animationTimer >= 1 then
                gameState = 'running'
            end
        else
            gameState = 'running'
        end
        
    elseif gameState == 'shardCollected' then
        Player.currentAnimation = Player.holdingItem

        Player.x = math.floor(Player.x)
        Player.y = math.floor(Player.y)

        if #items == 0 and Player.visible == true then
            spawnItem(5, Player.x-10, Player.y-20)
        end
    end
end

function Player:draw()

    if baw == true then
        love.graphics.setShader(blackAndWhiteShader)
    end

    if Player.state == 'holding_weapon' and Player.slot1 == 'wooden_sword' then
        Sword.up:draw(sprites.woodenSword, Player.x-13, Player.y-26)
    end

    if Player.invincible then
        if math.floor(math.cos(love.timer.getTime() * 18 % 2 * math.pi)) == 0 then
            love.graphics.setShader(white_flash)
        end
    end
    -- Draw the animation
    if Player.state ~= 'dead' and Player.visible == true then
        Player.currentAnimation:draw(sprites.linkSheet, Player.x-8.2, Player.y-10+guiY)
    end
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.setShader()
end

function Player:attack()
    if Player.state == 'walking' then
        Player.state = 'attacking'
        Player.collider:setLinearVelocity(0, 0)
        if Player.direction == 'up' then
            Player.currentAnimation = Player.attackUp
        elseif Player.direction == 'down' then
            Player.currentAnimation = Player.attackDown
        elseif Player.direction == 'left' then
            Player.currentAnimation = Player.attackLeft
        elseif Player.direction == 'right' then
            Player.currentAnimation = Player.attackRight
        end
        Sword.attack()
    end
end

function attackComplete()
    if Player.state == 'attacking' then
        Player.state = 'walking'
        if Player.direction == 'up' then
            Player.currentAnimation = Player.walkUp
        elseif Player.direction == 'down' then
            Player.currentAnimation = Player.walkDown
        elseif Player.direction == 'left' then
            Player.currentAnimation = Player.walkLeft
        elseif Player.direction == 'right' then
            Player.currentAnimation = Player.walkRight
        end
    end
end

function playerDamage(value)
    if Player.invincible == false then
        Player.hearts = player.hearts - value
        Player.receive_damage = true
        sounds.linkHurt:stop()
        sounds.linkHurt:play()
    end
end

function playerHeal(value)
    Player.hearts = player.hearts + value
end

function Player:pickupItems()
    for i, item in ipairs(items) do
        
        if item.id == 1 and item.collected == false then
            if distanceFrom(Player.x-5, Player.y+1, item.x, item.y) < 7 then
                playerHeal(1)
                item.collected = true
                sounds.pickupItem:stop()
                sounds.pickupItem:play()
            end
        elseif item.id == 2 and item.collected == false then
            if distanceFrom(Player.x-5, Player.y-8, item.x, item.y) < 10 then
                
                if currentDungeonRoom == 11 then key11Collected = true end
                if currentDungeonRoom == 15 then key15Collected = true end
                if currentDungeonRoom == 26 then key26Collected = true end
                if currentDungeonRoom == 28 then key28Collected = true end

                Player.keys = Player.keys + 1
                item.collected = true
                sounds.pickupItem:stop()
                sounds.pickupItem:play()
            end

        elseif item.id == 3 and item.collected == false then
            if distanceFrom(Player.x-8, Player.y-8, item.x, item.y) < 10 then
                Player.money = Player.money + 1
                item.collected = true
                sounds.pickupRupee:stop()
                sounds.pickupRupee:play()
            end

        elseif item.id == 4 and item.collected == false then
            if distanceFrom(Player.x-6.5, Player.y-6.5, item.x, item.y) < 10 then

                if currentDungeonRoom == 5 then heartContainer1Collected = true end

                Player.max_hearts = Player.max_hearts + 1
                Player.hearts = Player.hearts + 1
                item.collected = true
                sounds.getItem:stop()
                sounds.getItem:play()
            end

        elseif item.id == 5 and item.collected == false then
            if distanceFrom(Player.x-5, Player.y-5, item.x, item.y) < 10 then
                shard1Collected = true
                gameState = 'shardCollected'
                Player.hearts = Player.max_hearts
                item.collected = true
                sounds.getItem:stop()
                sounds.getItem:play()
            end
        end

        if item.id == 10 and item.collected == false then
            if distanceFrom(Player.x-8, Player.y-8, item.x, item.y) < 10 then
                sounds.newItem:play()
                Player.state = 'holding_weapon'
                Player.slot1 = 'wooden_sword'
                item.collected = true
                sounds.getItem:stop()
                sounds.getItem:play()
            end
        end
    end
end

function checkPlayerEnterInDoor()
    if Map.type == 'overworld' then
        local layer = checkLayer('Ground_layer', map:convertPixelToTile(Player.x, Player.y))

        -- check if player is in the blank tile for enter in the dungeon
        if currentOverworldRoom == 3 and layer == 'none' and Player.exitEntrance and Player.direction == 'up' then
            Player.exitEntrance = false
            Player.enter = true
            Map.nextMap = 'dungeon_1'
        end

        if currentOverworldRoom == 23 and layer == 'none' and Player.exitEntrance and Player.direction == 'up' then
            Player.exitEntrance = false
            Player.enter = true
            Map.nextMap = 'cavern'
        end

        if layer ~= 'none' and Player.exitEntrance == false then
            Player.exitEntrance = true
        end

    -- check if the player is in the right place for they get out of the dungeon
    elseif Map.type == 'dungeon_1' and currentDungeonRoom == 27 then

        if Player.y >= 226 and Player.direction == 'down' then
            changeMap('overworld')
            Player.y = 152
            Player.out = true
        end

    elseif Map.type == 'cavern' then

        if Player.y >= 226 and Player.direction == 'down' then
            changeMap('overworld')
            Player.y = 107
            Player.out = true
        end
    end
end

function playerWasReleased()
    deleteItems()
    loading = true
    currentDungeonRoom = 27
    changeMap('dungeon_1')
    Player.direction = 'up'
    Player.currentAnimation = Player.walkUp
    Player.enterInUndergroundRoom = true
end

function playerEnterAnimation(dt)
    deleteAllEntities()

    sounds.stairs:play()

    mapOverlap = true -- make the map be draw on top of everything
    
    if Map.nextMap == 'dungeon_1' then
        Player.x = 120
        Player.y = Player.y + 30 * dt
    elseif Map.nextMap == 'cavern' then
        Player.x = 72
        Player.y = Player.y + 30 * dt
    end
    
    if Player.y > 152 and Map.nextMap == 'dungeon_1' then

        -- make the game start to "load"
        loading = true
        
        mapOverlap = false
        Player.enter = false
        Player.walkDistance = 16
        Player.animationTimer = 0
        Player.enterInUndergroundRoom = true
        changeMap('dungeon_1')
        sounds.stairs:stop()
        
    elseif Player.y > 104 and Map.nextMap == 'cavern' then

        loading = true
        
        mapOverlap = false
        Player.enter = false
        Player.walkDistance = 16
        Player.animationTimer = 0
        Player.enterInUndergroundRoom = true
        changeMap('cavern')
        sounds.stairs:stop()
    end
end

function playerOutAnimation(dt)
    deleteAllEntities()

    sounds.stairs:play()

    mapOverlap = true -- make the map be draw on top of everything

    -- make the game stop "load"
    loading = false

    if Map.nextMap == 'dungeon_1' then
        Player.x = 119
        Player.collider:setPosition(119, 129)

    elseif Map.nextMap == 'cavern' then
        Player.x = 71
        Player.collider:setPosition(71, 81)
    end

    Player.y = Player.y - 30 * dt

    if (Player.y <= 129 and Map.nextMap == 'dungeon_1') or (Player.y <= 81 and Map.nextMap == 'cavern') then
        Player.waitTimer = 0
        mapOverlap = false
        Player.out = false
        Player.x, Player.y = Player.collider:getPosition()
        enemiesPerRoom()
        sounds.stairs:stop()
    end
end

function playerWalkAnimation(dt, walkDistance)

    local vectX, vectY = getDirectionVector(Player.direction):unpack()
    Player.x = Player.x + (vectX * WALK_SPEED * dt)
    Player.y = Player.y + (vectY * WALK_SPEED * dt)
    local x, y = Player.collider:getPosition()

    -- check if the player walked enough
    if distanceFrom(Player.x, Player.y, x, y) >= walkDistance then
        Player.collider:setPosition(Player.x, Player.y)
        Player.enterInUndergroundRoom = false
        Player.enterInClosedDoor = false
        getDistancePosition = false
    end
end
