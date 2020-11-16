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

-- red octorok = 1
-- blue octorok = 2
-- zora = 3

enemies_room = {
    {0, 0, 0}, {0, 0, 0}, {1, 0, 0}, {3, 1, 1}, {0, 0, 0},
    {0, 0, 0}, {0, 0, 1}, {0, 0, 1}, {0, 0, 1}, {5, 1, 0},
    {1, 0, 1}, {4, 0, 1}, {4, 0, 0}, {4, 0, 0}, {0, 0, 1},
    {4, 0, 1}, {4, 0, 0}, {4, 0, 0}, {4, 0, 0}, {4, 0, 1},
    {0, 0, 1}, {0, 0, 0}, {0, 0, 0}, {4, 0, 0}, {0, 0, 0}
}

currentRoom = 22

colliders = {}

function Map:init()

    mapX = 0
    mapY = 0 

    tmpMapX = 0
    tmpMapY = 0

    tmpMap = sti(rooms[currentRoom], { 'box2d' })
    map = sti(rooms[currentRoom], { 'box2d' })

    changing_room = false
    local direct = 'up'

    createRoomCollisions()
    enemiesPerRoom()

    Map.timer = 0
    Map.timer1 = 0
end

function Map:update(dt)

    if Player.y <= 67 and Player.direction == 'up' then
        direct = 'up'
        changing_room = true

    elseif Player.y >= 226 and Player.direction == 'down' then
        direct = 'down'
        changing_room = true

    elseif Player.x <= 11 and Player.direction == 'left' then
        direct = 'left'
        changing_room = true
    elseif Player.x >= 247 and Player.direction == 'right' then
        direct = 'right'
        changing_room = true
    end

    -- Prevents player to move when the room is changing
    if changing_room then
        gameState = 'changingRoom'
        Map.timer = Map.timer + 1 * dt
        if Map.timer >= 0.5 then
            nextRoom(direct)
        end
        Map.timer1 = 0
    else
        Map.timer1 = Map.timer1 + 1 * dt
        if Map.timer1 >= 0.15 then
            gameState = 'running'
        end
        Map.timer = 0
    end
end

function Map:draw()
    tmpMap:draw(tmpMapX, tmpMapY+56)
    map:draw(mapX, mapY+56)
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
    deleteAllEntities()
    deleteItems()
    moveRoom(nxRoom, direction)
end

function moveRoom(room, direction)
    deleteRoomCollisions()
    tmpMap = sti(rooms[room], { 'box2d' })

    tmpMapX = 0
    tmpMapY = 0

    if direction == 'down' then
        for i = 1, 4, 1 do
            mapY = mapY - 1
            tmpMapY = mapY + 168

            if Player.y >= 66 then
                Player.y = Player.y - 1
                Player.collider:setPosition(Player.x, Player.y)
            end

            if mapY <= -168 then
                changeRoom(room)
            end
        end

    elseif direction == 'up' then
        for i = 1, 4, 1 do
            mapY = mapY + 1
            tmpMapY = mapY - 168

            if Player.y <= 225 then
                Player.y = Player.y + 1
                Player.collider:setPosition(Player.x, Player.y)
            end

            if mapY >= 168 then
                changeRoom(room)
            end
        end

    elseif direction == 'right' then
        for i = 1, 4, 1 do
            mapX = mapX - 1
            tmpMapX = mapX + 256

            if Player.x >= 8 then
                Player.x = Player.x - 1
                Player.collider:setPosition(Player.x, Player.y)
            end

            if mapX <= -256 then
                changeRoom(room)
            end
        end

    elseif direction == 'left' then
        for i = 1, 4, 1 do
            mapX = mapX + 1
            tmpMapX = mapX - 256

            if player.x <= 249 then
                Player.x = Player.x + 1
                Player.collider:setPosition(Player.x, Player.y)
            end
            
            if mapX >= 256 then
                changeRoom(room)
            end
        end
    end
end


function changeRoom(room)
    changing_room = false
    mapX = 0
    mapY = 0 

    currentRoom = room
    map = sti(rooms[currentRoom], { 'box2d' })
    
    deleteRoomCollisions()
    createRoomCollisions()

    enemiesPerRoom()
end

function createRoomCollisions()
    collideLayer = map.layers[4].objects
    for i, j in pairs(collideLayer) do
        -- Get the X and Y of the object for collide
        local collideObjectX = map.layers[4].objects[i].x
        local collideObjectY = map.layers[4].objects[i].y
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

function checkLayer(layer, x, y)
    local x = math.floor(x)
    local y = math.floor(y)

    if map.layers[layer].data[y-3][x] ~= nil then
        local tileID = map.layers[layer].data[y-3][x].gid

        if layer == 'Ground_layer' then
            if tileID == 3 then
                return 'sand'
            end

        elseif layer == 'Water_layer' then
            watersID = {
                73, 74, 75, 78, 79, 80,
                91, 92, 93, 97, 98, 99,
                109, 110, 111, 115, 116, 117
            }
            for i = 1, #watersID, 1 do
                if watersID[i] == tileID then
                    return 'water'
                end
            end
        end
    end
end
