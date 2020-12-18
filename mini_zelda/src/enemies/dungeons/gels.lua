gels = {}

function spawnGel()
    local gel = {}
    
    repeat
        gel.x = multiple16(love.math.random(16,256))
        gel.y = multiple16(love.math.random(72,224))
    until checkLayer('Ground_layer', map:convertPixelToTile(gel.x-4, gel.y-4)) == 'dungeon_brick'

    gel.health = 1
    gel.damage = 0.5

    gel.vectorX = 0
    gel.vectorY = 0

    gel.targets = {'up', 'down', 'left', 'right'}
    gel.haveTarget = false
    gel.target = ''
    gel.targetX, gel.targetY = 0

    gel.grid = anim8.newGrid(16, 16, sprites.gel:getWidth(), sprites.gel:getHeight())
    gel.animation = anim8.newAnimation(gel.grid('1-2', 1), 0.1)

    gel.collider = world:newRectangleCollider(gel.x-11, gel.y-4, 7, 9)
    gel.collider:setCollisionClass('Enemy')
    gel.collider:setFixedRotation(true)

    gel.walkTimer = 0
    gel.waitTime = love.math.random(0.001,2)

    table.insert(gels, gel)
end

function gels:update(dt)
    for i, gel in ipairs(gels) do

        if gel.health <= 0 then
            gelDeath(i)
            return
        end

        gel.x, gel.y = gel.collider:getPosition()

        gel.walkTimer = gel.walkTimer + 1 * dt
        if gel.walkTimer >= gel.waitTime then

            gel.vectorX = 0
            gel.vectorY = 0
            
            if gel.haveTarget == false then
                gel.target = ''
                gel.targetX, gel.targetY = gelGetTarget(i)
                gel.haveTarget = true
            end

            if gel.target == 'up' then
                gel.vectorY = gel.vectorY - 1
            elseif gel.target == 'down' then
                gel.vectorY = gel.vectorY + 1
            elseif gel.target == 'left' then
                gel.vectorX = gel.vectorX - 1
            elseif gel.target == 'right' then
                gel.vectorX = gel.vectorX + 1
            end

            if distanceFrom(gel.targetX, gel.targetY, gel.x, gel.y) <= 1 then
                gel.vectorX = 0
                gel.vectorY = 0
                gel.walkTimer = 0
                gel.haveTarget = false
                gel.waitTime = love.math.random(0.001,2)
                gel.collider:setPosition(gel.targetX, gel.targetY)
            end
        end
        
        gel.animation:update(dt)
        gel.collider:setLinearVelocity(gel.vectorX * 64, gel.vectorY * 64)

        checkGelDamage(i)
        checkGelDamagePlayer(i)
    end
end

function gels:draw()
    for i, gel in ipairs(gels) do
        gel.animation:draw(sprites.gel, gel.x-8, gel.y-8)
    end
end

function gelGetTarget(index)

    local gel = gels[index]
    local x, y = gel.collider:getPosition()

    repeat

        gel.target = gel.targets[math.random(#gel.targets)]
        x, y = gel.collider:getPosition()
        if gel.target == 'up' then
            y = y - 16
        elseif gel.target == 'down' then
            y = y + 16
        elseif gel.target == 'left' then
            x = x - 16
        elseif gel.target == 'right' then
            x = x + 16
        end
    until checkLayer('Ground_layer', map:convertPixelToTile(x, y-8)) == 'dungeon_brick'

    return x, y
end

function checkGelDamagePlayer(index)
    local gel = gels[index]
    
    if gel.collider:enter('Player') then
        playerDamage(gel.damage)
    end
end

function checkGelDamage(index)
    local gel = gels[index]

    if gel.collider:enter('Weapon') or gel.collider:enter('Arrow') then
        gel.health = gel.health - Sword.damage
    end
end

function gelDeath(index)
    local gel = gels[index]

    deathSpawn(gel.x-8, gel.y-8, 0)

    if gel.collider ~= nil then
        gel.collider:destroy()
    end

    enemiesDungeon1_rooms[currentDungeonRoom][2] = enemiesDungeon1_rooms[currentDungeonRoom][2] - 1
    table.remove(gels, index)
end

function deleteGels()
    for i, gel in ipairs(gels) do
        if gel.collider ~= nil then
            gel.collider:destroy()
        end

        table.remove(gels, i)
    end
end
