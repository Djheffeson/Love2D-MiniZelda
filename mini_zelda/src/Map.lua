Map = Class{}

room_1 = 'assets/tilemaps/overworld/room_1.lua'
room_2 = 'assets/tilemaps/overworld/room_2.lua'
room_3 = 'assets/tilemaps/overworld/room_3.lua'
room_4 = 'assets/tilemaps/overworld/room_4.lua'
room_5 = 'assets/tilemaps/overworld/room_5.lua'
room_6 = 'assets/tilemaps/overworld/room_6.lua'
room_7 = 'assets/tilemaps/overworld/room_7.lua'
room_8 = 'assets/tilemaps/overworld/room_8.lua'
room_9 = 'assets/tilemaps/overworld/room_9.lua'
room_10 = 'assets/tilemaps/overworld/room_10.lua'
room_11 = 'assets/tilemaps/overworld/room_11.lua'
room_12 = 'assets/tilemaps/overworld/room_12.lua'
room_13 = 'assets/tilemaps/overworld/room_13.lua'
room_14 = 'assets/tilemaps/overworld/room_14.lua'
room_15 = 'assets/tilemaps/overworld/room_15.lua'
room_16 = 'assets/tilemaps/overworld/room_16.lua'
room_17 = 'assets/tilemaps/overworld/room_17.lua'
room_18 = 'assets/tilemaps/overworld/room_18.lua'
room_19 = 'assets/tilemaps/overworld/room_19.lua'
room_20 = 'assets/tilemaps/overworld/room_20.lua'
room_21 = 'assets/tilemaps/overworld/room_21.lua'
room_22 = 'assets/tilemaps/overworld/room_22.lua'
room_23 = 'assets/tilemaps/overworld/room_23.lua'
room_24 = 'assets/tilemaps/overworld/room_24.lua'
room_25 = 'assets/tilemaps/overworld/room_25.lua'

overworldRooms = {
    room_1, room_2, room_3, room_4, room_5, 
    room_6, room_7, room_8, room_9, room_10,
    room_11, room_12, room_13, room_14, room_15,
    room_16, room_17, room_18, room_19, room_20,
    room_21, room_22, room_23, room_24, room_25
}

currentOverworldRoom = 3

dRoom_1 = nil
dRoom_2 = nil
dRoom_3 = nil
dRoom_4 = nil
dRoom_5 = 'assets/tilemaps/dungeon_1/room_5.lua'
dRoom_6 = 'assets/tilemaps/dungeon_1/room_6.lua'
dRoom_7 = 'assets/tilemaps/dungeon_1/room_7.lua'
dRoom_8 = 'assets/tilemaps/dungeon_1/room_8.lua'
dRoom_9 = 'assets/tilemaps/dungeon_1/room_9.lua'
dRoom_10 = 'assets/tilemaps/dungeon_1/room_10.lua'
dRoom_11 = 'assets/tilemaps/dungeon_1/room_11.lua'
dRoom_12 = nil
dRoom_13 = nil
dRoom_14 = 'assets/tilemaps/dungeon_1/room_14.lua'
dRoom_15 = 'assets/tilemaps/dungeon_1/room_15.lua'
dRoom_16 = 'assets/tilemaps/dungeon_1/room_16.lua'
dRoom_17 = nil
dRoom_18 = nil
dRoom_19 = nil
dRoom_20 = nil
dRoom_21 = 'assets/tilemaps/dungeon_1/room_21.lua'
dRoom_22 = nil
dRoom_23 = nil
dRoom_24 = nil
dRoom_25 = nil
dRoom_26 = 'assets/tilemaps/dungeon_1/room_26.lua'
dRoom_27 = 'assets/tilemaps/dungeon_1/room_27.lua'
dRoom_28 = 'assets/tilemaps/dungeon_1/room_28.lua'
dRoom_29 = nil
dRoom_30 = nil

dungeon1Rooms = {
    dRoom_1, dRoom_2, dRoom_3, dRoom_4, dRoom_5, dRoom_6,
    dRoom_7, dRoom_8, dRoom_9, dRoom_10, dRoom_11, dRoom_12,
    dRoom_13, dRoom_14, dRoom_15, dRoom_16, dRoom_17, dRoom_18,
    dRoom_19, dRoom_20, dRoom_21, dRoom_22, dRoom_23, dRoom_24,
    dRoom_25, dRoom_26, dRoom_27, dRoom_28, dRoom_29, dRoom_30
}

currentDungeonRoom = 27

colliders = {}

function Map:init()

    mapX = 0
    mapY = 0 

    tmpMapX = 0
    tmpMapY = 0

    Map.type = 'overworld'

    tmpMap = sti(overworldRooms[currentOverworldRoom], { 'box2d' })
    map = sti(overworldRooms[currentOverworldRoom], { 'box2d' })

    changing_room = false
    local direct = 'up'

    createRoomCollisions()
    enemiesPerRoom()

    Map.timer = 0
    Map.timer1 = 0
end

function Map:update(dt)
    if Player.y <= 67 and love.keyboard.isDown('up') and Player.direction == 'up' then
        direct = 'up'
        changing_room = true

    elseif Player.y >= 226 and love.keyboard.isDown('down') and Player.direction == 'down' then
        direct = 'down'
        changing_room = true

    elseif Player.x <= 11 and love.keyboard.isDown('left') and Player.direction == 'left' then
        direct = 'left'
        changing_room = true
    elseif Player.x >= 247 and love.keyboard.isDown('right') and Player.direction == 'right' then
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
        if Map.timer1 >= 0.25 then
            gameState = 'running'
        end
        Map.timer = 0
    end
end

function Map:draw()
    if gameState == 'changingRoom' then
        tmpMap:draw(tmpMapX, tmpMapY+56)
    end
    map:draw(mapX, mapY+56)
end

function changeMap(type_map)
    Map.type = type_map
    if type_map == 'overworld' then
        map = sti(overworldRooms[currentOverworldRoom], { 'box2d' })
        deleteRoomCollisions()
        createRoomCollisions()
        deleteAllEntities()
        enemiesPerRoom()
        Player.collider:setPosition(123, 128)
    end

    if type_map == 'dungeon_1' then
        map = sti(dungeon1Rooms[currentDungeonRoom], { 'box2d' })
        deleteRoomCollisions()
        createRoomCollisions()
        deleteAllEntities()
        doorsSpawn()
        Player.collider:setPosition(128, 202)
    end
end

function nextRoom(direction)

    local nxRoom
    if Map.type == 'overworld' then
        if direction == 'up' then
            nxRoom = currentOverworldRoom - 5

        elseif direction == 'down' then
            nxRoom = currentOverworldRoom + 5

        elseif direction == 'left' then
            nxRoom = currentOverworldRoom - 1

        elseif direction == 'right' then
            nxRoom = currentOverworldRoom + 1
        end

    elseif Map.type == 'dungeon_1' then
        if direction == 'up' then
            nxRoom = currentDungeonRoom - 6

        elseif direction == 'down' then
            nxRoom = currentDungeonRoom + 6

        elseif direction == 'left' then
            nxRoom = currentDungeonRoom - 1

        elseif direction == 'right' then
            nxRoom = currentDungeonRoom + 1
        end
    end
    deleteAllEntities()
    deleteItems()
    moveRoom(nxRoom, direction)
end

function moveRoom(room, direction)
    deleteRoomCollisions()
    local speed
    if Map.type == 'overworld' then
        tmpMap = sti(overworldRooms[room], { 'box2d' })
        speed = 4
    elseif Map.type == 'dungeon_1' then
        tmpMap = sti(dungeon1Rooms[room], { 'box2d' })
        speed = 2
        createTmpDoors(room)
    end

    tmpMapX = 0
    tmpMapY = 0

    if direction == 'down' then
        for i = 1, speed, 1 do
            mapY = mapY - 1
            tmpMapY = mapY + 168
            
            if Player.y >= 66 then
                Player.y = Player.y - 1
                Player.collider:setPosition(Player.x, Player.y)
            end

            if Map.type == 'dungeon_1' then
                for i, door in ipairs(currentDoors) do
                    door.y = door.y - 1
                end

                for i, door in ipairs(tmpDoors) do
                    door.y = door.y - 1
                end
            end

            if mapY <= -168 then
                changeRoom(room)
            end
        end

    elseif direction == 'up' then
        for i = 1, speed, 1 do
            mapY = mapY + 1
            tmpMapY = mapY - 168

            if Player.y <= 225 then
                Player.y = Player.y + 1
                Player.collider:setPosition(Player.x, Player.y)
            end

            if Map.type == 'dungeon_1' then
                for i, door in ipairs(currentDoors) do
                    door.y = door.y + 1
                end

                for i, door in ipairs(tmpDoors) do
                    door.y = door.y + 1
                end
            end

            if mapY >= 168 then
                changeRoom(room)
            end
        end

    elseif direction == 'right' then
        for i = 1, speed, 1 do
            mapX = mapX - 1
            tmpMapX = mapX + 256

            if Player.x >= 8 then
                Player.x = Player.x - 1
                Player.collider:setPosition(Player.x, Player.y)
            end

            if Map.type == 'dungeon_1' then
                for i, door in ipairs(currentDoors) do
                    door.x = door.x - 1
                end

                for i, door in ipairs(tmpDoors) do
                    door.x = door.x - 1
                end
            end

            if mapX <= -256 then
                changeRoom(room)
            end
        end

    elseif direction == 'left' then
        for i = 1, speed, 1 do
            mapX = mapX + 1
            tmpMapX = mapX - 256

            if player.x <= 249 then
                Player.x = Player.x + 1
                Player.collider:setPosition(Player.x, Player.y)
            end

            if Map.type == 'dungeon_1' then
                for i, door in ipairs(currentDoors) do
                    door.x = door.x + 1
                end

                for i, door in ipairs(tmpDoors) do
                    door.x = door.x + 1
                end
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
    
    if Map.type == 'overworld' then
        currentOverworldRoom = room
        map = sti(overworldRooms[currentOverworldRoom], { 'box2d' })
    elseif Map.type == 'dungeon_1' then
        currentDungeonRoom = room
        map = sti(dungeon1Rooms[currentDungeonRoom], { 'box2d' })
    end
    
    deleteRoomCollisions()
    createRoomCollisions()
    enemiesPerRoom()

    if Map.type == 'dungeon_1' then
        clearDoors()
        doorsSpawn()
    end
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
    clearDoorsCollisions()
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

            if tileID == 9 and Map.type == 'dungeon_1' then
                return 'dungeon_brick'
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
    else
        return 'none'
    end
end
