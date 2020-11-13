Map = Class{}

room_1 = 'assets/tilemaps/room_1.lua'
room_2 = 'assets/tilemaps/room_2.lua'
room_3 = 'assets/tilemaps/room_3.lua'
room_4 = 'assets/tilemaps/room_4.lua'
room_5 = 'assets/tilemaps/room_5.lua'
room_6 = 'assets/tilemaps/room_6.lua'

rooms = {
    room_1, room_2, room_3,
    room_4, room_5, room_6
}

currentRoom = 5

colliders = {}

function Map:init()

    mapX = 0
    mapY = 0 

    tmpMapX = 0
    tmpMapY = 0

    tmpmap = sti(rooms[currentRoom], { 'box2d' })
    map = sti(rooms[currentRoom], { 'box2d' }, 0, 56)
    

    changing_room = false
    local direct = 'up'

    createRoomCollisions()
end

function Map:update(dt)
    print(currentRoom)
    if love.keyboard.isDown('w') then
        direct = 'up'
        changing_room = true
    elseif love.keyboard.isDown('s') then
        direct = 'down'
        changing_room = true
    elseif love.keyboard.isDown('a') then
        direct = 'left'
        changing_room = true
    elseif love.keyboard.isDown('d') then
        direct = 'right'
        changing_room = true
    end
    if changing_room then
        nextRoom(direct)
    end
end

function Map:draw()
    tmpmap:draw(tmpMapX, tmpMapY)
    map:draw(mapX, mapY)
end

function nextRoom(direction)
    local nxRoom
    if direction == 'up' then
        nxRoom = currentRoom - 3

    elseif direction == 'down' then
        nxRoom = currentRoom + 3

    elseif direction == 'left' then
        nxRoom = currentRoom - 1

    elseif direction == 'right' then
        nxRoom = currentRoom + 1
    end
    moveRoom(nxRoom, direction)
end

function moveRoom(room, direction)
    deleteRoomCollisions()
    tmpmap = sti(rooms[room], { 'box2d' }, 0, 56)

    tmpMapX = 0
    tmpMapY = 0

    if direction == 'down' then
        mapY = mapY - 4
        tmpMapY = mapY + 168

        if Player.y > 61 and Player.y < 255 then
            Player.y = Player.y - 4
            Player.collider:setPosition(Player.x, Player.y)
        end

        if mapY <= -168 then
            changeRoom(room)
        end

    elseif direction == 'up' then
        mapY = mapY + 4
        tmpMapY = mapY - 168

        if Player.y > 61 and Player.y < 255 then
            Player.y = Player.y + 4
            Player.collider:setPosition(Player.x, Player.y)
        end

        if mapY >= 168 then
            changeRoom(room)
        end

    elseif direction == 'right' then
        mapX = mapX - 4
        tmpMapX = mapX + 256

        if Player.x > 6 and Player.x < 250 then
            Player.x = Player.x - 4
            Player.collider:setPosition(Player.x, Player.y)
        end

        if mapX <= -256 then
            changeRoom(room)
        end

    elseif direction == 'left' then
        mapX = mapX + 4
        tmpMapX = mapX - 256

        if Player.x > 6 and Player.x < 250 then
            Player.x = Player.x + 4
            Player.collider:setPosition(Player.x, Player.y)
        end

        if mapX >= 256 then
            changeRoom(room)
        end

    end
end


function changeRoom(room)
    changing_room = false
    mapX = 0
    mapY = 0 

    currentRoom = room
    map = sti(rooms[currentRoom], { 'box2d' }, 0, 56)
    
    deleteRoomCollisions()
    createRoomCollisions()
end

function createRoomCollisions()
    collideLayer = map.layers[2].objects
    for i, j in pairs(collideLayer) do
        -- Get the X and Y of the object for collide
        local collideObjectX = map.layers[2].objects[i].x
        local collideObjectY = map.layers[2].objects[i].y
        -- Create a collide box in the position of the object "collide"
        collideBox = world:newRectangleCollider(
            collideObjectX,
            collideObjectY-16+56,
            16,
            16
        )
        collideBox:setCollisionClass('Wall')
        collideBox:setType('static')

        table.insert(colliders, collideBox)
    end
    map:removeLayer('Collide')
end

function deleteRoomCollisions()
    for i, v in ipairs(colliders) do
        v:destroy()
    end
    colliders = {}
end