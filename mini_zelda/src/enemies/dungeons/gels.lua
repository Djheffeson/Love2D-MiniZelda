gels = {}

function spawnGel()
    local gel = {}
    
    repeat
        gel.x = multiple16(love.math.random(16,256))
        gel.y = multiple16(love.math.random(72,224))
    until checkLayer('Ground_layer', map:convertPixelToTile(gel.x, gel.y)) == 'dungeon_brick'

    gel.grid = anim8.newGrid(16, 16, sprites.gel:getWidth(), sprites.gel:getHeight())
    gel.animation = anim8.newAnimation(gel.grid('1-2', 1), 0.1)

    gel.collider = world:newRectangleCollider(gel.x-11, gel.y-4, 7, 9)
    gel.collider:setCollisionClass('Enemy')
    gel.collider:setFixedRotation(true)
    gel.colliderExists = true

    table.insert(gels, gel)

end

function gels:update(dt)
    for i, gel in ipairs(gels) do
        gel.animation:update(dt)
        gel.x, gel.y = gel.collider:getPosition()
    end
end

function gels:draw()
    for i, gel in ipairs(gels) do
        gel.animation:draw(sprites.gel, gel.x-8, gel.y-8)
    end
end

function deleteGels()
    for i, gel in ipairs(gels) do
        if gel.colliderExists then
            gel.collider:destroy()
            gel.colliderExists = false
        end

        table.remove(gels, i)
    end
end
