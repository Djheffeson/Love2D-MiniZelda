Enemy = Class{}

function Enemy:init()
    
    self.x = 100
    self.y = 150

    self.walk = love.math.random(50, 100)

    self.vectorX = 0
    self.vectorY = 0

    world:addCollisionClass('Enemy')
    self.collider = world:newCircleCollider(self.x, self.y, 7)

    self.spritesheet = love.graphics.newImage('assets/graphics/red_octorok_sprite.png')
    self.grid = anim8.newGrid(16, 16, self.spritesheet:getWidth(), self.spritesheet:getHeight())
    self.animation = anim8.newAnimation(self.grid('1-2', 1), 0.1)
end

function Enemy:update(dt)
    self.animation:update(dt)

    --self.vectorX = love.math.random(-1, 1)
    --self.vectorY = love.math.random(-1, 1)

    ex, ey = self.collider:getPosition()
    self.collider:setLinearVelocity(self.vectorX * self.walk, self.vectorY * self.walk)

end

function Enemy:draw()
    self.animation:draw(self.spritesheet, ex-8, ey-8)
end