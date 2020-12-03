Sword = Class{}

function Sword:init()
    Sword.x = 0
    Sword.y = 0
    Sword.direction = "down"
    Sword.directionVector = vector(0, 1) -- down
    Sword.state = 'invisible'
    Sword.timer = -1

    Sword.damage = 1

    Sword.sprite = sprites.woodenSword
    Sword.grid = anim8.newGrid(16, 16, Sword.sprite:getWidth(), Sword.sprite:getHeight())

    Sword.up = anim8.newAnimation(Sword.grid(1, 1), 1)
    Sword.down = anim8.newAnimation(Sword.grid(1, 1), 1):flipV()
    Sword.left = anim8.newAnimation(Sword.grid(2, 1), 1):flipH()
    Sword.right = anim8.newAnimation(Sword.grid(2, 1), 1)

    Sword.currentAnimation = Sword.up

    swordThrowExists = false

end

function Sword:update(dt)
    
    swordThrow:update(dt)

    if Sword.timer > 0 then
        Sword.timer = Sword.timer - dt
        if Sword.timer < 0 then
            if Sword.state == 'attack' then
                Sword.collision:destroy()
                Sword.state = 'pause'
                Sword.timer = 0.077
            elseif Sword.state == 'pause' then
                Sword.timer = 0.07
                Sword.directionVector:rotateInplace(math.pi)
                Sword.state = 'back'
                if swordThrowExists == false and Player.hearts >= Player.max_hearts then
                    swordSpawn(Sword.x, Sword.y, Sword.direction)
                    swordThrowExists = true
                end
            else
                Sword.state = 'invisible'
            end
        end
    end

    if Sword.state == 'back' then
        local dx, dy = (Sword.directionVector * dt * 105):unpack()
        Sword.x = Sword.x + dx
        Sword.y = Sword.y + dy
    end

    if Sword.state ~= 'invisible' then

    end
end

function Sword:draw()

    if Sword.state ~= 'invisible' then
        love.graphics.setColor(1, 1, 1, 1)
        Sword.currentAnimation:draw(sprites.woodenSword, Sword.x, Sword.y)
    end
end

function Sword:attack()
    if Sword.state ~= 'invisible' then        
        return
    end

    sounds.useSword:stop()
    sounds.useSword:play()
    -- Sword.x receive the same position of the player
    Sword.x = Player.x - 10
    Sword.y = Player.y - 10
    Sword.direction = Player.direction
    Sword.directionVector = getDirectionVector(Sword.direction)

    if Sword.direction == 'down' then
        Sword.currentAnimation = Sword.down

        Sword.x = Sword.x + 1
        Sword.y = Sword.y + 12

        Sword.pickupItems(Sword.x+1, Sword.y+5)

        Sword.collision = world:newRectangleCollider(Sword.x+1, Sword.y+5, 16, 4)
        Sword.collision:setAngle(math.pi / 2)
        Sword.collision:setFixedRotation(true)
        Sword.collision:setCollisionClass('Weapon')

    elseif Sword.direction == 'left' then
        Sword.currentAnimation = Sword.left

        Sword.x = Sword.x - 11
        Sword.y = Sword.y + 1

        Sword.pickupItems(Sword.x, Sword.y+4)

        Sword.collision = world:newRectangleCollider(Sword.x, Sword.y+7, 16, 4)
        Sword.collision:setFixedRotation(true)
        Sword.collision:setCollisionClass('Weapon')

    elseif Sword.direction == 'up' then
        Sword.currentAnimation = Sword.up

        Sword.x = Sword.x - 1
        Sword.y = Sword.y - 12

        Sword.pickupItems(Sword.x+1, Sword.y+4)

        Sword.collision = world:newRectangleCollider(Sword.x+1, Sword.y+5, 16, 4)
        Sword.collision:setAngle(math.pi / 2)
        Sword.collision:setFixedRotation(true)
        Sword.collision:setCollisionClass('Weapon')
    elseif Sword.direction == 'right' then
        Sword.currentAnimation = Sword.right

        Sword.x = Sword.x + 13
        Sword.y = Sword.y + 1

        Sword.pickupItems(Sword.x, Sword.y+4)

        Sword.collision = world:newRectangleCollider(Sword.x, Sword.y+7, 16, 4)
        Sword.collision:setFixedRotation(true)
        Sword.collision:setCollisionClass('Weapon')
    end

    Sword.state = 'attack'
    Sword.timer = 0.07
end

function Sword.pickupItems(x, y)
    for i, item in ipairs(items) do
        
        if item.id == 1 and item.collected == false then
            if distanceFrom(x, y, item.x, item.y) < 7 then
                playerHeal(1)
                item.collected = true
                sounds.pickupItem:stop()
                sounds.pickupItem:play()
            end
        elseif item.id == 2 and item.collected == false then
            if distanceFrom(x, y-3, item.x-3, item.y) < 14 then
                Player.keys = Player.keys + 1
                item.collected = true
                sounds.pickupItem:stop()
                sounds.pickupItem:play()
            end
        elseif item.id == 3 and item.collected == false then
            if distanceFrom(x, y-4, item.x+1, item.y) < 14 then
                Player.money = Player.money + 1
                item.collected = true
                sounds.pickupRupee:stop()
                sounds.pickupRupee:play()
            end
        end
    end
end
