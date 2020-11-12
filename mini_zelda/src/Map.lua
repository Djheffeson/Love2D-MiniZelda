Map = Class{}

room_1 = 'assets/tilemaps/room_1.lua'
room_2 = 'assets/tilemaps/room_2.lua'
room_3 = 'assets/tilemaps/room_3.lua'

currentRoom = room_1

colliders = {}

function Map:init()
    map = sti(currentRoom, { 'box2d' }, 0, 48)

    -- Create a collision layer to check where put a collision box
    collideLayer = map.layers[2].objects
    for i, j in pairs(collideLayer) do
        -- Get the X and Y of the object for collide
        local collideObjectX = map.layers[2].objects[i].x
        local collideObjectY = map.layers[2].objects[i].y
        -- Create a collide box in the position of the object "collide"
        collideBox = world:newRectangleCollider(
            collideObjectX,
            collideObjectY-16+48,
            16,
            16
        )
        collideBox:setCollisionClass('Wall')
        collideBox:setType('static')
        
        table.insert(colliders, collideBox)
    end
    map:removeLayer('Collide')
end

function Map:update(dt)

end

function Map:draw()

end

function changeRoom(room_n)
    currentRoom = room_n
    map = sti(currentRoom, { 'box2d' }, 0, 48)
    
    for i, v in ipairs(colliders) do
        v:destroy()
    end
    
    colliders = {}
    
    -- Create a collision layer to check where put a collision box
    collideLayer = map.layers[2].objects
    for i, j in pairs(collideLayer) do
        -- Get the X and Y of the object for collide
        local collideObjectX = map.layers[2].objects[i].x
        local collideObjectY = map.layers[2].objects[i].y
        -- Create a collide box in the position of the object "collide"
        collideBox = world:newRectangleCollider(
            collideObjectX,
            collideObjectY-16+48,
            16,
            16
        )
        collideBox:setCollisionClass('Wall')
        collideBox:setType('static')

        table.insert(colliders, collideBox)
    end
    map:removeLayer('Collide')
end