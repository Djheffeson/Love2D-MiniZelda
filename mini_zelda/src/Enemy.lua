Enemy = Class{}

function Enemy:init()
    
    self.x = 100
    self.y = 150

    self.walk = love.math.random(40, 100)

    self.vectorX = 0
    self.vectorY = -1
    --self.vectorX = love.math.random(-1, 1)

    self.direction = getDirection(self.vectorX, self.vectorY)
    self.state = 'walking'

    self.collider = world:newCircleCollider(self.x, self.y, 7)
    self.collider:setCollisionClass('Enemy')
    self.collider_front = world:newCircleCollider(self.x, self.y, 4)
    self.collider_front:setCollisionClass('Enemy')
    self.collider:setObject(self)
    
    self.spritesheet = love.graphics.newImage('assets/graphics/red_octorok_sprite.png')
    self.grid = anim8.newGrid(16, 16, self.spritesheet:getWidth(), self.spritesheet:getHeight())
    self.animationDown = anim8.newAnimation(self.grid('1-2', 1), 0.1)
    self.animationUp = anim8.newAnimation(self.grid('1-2', 1), 0.1):flipV()
    self.animationLeft = anim8.newAnimation(self.grid('1-2', 2), 0.1):flipH()
    self.animationRight = anim8.newAnimation(self.grid('1-2', 2), 0.1)

    self.currentAnimation = self.animationDown
end

function Enemy:update(dt)
 
    self.currentAnimation:update(dt)
    self.direction = getDirection(self.vectorX, self.vectorY)

    self.ex, self.ey = self.collider:getPosition()
    self.collider:setLinearVelocity(self.vectorX * self.walk, self.vectorY * self.walk)
    self.state = 'walking'

    if self.collider_front:enter('Wall') then
        self.state = 'colliding'
    end

    if self.collider_front:exit('Wall') then
        self.state = 'walking'
    end

    if self.collider_front:stay('Wall') then
        self.state = 'colliding'
    end
    
    if self.state == 'colliding' then
        if self.direction == 'up' or self.direction == 'down' then
            section = {'right', 'left'}
        elseif self.direction == 'left' or self.direction == 'right' then
            section = {'up', 'down'}
        end
        tmp = section[math.random(#section)]
        self.direction = tmp
        self.vectorX = 0
        self.vectorY = 0
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

    print(self.state, self.direction)
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
    else
        direction = 'stopped'
    end
    return direction
end