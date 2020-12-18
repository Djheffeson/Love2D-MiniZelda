aquamentus = {}

require 'src/enemies/dungeons/bosses/aquamentusProjectile'

function spawnAquamentus()
    local aqua = {}

    aqua.x = 177
    aqua.y = 120
    
    aqua.dx = 0

    aqua.speed = 5
    aqua.right = 160
    aqua.mid = 177
    aqua.left = 192

    aqua.target = aqua.right

    aqua.health = 6
    aqua.damage = 1
    aqua.invincible = false

    aqua.grid = anim8.newGrid(24, 32, sprites.aquamentus:getWidth(), sprites.aquamentus:getHeight())
    aqua.attackAnim = anim8.newAnimation(aqua.grid('1-2', 1), 0.3)
    aqua.walkAnim = anim8.newAnimation(aqua.grid('3-4', 1), 0.3)
    aqua.currentAnimation = aqua.walkAnim
    
    aqua.collider = world:newRectangleCollider(aqua.x, aqua.y, 16, 16)
    aqua.collider:setCollisionClass('IgnoreWallEnemy')
    aqua.collider:setFixedRotation(true)
    aqua.colliderExists = true

    aqua.attackTimer = 0
    aqua.attackTime = math.random(2, 4)
    aqua.invincibleTimer = 0

    table.insert(aquamentus, aqua)
end

function aquamentus:update(dt)
    aquamentusProjectile:update(dt)
    for i, aqua in ipairs(aquamentus) do
        if aqua.health <= 0 then
            aquamentusDeath(i)
            return
        end
        aqua.currentAnimation:update(dt)
        aqua.collider:setPosition(aqua.x+8, aqua.y+8)

        aqua.attackTimer = aqua.attackTimer + 1 * dt
        if aqua.attackTimer >= aqua.attackTime then
            aqua.currentAnimation = aqua.walkAnim
            aqua.attackTimer = 0
            aqua.attackTime = math.random(2, 4)
            spawnAquaProjectiles(aqua.x, aqua.y)

        elseif aqua.attackTimer >= aqua.attackTime-0.5 then
            sounds.bossScream:play()
            aqua.currentAnimation = aqua.attackAnim
        end

        if math.floor(aqua.x - aqua.target) == 0 then
            if aqua.target == aqua.right then
                if math.random(2) == 1 then
                    aqua.target = aqua.mid
                else
                    aqua.target = aqua.left
                end

            elseif aqua.target == aqua.mid then
                aqua.target = aqua.right

            elseif aqua.target == aqua.left then
                if math.random(2) == 1 then
                    aqua.target = aqua.mid
                else
                    aqua.target = aqua.right
                end
            end
        end

        if aqua.target > aqua.x then
            aqua.dx = aqua.speed
        elseif aqua.target < aqua.x then
            aqua.dx = -aqua.speed 
        end
        aqua.x = aqua.x + aqua.dx * dt

        if aqua.invincible then
            aqua.invincibleTimer = aqua.invincibleTimer + 1 * dt
            if aqua.invincibleTimer >= 0.750 then
                aqua.invincible = false
                aqua.invincibleTimer = 0
            end
        end

        checkIfAquamentusDamagePlayer(i)
        checkIfPlayerDamageAquamentus(i)
    end
end

function aquamentus:draw()
    aquamentusProjectile:draw()
    for i, aqua in ipairs(aquamentus) do
        if aqua.invincible == true then
            -- makes the sprite blink white
            if math.floor(math.cos(love.timer.getTime() * 18 % 2 * math.pi)) == 0 then
                love.graphics.setShader(white_flash)
            end
        end
        aqua.currentAnimation:draw(sprites.aquamentus, aqua.x, aqua.y)
    end
    love.graphics.setShader()
end

function checkIfPlayerDamageAquamentus(index)
    local aqua = aquamentus[index]
    if aqua.collider:enter('Weapon') or aqua.collider:enter('Arrow') and aqua.invincible == false then
        aqua.health = aqua.health - Sword.damage
        aqua.invincible = true

        if aqua.health > 0 then
            sounds.enemyHit:stop()
            sounds.enemyHit:play()
        end
    end
end

function checkIfAquamentusDamagePlayer(index)
    local aqua = aquamentus[index]
    if aqua.collider:enter('Player') then
        playerDamage(aqua.damage)
    end
end

function aquamentusDeath(index)
    local aqua = aquamentus[index]
    deathSpawn(aqua.x, aqua.y, enemyDrops())
    if aqua.colliderExists == true then
        aqua.collider:destroy()
        aqua.colliderExists = false
    end
    enemiesDungeon1_rooms[currentDungeonRoom][6] = enemiesDungeon1_rooms[currentDungeonRoom][6] - 1
    table.remove(aquamentus, i)
end

function deleteAquamentus()
    deleteAquaProjectiles()
    for i, aqua in ipairs(aquamentus) do
        if aqua.colliderExists == true then
            aqua.collider:destroy()
            aqua.colliderExists = false
        end
        table.remove(aquamentus, i)
    end
end
