Enemy = Class{}

function Enemy:init()
    
    self.x = love.math.random(100,150)
    self.y = love.math.random(100,150)

    self.walk = love.math.random(40, 80)

    self.vectorX = 0
    self.vectorY = 0

    self.health = 1
    self.damage = 0.5

    self.alive = true
    self.projectileHit = true

    self.collisionDestroyed = false

    self.drops = {1}

    -- Choose a direction for the enemy start
    local directions = {'up', 'down', 'left', 'right'}
    self.direction = directions[math.random(#directions)]
    self.state = 'walking'
    
    -- Create a collision for the enemy
    self.collider = world:newCircleCollider(self.x, self.y, 7)
    self.collider:setCollisionClass('Enemy')
    self.collider:setObject(self)

    -- Create a collider in front of the enemy for check if they collide with anything 
    self.collider_front = world:newCircleCollider(self.x, self.y, 4)
    self.collider_front:setCollisionClass('Enemy')

    -- Create a collider for the projectile
    self.collider_projectile = world:newCircleCollider(self.x, self.y, 5)
    self.collider_projectile:setCollisionClass('Enemy')
    
    self.grid = anim8.newGrid(16, 16, sprites.octorokSheet:getWidth(), sprites.octorokSheet:getHeight())
    self.animationDown = anim8.newAnimation(self.grid('1-2', 1), 0.1)
    self.animationUp = anim8.newAnimation(self.grid('1-2', 1), 0.1):flipV()
    self.animationLeft = anim8.newAnimation(self.grid('1-2', 2), 0.1):flipH()
    self.animationRight = anim8.newAnimation(self.grid('1-2', 2), 0.1)

    self.currentAnimation = self.animationDown
    
    self.timer_actions = 0
    self.timer_attack = 0
    self.shot = false
end

function Enemy:update(dt)
    if not (self.health <= 0) then
        if self.collider:enter('Weapon') then
            self.health = self.health - Sword.damage
        end

        if self.collider_front:enter('Wall') then self.state = 'colliding' end
        if self.collider_front:exit('Wall') then self.state = 'walking' end

        self.timer_attack = self.timer_attack + 1 * dt
        if self.state == 'attacking' then 
            
            self.collider:setLinearVelocity(0, 0)
            self.collider_front:setLinearVelocity(0, 0)

            if self.timer_attack >= 0.850 then
                self.state = 'walking'
                directAvailable = checkDirection(self.x, self.y)
                if not contains(self.direction, directAvailable) then
                    self.direction = directAvailable[math.random(#directAvailable)]
                    self.vectorX = 0
                    self.vectorY = 0
                end
            end
            
            if self.timer_attack >= 0.600 and self.shot == false then
                self.collider_projectile:setLinearVelocity(self.vectorX * 200, self.vectorY * 200)
                self.projectileHit = false
                self.shot = true
            end
        end

        if self.collider_projectile:enter('Wall') or self.collider_projectile:enter('Player') then
            self.projectileHit = true
            self.collider_projectile:setLinearVelocity(0, 0)
        end

        self.currentAnimation:update(dt)
        self.cX, self.cY = self.collider_projectile:getPosition()

        -- Check if enemy or projectile collide with player
        if self.collider:enter('Player') or self.collider_projectile:enter('Player') then
            playerDamage(self.damage)
        end

        if self.state ~= 'attacking' then
            self.x, self.y = self.collider:getPosition()

            if self.state == 'colliding' then
                directAvailable = checkDirection(self.x, self.y)
                self.direction = directAvailable[math.random(#directAvailable)]
                self.vectorX = 0
                self.vectorY = 0
                self.state = 'walking'
            end

            self.timer_actions = self.timer_actions + 1 * dt
            if self.timer_actions > 1 then
                self.timer_actions = 0
                if math.random(3) == 1 then
                    directAvailable = checkDirection(self.x, self.y)
                    self.direction = directAvailable[math.random(#directAvailable)]
                    self.vectorX = 0
                    self.vectorY = 0
                    self.state = 'walking'

                elseif math.random(3) == 1 then
                    self.state = 'attacking'
                    self.timer_attack = 0
                    self.shot = false
                end
            end

            if self.direction == 'up' then
                self.vectorY = -1
                self.currentAnimation = self.animationUp
                self.collider_front:setPosition(self.x, self.y-6)

            elseif self.direction == 'down' then
                self.vectorY = 1
                self.currentAnimation = self.animationDown
                self.collider_front:setPosition(self.x, self.y+6)

            elseif self.direction == 'left' then
                self.vectorX = -1
                self.currentAnimation = self.animationLeft
                self.collider_front:setPosition(self.x-6, self.y)

            elseif self.direction == 'right' then
                self.vectorX = 1
                self.currentAnimation = self.animationRight
                self.collider_front:setPosition(self.x+6, self.y)
            end

            self.collider:setLinearVelocity(self.vectorX * self.walk, self.vectorY * self.walk)
            self.collider_front:setLinearVelocity(self.vectorX * self.walk, self.vectorY * self.walk)

            self.direction = getDirection(self.vectorX, self.vectorY)
            if self.projectileHit then
                self.collider_projectile:setPosition(self.x, self.y)
            end
        end
    else
        if self.collisionDestroyed == false then
            self.collider:destroy()
            self.collider_front:destroy()
            self.collider_projectile:destroy()
            self.collisionDestroyed = true
        end
        self.alive = enemyDrop(self.x, self.y, self.drops)
    end
end

function Enemy:draw()
    if not (self.health <= 0) then
        if self.projectileHit == false then
            love.graphics.draw(sprites.octorok_projectile, self.cX-4, self.cY-4)
        end
        self.currentAnimation:draw(sprites.octorokSheet, self.x-8, self.y-8)
    end
end

function getDirection(vectX, vectY)
    if vectY == -1 then
        direction = 'up'
    elseif vectY == 1 then
        direction = 'down'
    elseif vectX == -1 then
        direction = 'left'
    elseif vectX == 1 then
        direction = 'right'
    end
    return direction
end

function checkDirection(x, y)

    cLeft = world:queryCircleArea(x-9, y, 4, {'Wall'})
    cRight = world:queryCircleArea(x+9, y, 4, {'Wall'})
    cBack = world:queryCircleArea(x, y+9, 4, {'Wall'})
    cFront = world:queryCircleArea(x, y-9, 4, {'Wall'})

    directAvailable = {}
    if #cLeft <= 0 then
        table.insert(directAvailable, 'left')
    end
    if #cRight <= 0 then
        table.insert(directAvailable, 'right')
    end
    if #cBack <= 0 then
        table.insert(directAvailable, 'down')
    end
    if #cFront <= 0 then
        table.insert(directAvailable, 'up')
    end

    return directAvailable
end

grid = anim8.newGrid(16, 16, sprites.deathSheet:getWidth(), sprites.deathSheet:getHeight())
small = anim8.newAnimation(grid(1, 1), 1)
big = anim8.newAnimation(grid(2, 1), 1)
currentAnimation = small

function enemyDrop(x, y, drops)
    -- trying to make a enemy drop someting and make the death animation
    -- 10% chance of drop a item
    if math.random(10) == 1 then
        local item_drop = drops[math.random(#drops)]
        spawnItem(1, x, y, item_drop)
    end
    
    return false
end