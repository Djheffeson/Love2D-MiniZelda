Player = Class{}

PLAYER_WIDTH = 16
PLAYER_HEIGHT = 16
WALK_SPEED = 80

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

    Player.slot1 = 'wooden_sword'
    Player.slot2 = nil

    Player.money = 0
    Player.keys = 0
    Player.bombs = 0
    Player.max_hearts = 3
    Player.hearts = Player.max_hearts

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

    Player.timer = 0
end

function Player:update(dt)
    --print(Player.collider:getPosition())
    if gameState == 'running' then
        
        if Player.hearts <= 0 then
            print("YOU DIE")
            return
        end

        if Player.hearts > Player.max_hearts then
            Player.hearts = Player.max_hearts
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
        
        if love.keyboard.wasPressed('f') and Sword.timer < 0 and Player.state == 'walking' then
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
        end
        Player:pickupItems()
    end
end

function Player:draw()
    if Player.invincible then
        love.graphics.setColor(1, 0, 0, 1)
    else
        love.graphics.setColor(1, 1, 1, 1)
    end
    -- Draw the animation
    Player.currentAnimation:draw(
        sprites.linkSheet, Player.x-9, Player.y-10
    )
    love.graphics.setColor(1, 1, 1, 1)
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
            end
        elseif item.id == 2 and item.collected == false then
            if distanceFrom(Player.x-5, Player.y-8, item.x, item.y) < 10 then
                Player.keys = Player.keys + 1
                item.collected = true
            end
        end
    end
end

function checkPlayerEnterInDoor()
    if Map.type == 'overworld' then
        if currentOverworldRoom == 3 and (Player.x >= 117.1 and Player.x <= 122.8) and (Player.y <= 129.5 and Player.y >= 125.1) then
            changeMap('dungeon_1')
        end
    elseif Map.type == 'dungeon_1' then
        if currentDungeonRoom == 27 and Player.y >= 210.6 then
            changeMap('overworld')
        end
    end
end
