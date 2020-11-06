Map = Class{}

windfield = require 'assets/libraries/windfield'

function Map:init()
    map = sti('assets/tilemaps/testmap.lua', { 'box2d' })
    world = windfield.newWorld()

    world:addCollisionClass('Player')
    world:addCollisionClass('Wall')
    world:addCollisionClass('Enemy', {ignores = {'Enemy', 'Player'}})
    world:setQueryDebugDrawing(true)
    -- Create a collision layer to check where put a collision box
    collideLayer = map.layers[3].objects
    for i, j in pairs(collideLayer) do
        -- Get the X and Y of the object for collide
        local collideObjectX = map.layers[3].objects[i].x
        local collideObjectY = map.layers[3].objects[i].y
        -- Create a collide box in the position of the object "collide"
        collideBox = world:newRectangleCollider(
            collideObjectX,
            collideObjectY-16,
            16,
            16
        )
        collideBox:setCollisionClass('Wall')
        collideBox:setType('static')
    end
    map:removeLayer('Collide')
end

function Map:update(dt)

end

function Map:draw()
end
