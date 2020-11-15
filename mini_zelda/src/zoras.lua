zoras = {}

function spawnZora(limitX1, limitx2, limitY1, limitY2)
    local zora = {}
    zora.x = math.random(limitX1, limitX2)
    zora.y = math.random(limitY1, limitY2)
    
    zora.grid = anim8.newGrid(16, 16, sprite.zoraSheet:getWidth(), sprite.zoraSheet:getHeight())
    zora.animationEmerging = anim8.newAnimation(zora.grid('1-2', 1), 0.1)
    zora.animationFront = anim8.newAnimation(zora.grid(1, 2), 1)
    zora.animationBack = anim8.newAnimation(zora.grid(2, 2), 1)
end

function zoras:update(dt)

end

function zoras:draw()

end