Map = Class{}

room_1 = 'assets/tilemaps/room_1.lua'
room_2 = 'assets/tilemaps/room_2.lua'
room_3 = 'assets/tilemaps/room_3.lua'
room_4 = 'assets/tilemaps/room_4.lua'
room_5 = 'assets/tilemaps/room_5.lua'
room_6 = 'assets/tilemaps/room_6.lua'
room_7 = 'assets/tilemaps/room_7.lua'
room_8 = 'assets/tilemaps/room_8.lua'
room_9 = 'assets/tilemaps/room_9.lua'
room_10 = 'assets/tilemaps/room_10.lua'
room_11 = 'assets/tilemaps/room_11.lua'
room_12 = 'assets/tilemaps/room_12.lua'
room_13 = 'assets/tilemaps/room_13.lua'
room_14 = 'assets/tilemaps/room_14.lua'
room_15 = 'assets/tilemaps/room_15.lua'
room_16 = 'assets/tilemaps/room_16.lua'
room_17 = 'assets/tilemaps/room_17.lua'
room_18 = 'assets/tilemaps/room_18.lua'
room_19 = 'assets/tilemaps/room_19.lua'
room_20 = 'assets/tilemaps/room_20.lua'
room_21 = 'assets/tilemaps/room_21.lua'
room_22 = 'assets/tilemaps/room_22.lua'
room_23 = 'assets/tilemaps/room_23.lua'
room_24 = 'assets/tilemaps/room_24.lua'
room_25 = 'assets/tilemaps/room_25.lua'

rooms = {
    room_1, room_2, room_3, room_4, room_5, 
    room_6, room_7, room_8, room_9, room_10,
    room_11, room_12, room_13, room_14, room_15,
    room_16, room_17, room_18, room_19, room_20,
    room_21, room_22, room_23, room_24, room_25
}

currentRoom = 23

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
    --print(currentRoom)

    if Player.y <= 62 and Player.direction == 'up' then
        direct = 'up'
        changing_room = true

    elseif Player.y >= 226 and Player.direction == 'down' then
        direct = 'down'
        changing_room = true

    elseif Player.x <= 6 and Player.direction == 'left' then
        direct = 'left'
        changing_room = true
    elseif Player.x >= 250 and Player.direction == 'right'then
        direct = 'right'
        changing_room = true
    end

    -- Prevents player to move when the room is changing
    if changing_room then
        nextRoom(direct)
        gameState = 'changingRoom'
    else
        gameState = 'running'
    end
end

function Map:draw()
    tmpmap:draw(tmpMapX, tmpMapY)
    map:draw(mapX, mapY)
end

function nextRoom(direction)

    local nxRoom
    if direction == 'up' then
        nxRoom = currentRoom - 5

    elseif direction == 'down' then
        nxRoom = currentRoom + 5

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

        if Player.y > 61 and Player.y < 227 then
            Player.y = Player.y - 4
            Player.collider:setPosition(Player.x, Player.y)
        end

        if mapY <= -168 then
            changeRoom(room)
        end

    elseif direction == 'up' then
        mapY = mapY + 4
        tmpMapY = mapY - 168

        if Player.y > 61 and Player.y < 226 then
            Player.y = Player.y + 4
            Player.collider:setPosition(Player.x, Player.y)
        end

        if mapY >= 168 then
            changeRoom(room)
        end

    elseif direction == 'right' then
        mapX = mapX - 4
        tmpMapX = mapX + 256

        if Player.x > 5 and Player.x < 251 then
            Player.x = Player.x - 4
            Player.collider:setPosition(Player.x, Player.y)
        end

        if mapX <= -256 then
            changeRoom(room)
        end

    elseif direction == 'left' then
        mapX = mapX + 4
        tmpMapX = mapX - 256

        if Player.x > 5 and Player.x < 251 then
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