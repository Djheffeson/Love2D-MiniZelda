Enemy = Class{}

function Enemy:init()
    
    self.x = love.math.random(100,150)
    self.y = love.math.random(100,150)

    self.walk = love.math.random(40, 80)

    self.vectorX = 0
    self.vectorY = 0

    self.damage = 0.5

    -- Choose a direction for the enemy start
    local directions = {'up', 'down', 'left', 'right'}
    self.direction = directions[math.random(#directions)]
    self.state = 'walking'
    
    -- Create a collision for the enemy
    self.collider = world:newCircleCollider(self.x, self.y, 7)
    self.collider:setCollisionClass('Enemy')
    self.collider:setObject(self)

    -- Create a colider in front of the enemy for check if they collide with anything 
    self.collider_front = world:newCircleCollider(self.x, self.y, 4)
    self.collider_front:setCollisionClass('Enemy')
    
    
    self.spritesheet = love.graphics.newImage('assets/graphics/red_octorok_sprite.png')
    self.grid = anim8.newGrid(16, 16, self.spritesheet:getWidth(), self.spritesheet:getHeight())
    self.animationDown = anim8.newAnimation(self.grid('1-2', 1), 0.1)
    self.animationUp = anim8.newAnimation(self.grid('1-2', 1), 0.1):flipV()
    self.animationLeft = anim8.newAnimation(self.grid('1-2', 2), 0.1):flipH()
    self.animationRight = anim8.newAnimation(self.grid('1-2', 2), 0.1)

    self.currentAnimation = self.animationDown
    
    timer = 1
end

function Enemy:update(dt)
 
    self.currentAnimation:update(dt)
    self.direction = getDirection(self.vectorX, self.vectorY)

    self.ex, self.ey = self.collider:getPosition()
    self.collider:setLinearVelocity(self.vectorX * self.walk, self.vectorY * self.walk)

    if self.collider_front:enter('Wall') then
        self.state = 'colliding'
    end

    if self.collider_front:exit('Wall') then
        self.state = 'walking'
    end


    if self.state == 'colliding' then
        directAvailable = checkDirection(self.ex, self.ey)
        self.direction = directAvailable[math.random(#directAvailable)]
        self.vectorX = 0
        self.vectorY = 0
    end

    timer = timer + 1 * dt
    if timer > 1 then
        timer = 0
        if math.random(3) == 1 then
            directAvailable = checkDirection(self.ex, self.ey)
            self.direction = directAvailable[math.random(#directAvailable)]
            self.vectorX = 0
            self.vectorY = 0
            self.state = 'walking'
        end
    end

    -- Check if enemy collide with player
    if self.collider:enter('Player') then
        playerDamage(self.damage)
    end
    
    if self.direction == 'up' then
        self.vectorY = -1
        self.currentAnimation = self.animationUp
        self.collider_front:setPosition(self.ex, self.ey-6)

    elseif self.direction == 'down' then
        self.vectorY = 1
        self.currentAnimation = self.animationDown
        self.collider_front:setPosition(self.ex, self.ey+6)

    elseif self.direction == 'left' then
        self.vectorX = -1
        self.currentAnimation = self.animationLeft
        self.collider_front:setPosition(self.ex-6, self.ey)

    elseif self.direction == 'right' then
        self.vectorX = 1
        self.currentAnimation = self.animationRight
        self.collider_front:setPosition(self.ex+6, self.ey)
    end

end

function Enemy:draw()
    self.currentAnimation:draw(self.spritesheet, self.ex-8, self.ey-8)
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

function checkDirection(px, py)

    cLeft = world:queryCircleArea(px-9, py, 4, {'Wall'})
    cRight = world:queryCircleArea(px+9, py, 4, {'Wall'})
    cBack = world:queryCircleArea(px, py+9, 4, {'Wall'})
    cFront = world:queryCircleArea(px, py-9, 4, {'Wall'})

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